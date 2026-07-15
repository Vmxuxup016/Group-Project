package com.asset.service;

import com.asset.dao.AssetCategoryDao;
import com.asset.dao.AssetDao;
import com.asset.pojo.AssetCategory;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class CategoryService {

    private AssetCategoryDao categoryDao = new AssetCategoryDao();
    private AssetDao assetDao = new AssetDao();

    public List<AssetCategory> findAll() {
        return categoryDao.findAll();
    }

    public AssetCategory findById(Integer id) {
        return categoryDao.findById(id);
    }

    public void save(AssetCategory cat) {
        categoryDao.save(cat);
    }

    public void update(AssetCategory cat) {
        categoryDao.update(cat);
    }

    public boolean delete(Integer id) {
        // 检查是否有子分类
        int childCount = categoryDao.countByParentId(id);
        if (childCount > 0) {
            return false;
        }
        // 检查是否有资产引用此分类
        int assetCount = assetDao.countByCategoryId(id);
        if (assetCount > 0) {
            return false;
        }
        categoryDao.delete(id);
        return true;
    }

    // 获取每个分类的资产数量
    public Map<Integer, Integer> getAssetCountByCategory() {
        Map<Integer, Integer> result = new HashMap<>();
        List<AssetCategory> all = categoryDao.findAll();
        for (AssetCategory cat : all) {
            result.put(cat.getId(), assetDao.countByCategoryId(cat.getId()));
        }
        return result;
    }
}
