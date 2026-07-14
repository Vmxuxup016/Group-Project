package com.asset.servlet;

import com.asset.pojo.AssetCategory;
import com.asset.service.CategoryService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/category/*")
public class CategoryServlet extends HttpServlet {

    private CategoryService categoryService = new CategoryService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String path = req.getPathInfo();
        if (path == null) path = "/list";

        switch (path) {
            case "/list":
                req.setAttribute("categoryList", categoryService.findAll());
                req.getRequestDispatcher("/views/category/list.jsp").forward(req, resp);
                break;
            case "/add":
                req.setAttribute("categoryList", categoryService.findAll());
                req.getRequestDispatcher("/views/category/add.jsp").forward(req, resp);
                break;
            case "/edit":
                Integer id = parseInt(req.getParameter("id"));
                req.setAttribute("category", categoryService.findById(id));
                req.getRequestDispatcher("/views/category/edit.jsp").forward(req, resp);
                break;
            case "/delete":
                boolean success = categoryService.delete(parseInt(req.getParameter("id")));
                if (!success) {
                    resp.sendRedirect(req.getContextPath() + "/category/list?error=has_children");
                } else {
                    resp.sendRedirect(req.getContextPath() + "/category/list");
                }
                break;
            default:
                resp.sendRedirect(req.getContextPath() + "/category/list");
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String path = req.getPathInfo();
        req.setCharacterEncoding("UTF-8");
        if ("/save".equals(path)) {
            AssetCategory cat = new AssetCategory();
            cat.setParentId(parseInt(req.getParameter("parentId"), 0));
            cat.setCategoryName(req.getParameter("categoryName"));
            cat.setCategoryCode(req.getParameter("categoryCode"));
            cat.setCategoryLevel(parseInt(req.getParameter("categoryLevel"), 1));
            cat.setDepreciableLife(parseInt(req.getParameter("depreciableLife"), 36));
            cat.setSortOrder(parseInt(req.getParameter("sortOrder"), 0));
            categoryService.save(cat);
        } else if ("/update".equals(path)) {
            AssetCategory cat = new AssetCategory();
            cat.setId(parseInt(req.getParameter("id")));
            cat.setParentId(parseInt(req.getParameter("parentId"), 0));
            cat.setCategoryName(req.getParameter("categoryName"));
            cat.setCategoryCode(req.getParameter("categoryCode"));
            cat.setCategoryLevel(parseInt(req.getParameter("categoryLevel"), 1));
            cat.setDepreciableLife(parseInt(req.getParameter("depreciableLife"), 36));
            cat.setSortOrder(parseInt(req.getParameter("sortOrder"), 0));
            categoryService.update(cat);
        }
        resp.sendRedirect(req.getContextPath() + "/category/list");
    }

    private Integer parseInt(String str) { return parseInt(str, null); }
    private Integer parseInt(String str, Integer def) {
        if (str == null || str.isEmpty()) return def;
        try { return Integer.parseInt(str); } catch (Exception e) { return def; }
    }
}