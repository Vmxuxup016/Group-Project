package com.asset.service;

import com.asset.dao.AssetCategoryDao;
import com.asset.dao.AssetDao;
import com.asset.dao.DepartmentDao;
import com.asset.dao.SupplierDao;
import com.asset.pojo.Asset;
import com.asset.pojo.PageBean;
import com.asset.util.CodeGenerator;

import java.math.BigDecimal;
import java.util.HashMap;
import java.util.Map;

public class AssetService {

    private AssetDao assetDao = new AssetDao();
    private AssetCategoryDao categoryDao = new AssetCategoryDao();
    private DepartmentDao deptDao = new DepartmentDao();
    private SupplierDao supplierDao = new SupplierDao();

    public PageBean<Asset> findByPage(String keyword, Integer status, Integer categoryId,
                                      Integer deptId, int pageNum, int pageSize) {
        int total = assetDao.count(keyword, status, categoryId, deptId);
        PageBean<Asset> page = new PageBean<>(pageNum, pageSize, total);
        page.setList(assetDao.findList(keyword, status, categoryId, deptId,
                page.getOffset(), page.getPageSize()));
        return page;
    }

    public Asset findById(Integer id) {
        return assetDao.findById(id);
    }

    public void save(Asset asset) {
        asset.setAssetCode(CodeGenerator.generateAssetCode());
        if (asset.getCurrentValue() == null) {
            asset.setCurrentValue(asset.getPurchasePrice() != null ? asset.getPurchasePrice() : BigDecimal.ZERO);
        }
        if (asset.getStatus() == null) {
            asset.setStatus(asset.getDepartmentId() != null ? 2 : 1);
        }
        if (asset.getCategoryId() != null) {
            com.asset.pojo.AssetCategory cat = categoryDao.findById(asset.getCategoryId());
            if (cat != null && cat.getDepreciableLife() != null) {
                asset.setDepreciableMonths(cat.getDepreciableLife());
            }
        }
        if (asset.getDepreciableMonths() == null) {
            asset.setDepreciableMonths(36);
        }
        if (asset.getDepreciatedMonths() == null) {
            asset.setDepreciatedMonths(0);
        }
        if (asset.getDepreciableStartDate() == null && asset.getPurchaseDate() != null) {
            asset.setDepreciableStartDate(asset.getPurchaseDate());
        }
        assetDao.save(asset);
    }

    public void update(Asset asset) {
        assetDao.update(asset);
    }

    public void delete(Integer id) {
        assetDao.delete(id);
    }

    public Map<String, Object> getAddFormData() {
        Map<String, Object> data = new HashMap<>();
        data.put("categoryList", categoryDao.findAll());
        data.put("deptList", deptDao.findAll());
        data.put("supplierList", supplierDao.findActive());
        return data;
    }
}
