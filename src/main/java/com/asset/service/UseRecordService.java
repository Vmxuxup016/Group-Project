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
            record.setReturnStatus(record.getOperationType() == 2 ? 1 : 0);
        }
        if (record.getApprovalStatus() == null) {
            record.setApprovalStatus(0);
        }
        useRecordDao.save(record);

        if (record.getOperationType() == 1) {
            // 领用：资产从在库 → 部门在用
            Asset asset = assetDao.findById(record.getAssetId());
            if (asset != null) {
                asset.setDepartmentId(record.getToDeptId());
                asset.setStatus(2);
                assetDao.update(asset);
            }
        } else if (record.getOperationType() == 2) {
            // 归还：资产从部门在用 → 在库
            Asset asset = assetDao.findById(record.getAssetId());
            if (asset != null) {
                asset.setDepartmentId(null);
                asset.setStatus(1);
                assetDao.update(asset);
            }
            // 同步更新原领用记录的归还状态，避免列表仍显示"未归还"
            List<AssetUseRecord> unreturned = useRecordDao.findUnreturnedByAssetId(record.getAssetId());
            for (AssetUseRecord r : unreturned) {
                if (r.getOperationType() == 1 && r.getReturnStatus() == 0) {
                    useRecordDao.updateReturn(r.getId(), record.getReturnStatus() != null ? record.getReturnStatus() : 1,
                            record.getUseDate());
                }
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
            // 同步创建归还记录，与归还登记保持一致
            AssetUseRecord returnRecord = new AssetUseRecord();
            returnRecord.setAssetId(record.getAssetId());
            returnRecord.setOperationType(2);
            returnRecord.setFromDeptId(record.getToDeptId());
            returnRecord.setToDeptId(0);
            returnRecord.setUseDate(actualReturnDate);
            returnRecord.setReturnStatus(returnStatus != null ? returnStatus : 1);
            returnRecord.setApprovalStatus(0);
            returnRecord.setOperatorId(record.getOperatorId());
            returnRecord.setPurpose("快速归还");
            useRecordDao.save(returnRecord);
        }
    }

    public Map<String, Object> getAddFormData(String type, Integer assetId) {
        Map<String, Object> data = new HashMap<>();
        data.put("type", type);
        data.put("deptList", deptDao.findAll());
        if (assetId != null) {
            data.put("asset", assetDao.findById(assetId));
        }
        // 根据操作类型加载可选资产：领用→在库(1)，归还→部门在用(2)
        Integer filterStatus = "1".equals(type) ? 1 : ("2".equals(type) ? 2 : null);
        data.put("assetList", assetDao.findList(null, filterStatus, null, null, 0, 1000));
        return data;
    }
}
