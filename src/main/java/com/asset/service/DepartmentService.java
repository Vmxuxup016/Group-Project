package com.asset.service;

import com.asset.dao.DepartmentDao;
import com.asset.pojo.Department;

import java.util.List;

public class DepartmentService {

    private DepartmentDao deptDao = new DepartmentDao();

    public List<Department> findAll() {
        return deptDao.findAll();
    }

    public Department findById(Integer id) {
        return deptDao.findById(id);
    }

    public void save(Department dept) {
        deptDao.save(dept);
    }

    public void update(Department dept) {
        deptDao.update(dept);
    }

    public boolean delete(Integer id) {
        int childCount = deptDao.countByParentId(id);
        if (childCount > 0) {
            return false;
        }
        deptDao.delete(id);
        return true;
    }
}
