package com.asset.service;

import com.asset.dao.AssetCategoryDao;
import com.asset.pojo.AssetCategory;

import java.util.List;

public class CategoryService {

    private AssetCategoryDao categoryDao = new AssetCategoryDao();

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
        int childCount = categoryDao.countByParentId(id);
        if (childCount > 0) {
            return false;
        }
        categoryDao.delete(id);
        return true;
    }
}

