package com.asset.service;

import com.asset.dao.UserDao;
import com.asset.pojo.User;
import com.asset.util.MD5Util;

public class LoginService {

    private UserDao userDao = new UserDao();

    public User login(String username, String password) {
        User user = userDao.findByUsername(username);
        if (user == null) {
            return null;
        }
        if (user.getStatus() != null && user.getStatus() == 0) {
            return null;
        }
        String encryptedPassword = MD5Util.md5(password);
        if (!encryptedPassword.equals(user.getPassword())) {
            return null;
        }
        return user;
    }
}