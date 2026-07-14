package com.asset.service;

import com.asset.dao.AssetInventoryDao;
import com.asset.dao.AssetInventoryDetailDao;
import com.asset.pojo.AssetInventory;
import com.asset.pojo.AssetInventoryDetail;
import com.asset.util.CodeGenerator;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class InventoryService {

    private AssetInventoryDao inventoryDao = new AssetInventoryDao();
    private AssetInventoryDetailDao detailDao = new AssetInventoryDetailDao();

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
        inventoryDao.updateStatus(id, 2);
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
