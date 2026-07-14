package com.asset.servlet;

import com.asset.service.SupplierService;
import com.asset.pojo.Supplier;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/supplier/*")
public class SupplierServlet extends HttpServlet {

    private SupplierService supplierService = new SupplierService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String path = req.getPathInfo();
        if (path == null) path = "/list";

        switch (path) {
            case "/list":
                req.setAttribute("supplierList", supplierService.findAll());
                req.getRequestDispatcher("/views/supplier/list.jsp").forward(req, resp);
                break;
            case "/edit":
                req.setAttribute("supplier", supplierService.findById(parseInt(req.getParameter("id"))));
                req.getRequestDispatcher("/views/supplier/edit.jsp").forward(req, resp);
                break;
            case "/delete":
                supplierService.delete(parseInt(req.getParameter("id")));
                resp.sendRedirect(req.getContextPath() + "/supplier/list");
                break;
            default:
                resp.sendRedirect(req.getContextPath() + "/supplier/list");
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String path = req.getPathInfo();
        req.setCharacterEncoding("UTF-8");
        if ("/save".equals(path)) {
            Supplier s = new Supplier();
            s.setSupplierName(req.getParameter("supplierName"));
            s.setContactPerson(req.getParameter("contactPerson"));
            s.setPhone(req.getParameter("phone"));
            s.setAddress(req.getParameter("address"));
            s.setStatus(parseInt(req.getParameter("status"), 1));
            supplierService.save(s);
        } else if ("/update".equals(path)) {
            Supplier s = new Supplier();
            s.setId(parseInt(req.getParameter("id")));
            s.setSupplierName(req.getParameter("supplierName"));
            s.setContactPerson(req.getParameter("contactPerson"));
            s.setPhone(req.getParameter("phone"));
            s.setAddress(req.getParameter("address"));
            s.setStatus(parseInt(req.getParameter("status"), 1));
            supplierService.update(s);
        }
        resp.sendRedirect(req.getContextPath() + "/supplier/list");
    }

    private Integer parseInt(String str) { return parseInt(str, null); }
    private Integer parseInt(String str, Integer def) {
        if (str == null || str.isEmpty()) return def;
        try { return Integer.parseInt(str); } catch (Exception e) { return def; }
    }
}
