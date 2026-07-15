package com.asset.service;

import com.asset.dao.AssetRfidTagDao;
import com.asset.pojo.AssetRfidTag;

import java.util.List;

public class RfidService {

    private AssetRfidTagDao rfidTagDao = new AssetRfidTagDao();

    public List<AssetRfidTag> findAll() {
        return rfidTagDao.findAll();
    }

    public AssetRfidTag findById(Integer id) {
        return rfidTagDao.findById(id);
    }

    public void save(AssetRfidTag tag) {
        if (tag.getTagStatus() == null) {
            tag.setTagStatus(3);
        }
        rfidTagDao.save(tag);
    }

    public void bind(Integer id, Integer assetId) {
        rfidTagDao.bind(id, assetId);
    }

    public void unbind(Integer id) {
        rfidTagDao.unbind(id);
    }

    public void delete(Integer id) {
        rfidTagDao.delete(id);
    }

    public void updateScanInfo(Integer id, String location) {
        rfidTagDao.updateScanInfo(id, location);
    }

    public void updateStatus(Integer id, Integer status) {
        rfidTagDao.updateStatus(id, status);
    }

    public void batchScan() {
        List<AssetRfidTag> tags = rfidTagDao.findAll();
        for (AssetRfidTag tag : tags) {
            if (tag.getTagStatus() != null && tag.getTagStatus() == 1) {
                rfidTagDao.updateScanInfo(tag.getId(), "批量扫描");
            }
        }
    }
}
