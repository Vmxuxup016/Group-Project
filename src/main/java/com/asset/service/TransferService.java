package com.asset.service;

import com.asset.dao.AssetUseRecordDao;
import com.asset.pojo.AssetUseRecord;

import java.util.List;

public class TransferService {

    private AssetUseRecordDao useRecordDao = new AssetUseRecordDao();

    public List<AssetUseRecord> findAll() {
        return useRecordDao.findByOperationType(3);
    }

    public AssetUseRecord findById(Integer id) {
        return useRecordDao.findById(id);
    }

    public void save(AssetUseRecord record) {
        record.setOperationType(3);
        if (record.getApprovalStatus() == null) {
            record.setApprovalStatus(1);
        }
        if (record.getReturnStatus() == null) {
            record.setReturnStatus(4);
        }
        useRecordDao.save(record);
    }

    public void approve(Integer id, boolean pass) {
        useRecordDao.updateApproval(id, pass ? 2 : 3);
    }
}
