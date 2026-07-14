package com.asset.service;

import com.asset.dao.AssetDao;
import com.asset.dao.AssetUseRecordDao;
import com.asset.dao.DepartmentDao;
import com.asset.pojo.Asset;
import com.asset.pojo.AssetUseRecord;

import java.time.LocalDate;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class UseRecordService {

    private AssetUseRecordDao useRecordDao = new AssetUseRecordDao();
    private AssetDao assetDao = new AssetDao();
    private DepartmentDao deptDao = new DepartmentDao();

    public List<AssetUseRecord> findAll() {
        return useRecordDao.findAll();
    }

    public AssetUseRecord findById(Integer id) {
        return useRecordDao.findById(id);
    }

    public List<AssetUseRecord> findByOperationType(Integer operationType) {
        return useRecordDao.findByOperationType(operationType);
    }

    public List<AssetUseRecord> findUnreturned() {
        return useRecordDao.findByReturnStatus(0);
    }

    public void save(AssetUseRecord record) {
        if (record.getReturnStatus() == null) {
            record.setReturnStatus(record.getOperationType() == 2 ? 4 : 0);
        }
        if (record.getApprovalStatus() == null) {
            record.setApprovalStatus(0);
        }
        useRecordDao.save(record);

        if (record.getOperationType() == 1) {
            Asset asset = assetDao.findById(record.getAssetId());
            if (asset != null) {
                asset.setDepartmentId(record.getToDeptId());
                asset.setStatus(2);
                assetDao.update(asset);
            }
        }
    }

    public void returnAsset(Integer recordId, Integer returnStatus, String actualReturnDate) {
        useRecordDao.updateReturn(recordId, returnStatus, actualReturnDate);

        AssetUseRecord record = useRecordDao.findById(recordId);
        if (record != null) {
            Asset asset = assetDao.findById(record.getAssetId());
            if (asset != null) {
                asset.setDepartmentId(null);
                asset.setStatus(1);
                assetDao.update(asset);
            }
        }
    }

    public Map<String, Object> getAddFormData(String type, Integer assetId) {
        Map<String, Object> data = new HashMap<>();
        data.put("type", type);
        data.put("deptList", deptDao.findAll());
        if (assetId != null) {
            data.put("asset", assetDao.findById(assetId));
        }
        return data;
    }
}
