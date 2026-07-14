package com.asset.servlet;

import com.asset.pojo.AssetInventory;
import com.asset.service.InventoryService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Map;

@WebServlet("/inventory/*")
public class InventoryServlet extends HttpServlet {

    private InventoryService inventoryService = new InventoryService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String path = req.getPathInfo();
        if (path == null) path = "/list";

        switch (path) {
            case "/list":
                Map<String, Object> stats = inventoryService.getStats();
                for (Map.Entry<String, Object> e : stats.entrySet()) req.setAttribute(e.getKey(), e.getValue());
                req.setAttribute("inventoryList", inventoryService.findAll());
                req.getRequestDispatcher("/views/inventory/list.jsp").forward(req, resp);
                break;
            case "/detail":
                Integer id = parseInt(req.getParameter("id"));
                req.setAttribute("inventory", inventoryService.findById(id));
                req.setAttribute("details", inventoryService.findDetailsByInventoryId(id));
                req.getRequestDispatcher("/views/inventory/detail.jsp").forward(req, resp);
                break;
            case "/scan":
                Integer sid = parseInt(req.getParameter("id"));
                inventoryService.startInventory(sid);
                resp.sendRedirect(req.getContextPath() + "/inventory/list");
                break;
            default:
                resp.sendRedirect(req.getContextPath() + "/inventory/list");
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        req.setCharacterEncoding("UTF-8");
        AssetInventory inv = new AssetInventory();
        inv.setInventoryName(req.getParameter("inventoryName"));
        inv.setInventoryType(parseInt(req.getParameter("inventoryType"), 1));
        inv.setScopeIds(req.getParameter("scopeIds"));
        inv.setPlanDate(req.getParameter("planDate"));
        inv.setInventoryMethod(parseInt(req.getParameter("inventoryMethod"), 1));
        inv.setOperatorId(parseInt(req.getParameter("operatorId"), 1));
        inv.setRemark(req.getParameter("remark"));
        inventoryService.save(inv);
        resp.sendRedirect(req.getContextPath() + "/inventory/list");
    }

    private Integer parseInt(String str) { return parseInt(str, null); }
    private Integer parseInt(String str, Integer def) {
        if (str == null || str.isEmpty()) return def;
        try { return Integer.parseInt(str); } catch (Exception e) { return def; }
    }
}