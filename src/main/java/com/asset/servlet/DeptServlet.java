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
                req.setAttribute("deptTreeList", deptService.buildDeptTreeList());
                req.setAttribute("pageTitle", "部门管理");
                req.getRequestDispatcher("/views/dept/list.jsp").forward(req, resp);
                break;
            case "/add":
                req.setAttribute("deptTreeList", deptService.buildDeptTreeList());
                req.setAttribute("pageTitle", "部门管理");
                String error = req.getParameter("error");
                if ("duplicate_code".equals(error)) {
                    req.setAttribute("errorMsg", "部门编码已存在，请使用其他编码");
                } else if ("validate".equals(error)) {
                    String msg = req.getParameter("msg");
                    req.setAttribute("errorMsg", msg != null ? msg : "输入信息校验失败");
                }
                req.getRequestDispatcher("/views/dept/add.jsp").forward(req, resp);
                break;
            case "/edit":
                req.setAttribute("dept", deptService.findById(parseInt(req.getParameter("id"))));
                req.setAttribute("deptTreeList", deptService.buildDeptTreeList());
                req.setAttribute("pageTitle", "部门管理");
                req.getRequestDispatcher("/views/dept/edit.jsp").forward(req, resp);
                break;
            case "/delete":
                boolean deleted = deptService.delete(parseInt(req.getParameter("id")));
                if (!deleted) {
                    req.setAttribute("deleteError", "该部门下存在子部门，无法删除");
                }
                req.setAttribute("deptTreeList", deptService.buildDeptTreeList());
                req.setAttribute("pageTitle", "部门管理");
                req.getRequestDispatcher("/views/dept/list.jsp").forward(req, resp);
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

            String error = deptService.validate(dept);
            if (error != null) {
                resp.sendRedirect(req.getContextPath() + "/dept/add?error=validate&msg=" + java.net.URLEncoder.encode(error, "UTF-8"));
                return;
            }

            try {
                deptService.save(dept);
            } catch (Exception e) {
                resp.sendRedirect(req.getContextPath() + "/dept/add?error=duplicate_code");
                return;
            }
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