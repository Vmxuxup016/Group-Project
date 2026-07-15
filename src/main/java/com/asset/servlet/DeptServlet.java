package com.asset.servlet;

import com.asset.pojo.Department;
import com.asset.service.DepartmentService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/dept/*")
public class DeptServlet extends HttpServlet {

    private DepartmentService deptService = new DepartmentService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String path = req.getPathInfo();
        if (path == null) path = "/list";

        switch (path) {
            case "/list":
                req.setAttribute("deptList", deptService.findAll());
                req.getRequestDispatcher("/views/dept/list.jsp").forward(req, resp);
                break;
            case "/add":
                req.setAttribute("deptList", deptService.findAll());
                req.getRequestDispatcher("/views/dept/add.jsp").forward(req, resp);
                break;
            case "/edit":
                req.setAttribute("dept", deptService.findById(parseInt(req.getParameter("id"))));
                req.setAttribute("deptList", deptService.findAll());
                req.getRequestDispatcher("/views/dept/edit.jsp").forward(req, resp);
                break;
            case "/delete":
                deptService.delete(parseInt(req.getParameter("id")));
                resp.sendRedirect(req.getContextPath() + "/dept/list");
                break;
            default:
                resp.sendRedirect(req.getContextPath() + "/dept/list");
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String path = req.getPathInfo();
        req.setCharacterEncoding("UTF-8");
        if ("/save".equals(path)) {
            Department dept = new Department();
            dept.setParentId(parseInt(req.getParameter("parentId"), 0));
            dept.setDeptName(req.getParameter("deptName"));
            dept.setDeptCode(req.getParameter("deptCode"));
            dept.setSortOrder(parseInt(req.getParameter("sortOrder"), 0));
            deptService.save(dept);
        } else if ("/update".equals(path)) {
            Department dept = new Department();
            dept.setId(parseInt(req.getParameter("id")));
            dept.setParentId(parseInt(req.getParameter("parentId"), 0));
            dept.setDeptName(req.getParameter("deptName"));
            dept.setDeptCode(req.getParameter("deptCode"));
            dept.setSortOrder(parseInt(req.getParameter("sortOrder"), 0));
            deptService.update(dept);
        }
        resp.sendRedirect(req.getContextPath() + "/dept/list");
    }

    private Integer parseInt(String str) { return parseInt(str, null); }
    private Integer parseInt(String str, Integer def) {
        if (str == null || str.isEmpty()) return def;
        try { return Integer.parseInt(str); } catch (Exception e) { return def; }
    }
}