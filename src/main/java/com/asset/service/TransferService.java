package com.asset.service;

import com.asset.dao.AssetDao;
import com.asset.dao.AssetUseRecordDao;
import com.asset.dao.DepartmentDao;
import com.asset.pojo.Asset;
import com.asset.pojo.AssetUseRecord;
import com.asset.pojo.Department;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class TransferService {

    private AssetUseRecordDao useRecordDao = new AssetUseRecordDao();
    private AssetDao assetDao = new AssetDao();
    private DepartmentDao departmentDao = new DepartmentDao();

    public List<AssetUseRecord> findAll() {
        return useRecordDao.findByOperationType(3);
    }

    public AssetUseRecord findById(Integer id) {
        return useRecordDao.findById(id);
    }

    public void save(AssetUseRecord record) {
        record.setOperationType(3);
        if (record.getApprovalStatus() == null) {
            record.setApprovalStatus(1); // 默认：审批中
        }
        if (record.getReturnStatus() == null) {
            record.setReturnStatus(4); // 无需归还
        }
        useRecordDao.save(record);

        // 将资产状态设为"调拨中"
        Asset asset = assetDao.findById(record.getAssetId());
        if (asset != null) {
            asset.setStatus(5); // 调拨中
            assetDao.update(asset);
        }
    }

    public void approve(Integer id, boolean pass) {
        int newStatus = pass ? 2 : 3; // 2=已通过, 3=驳回
        useRecordDao.updateApproval(id, newStatus);

        AssetUseRecord record = useRecordDao.findById(id);
        if (record != null && pass) {
            // 审批通过：更新资产归属部门
            Asset asset = assetDao.findById(record.getAssetId());
            if (asset != null) {
                asset.setDepartmentId(record.getToDeptId());
                asset.setStatus(2); // 部门在用
                assetDao.update(asset);
            }
        } else if (record != null && !pass) {
            // 驳回：恢复资产原状态
            Asset asset = assetDao.findById(record.getAssetId());
            if (asset != null) {
                asset.setStatus(2); // 恢复为部门在用
                assetDao.update(asset);
            }
        }
    }

    public Map<String, Object> getAddFormData() {
        Map<String, Object> data = new HashMap<>();
        // 获取可调拨的资产（部门在用状态=2，且不在调拨中）
        List<Asset> assets = assetDao.findList(null, 2, null, null, 0, 99999);
        data.put("assetList", assets);
        // 获取所有部门
        List<Department> departments = departmentDao.findAll();
        data.put("deptList", departments);
        data.put("today", LocalDate.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd")));
        return data;
    }
}
