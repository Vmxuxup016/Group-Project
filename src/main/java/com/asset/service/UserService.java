package com.asset.service;

import com.asset.dao.DepartmentDao;
import com.asset.dao.UserDao;
import com.asset.pojo.Department;
import com.asset.pojo.User;
import com.asset.util.MD5Util;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class UserService {

    private UserDao userDao = new UserDao();
    private DepartmentDao deptDao = new DepartmentDao();

    public List<User> findAll() {
        return userDao.findAll();
    }

    public User findById(Integer id) {
        return userDao.findById(id);
    }

    public void save(User user) {
        user.setPassword(MD5Util.md5(user.getPassword()));
        if (user.getStatus() == null) {
            user.setStatus(1);
        }
        userDao.save(user);
    }

    public void update(User user) {
        userDao.update(user);
    }

    public void delete(Integer id) {
        userDao.delete(id);
    }

    public Map<String, Object> getFormData() {
        Map<String, Object> data = new HashMap<>();
        data.put("deptList", deptDao.findAll());
        return data;
    }
}
