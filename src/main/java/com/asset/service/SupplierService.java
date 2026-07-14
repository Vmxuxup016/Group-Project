package com.asset.service;

import com.asset.dao.SupplierDao;
import com.asset.pojo.Supplier;

import java.util.List;

public class SupplierService {

    private SupplierDao supplierDao = new SupplierDao();

    public List<Supplier> findAll() {
        return supplierDao.findAll();
    }

    public List<Supplier> findActive() {
        return supplierDao.findActive();
    }

    public Supplier findById(Integer id) {
        return supplierDao.findById(id);
    }

    public void save(Supplier supplier) {
        supplierDao.save(supplier);
    }

    public void update(Supplier supplier) {
        supplierDao.update(supplier);
    }

    public void delete(Integer id) {
        supplierDao.delete(id);
    }
}
