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

    public String save(AssetUseRecord record) {
        if (record.getAssetId() == null) {
            return "请选择调拨资产";
        }
        Asset asset = assetDao.findById(record.getAssetId());
        if (asset == null) {
            return "资产不存在";
        }
        if (asset.getStatus() != null && asset.getStatus() == 5) {
            return "该资产正在调拨中，请勿重复提交";
        }

        List<AssetUseRecord> pending = useRecordDao.findByOperationType(3);
        for (AssetUseRecord r : pending) {
            if (record.getAssetId().equals(r.getAssetId()) && r.getApprovalStatus() != null && r.getApprovalStatus() == 1) {
                return "该资产已有待审批的调拨申请";
            }
        }

        record.setOperationType(3);
        if (record.getApprovalStatus() == null) {
            record.setApprovalStatus(1);
        }
        if (record.getReturnStatus() == null) {
            record.setReturnStatus(4);
        }

        int originalStatus = asset.getStatus();
        asset.setStatus(5);
        assetDao.update(asset);

        try {
            useRecordDao.save(record);
        } catch (Exception e) {
            asset.setStatus(originalStatus);
            assetDao.update(asset);
            return "保存调拨记录失败：" + e.getMessage();
        }

        return null;
    }

    public String approve(Integer id, boolean pass) {
        AssetUseRecord record = useRecordDao.findById(id);
        if (record == null) {
            return "调拨记录不存在";
        }
        if (record.getApprovalStatus() == null || record.getApprovalStatus() != 1) {
            return "该记录当前状态不允许审批";
        }

        Asset asset = assetDao.findById(record.getAssetId());
        if (asset == null) {
            return "关联资产不存在";
        }

        int originalStatus = asset.getStatus();
        Integer originalDeptId = asset.getDepartmentId();

        int newApprovalStatus = pass ? 2 : 3;
        useRecordDao.updateApproval(id, newApprovalStatus);

        try {
            if (pass) {
                asset.setDepartmentId(record.getToDeptId());
                asset.setStatus(2);
            } else {
                asset.setStatus(originalStatus);
            }
            assetDao.update(asset);
        } catch (Exception e) {
            useRecordDao.updateApproval(id, 1);
            asset.setStatus(originalStatus);
            asset.setDepartmentId(originalDeptId);
            assetDao.update(asset);
            return "审批操作异常，已回滚：" + e.getMessage();
        }

        return null;
    }

    public Map<String, Object> getAddFormData() {
        Map<String, Object> data = new HashMap<>();
        List<Asset> assets = assetDao.findList(null, 2, null, null, 0, 99999);
        data.put("assetList", assets);
        List<Department> departments = departmentDao.findAll();
        data.put("deptList", departments);
        data.put("today", LocalDate.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd")));
        return data;
    }
}
