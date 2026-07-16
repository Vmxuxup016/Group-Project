package com.asset.servlet;

import com.asset.pojo.User;
import com.asset.service.UserService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Map;

@WebServlet("/user/*")
public class UserServlet extends HttpServlet {

    private UserService userService = new UserService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String path = req.getPathInfo();
        if (path == null) path = "/list";

        switch (path) {
            case "/list":
                req.setAttribute("userList", userService.findAll());
                req.setAttribute("pageTitle", "用户管理");
                req.getRequestDispatcher("/views/user/list.jsp").forward(req, resp);
                break;
            case "/add":
                Map<String, Object> addData = userService.getFormData();
                for (Map.Entry<String, Object> e : addData.entrySet()) req.setAttribute(e.getKey(), e.getValue());
                req.setAttribute("pageTitle", "用户管理");
                req.getRequestDispatcher("/views/user/add.jsp").forward(req, resp);
                break;
            case "/edit":
                req.setAttribute("user", userService.findById(parseInt(req.getParameter("id"))));
                Map<String, Object> editData = userService.getFormData();
                for (Map.Entry<String, Object> e : editData.entrySet()) req.setAttribute(e.getKey(), e.getValue());
                req.setAttribute("pageTitle", "用户管理");
                req.getRequestDispatcher("/views/user/edit.jsp").forward(req, resp);
                break;
            case "/delete":
                userService.delete(parseInt(req.getParameter("id")));
                resp.sendRedirect(req.getContextPath() + "/user/list");
                break;
            default:
                resp.sendRedirect(req.getContextPath() + "/user/list");
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String path = req.getPathInfo();
        req.setCharacterEncoding("UTF-8");
        if ("/save".equals(path)) {
            User user = new User();
            user.setUsername(req.getParameter("username"));
            user.setPassword(req.getParameter("password"));
            user.setRealName(req.getParameter("realName"));
            user.setDeptId(parseInt(req.getParameter("deptId")));
            user.setRole(req.getParameter("role"));
            user.setPhone(req.getParameter("phone"));
            user.setStatus(parseInt(req.getParameter("status"), 1));
            userService.save(user);
        } else if ("/update".equals(path)) {
            User user = new User();
            user.setId(parseInt(req.getParameter("id")));
            user.setRealName(req.getParameter("realName"));
            user.setDeptId(parseInt(req.getParameter("deptId")));
            user.setRole(req.getParameter("role"));
            user.setPhone(req.getParameter("phone"));
            user.setStatus(parseInt(req.getParameter("status"), 1));
            userService.update(user);
        }
        resp.sendRedirect(req.getContextPath() + "/user/list");
    }

    private Integer parseInt(String str) { return parseInt(str, null); }
    private Integer parseInt(String str, Integer def) {
        if (str == null || str.isEmpty()) return def;
        try { return Integer.parseInt(str); } catch (Exception e) { return def; }
    }
}