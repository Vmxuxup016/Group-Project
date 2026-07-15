package com.asset.service;

import com.asset.dao.AssetDao;
import com.asset.dao.AssetInventoryDao;
import com.asset.dao.AssetInventoryDetailDao;
import com.asset.pojo.Asset;
import com.asset.pojo.AssetInventory;
import com.asset.pojo.AssetInventoryDetail;
import com.asset.util.CodeGenerator;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class InventoryService {

    private AssetInventoryDao inventoryDao = new AssetInventoryDao();
    private AssetInventoryDetailDao detailDao = new AssetInventoryDetailDao();
    private AssetDao assetDao = new AssetDao();

    public List<AssetInventory> findAll() {
        return inventoryDao.findAll();
    }

    public AssetInventory findById(Integer id) {
        return inventoryDao.findById(id);
    }

    public List<AssetInventoryDetail> findDetailsByInventoryId(Integer inventoryId) {
        return detailDao.findByInventoryId(inventoryId);
    }

    public void save(AssetInventory inventory) {
        inventory.setInventoryNo(CodeGenerator.generateInventoryNo());
        if (inventory.getStatus() == null) {
            inventory.setStatus(1);
        }
        if (inventory.getResultStatus() == null) {
            inventory.setResultStatus(0);
        }
        inventoryDao.save(inventory);
    }

    public void startInventory(Integer id) {
        AssetInventory inv = inventoryDao.findById(id);
        if (inv == null) return;

        // 幂等保护：已完成则跳过
        if (inv.getStatus() != null && inv.getStatus() == 3) return;

        // 1. 标记盘点中，清理旧明细
        inventoryDao.updateStatus(id, 2);
        String today = LocalDate.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd"));
        inventoryDao.updateStartDate(id, today);
        detailDao.deleteByInventoryId(id);

        // 2. 根据盘点类型获取资产列表
        List<Asset> assets;
        Integer type = inv.getInventoryType();
        String scopeIds = inv.getScopeIds();
        if (type == 2 && scopeIds != null && !scopeIds.isEmpty()) {
            // 按部门：逐个部门查询
            assets = new java.util.ArrayList<>();
            for (String deptId : scopeIds.split(",")) {
                try {
                    assets.addAll(assetDao.findList(null, null, null, Integer.parseInt(deptId.trim()), 0, 1000));
                } catch (Exception ignored) {}
            }
        } else if (type == 3 && scopeIds != null && !scopeIds.isEmpty()) {
            // 按分类：逐个分类查询
            assets = new java.util.ArrayList<>();
            for (String catId : scopeIds.split(",")) {
                try {
                    assets.addAll(assetDao.findList(null, null, Integer.parseInt(catId.trim()), null, 0, 1000));
                } catch (Exception ignored) {}
            }
        } else {
            // 全面盘点：所有资产
            assets = assetDao.findList(null, null, null, null, 0, 1000);
        }

        // 3. 为每个资产生成盘点明细（快照账面数据，模拟扫描全部正常）
        int normalCount = 0, abnormalCount = 0;
        for (Asset asset : assets) {
            AssetInventoryDetail detail = new AssetInventoryDetail();
            detail.setInventoryId(id);
            detail.setAssetId(asset.getId());
            detail.setBookStatus(asset.getStatus());
            detail.setBookDeptId(asset.getDepartmentId());
            detail.setBookLocation(asset.getLocation());
            // 模拟扫描：实际与账面一致
            detail.setActualStatus(1); // 正常
            detail.setActualDeptId(asset.getDepartmentId());
            detail.setActualLocation(asset.getLocation());
            detail.setRfidScanned(inv.getInventoryMethod() == 2 ? 1 : 0);
            detail.setCheckerId(inv.getOperatorId());
            detailDao.save(detail);
            normalCount++;
        }

        // 4. 完成盘点
        int result = abnormalCount > 0 ? 2 : 1; // 1=正常, 2=存在异常
        inventoryDao.complete(id, result);
    }

    public void complete(Integer id, Integer resultStatus) {
        inventoryDao.complete(id, resultStatus);
    }

    public void saveDetail(AssetInventoryDetail detail) {
        detailDao.save(detail);
    }

    public Map<String, Object> getStats() {
        Map<String, Object> stats = new HashMap<>();
        List<AssetInventory> all = inventoryDao.findAll();
        int wait = 0, inProgress = 0, done = 0;
        for (AssetInventory inv : all) {
            if (inv.getStatus() != null) {
                switch (inv.getStatus()) {
                    case 1: wait++; break;
                    case 2: inProgress++; break;
                    case 3: done++; break;
                }
            }
        }
        stats.put("waitInventory", wait);
        stats.put("inInventory", inProgress);
        stats.put("doneInventory", done);
        return stats;
    }
}
