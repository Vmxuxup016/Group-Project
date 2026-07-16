package com.asset.servlet;

import com.asset.pojo.AssetPurchase;
import com.asset.pojo.AssetPurchaseItem;
import com.asset.service.PurchaseService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet("/purchase/*")
public class PurchaseServlet extends HttpServlet {

    private PurchaseService purchaseService = new PurchaseService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String path = req.getPathInfo();
        if (path == null) path = "/list";

        switch (path) {
            case "/list":
                req.setAttribute("purchaseList", purchaseService.findAll());
                req.setAttribute("pageTitle", "采购入库");
                req.getRequestDispatcher("/views/purchase/list.jsp").forward(req, resp);
                break;
            case "/detail":
                Integer id = parseInt(req.getParameter("id"));
                req.setAttribute("purchase", purchaseService.findById(id));
                req.setAttribute("purchaseItems", purchaseService.findItemsByPurchaseId(id));
                req.setAttribute("pageTitle", "采购入库");
                req.getRequestDispatcher("/views/purchase/detail.jsp").forward(req, resp);
                break;
            case "/add":
                Map<String, Object> data = purchaseService.getFormData();
                for (Map.Entry<String, Object> e : data.entrySet()) req.setAttribute(e.getKey(), e.getValue());
                req.setAttribute("pageTitle", "采购入库");
                req.getRequestDispatcher("/views/purchase/add.jsp").forward(req, resp);
                break;
            default:
                resp.sendRedirect(req.getContextPath() + "/purchase/list");
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        req.setCharacterEncoding("UTF-8");
        String path = req.getPathInfo();
        if (path == null) path = "";

        switch (path) {
            case "/save":
                savePurchase(req, resp);
                break;
            case "/in":
                doInbound(req, resp);
                break;
            default:
                resp.sendRedirect(req.getContextPath() + "/purchase/list");
        }
    }

    private void savePurchase(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        AssetPurchase purchase = new AssetPurchase();
        purchase.setSupplierId(parseInt(req.getParameter("supplierId")));
        purchase.setPurchaseDate(req.getParameter("purchaseDate"));
        purchase.setInvoiceNo(req.getParameter("invoiceNo"));
        purchase.setRemark(req.getParameter("remark"));
        purchase.setCreateBy(1);

        String[] names = req.getParameterValues("itemNames");
        String[] categoryIds = req.getParameterValues("categoryIds");
        String[] brands = req.getParameterValues("brands");
        String[] models = req.getParameterValues("models");
        String[] quantities = req.getParameterValues("quantities");
        String[] unitPrices = req.getParameterValues("unitPrices");
        String[] warrantyMonths = req.getParameterValues("warrantyMonths");

        List<AssetPurchaseItem> items = new ArrayList<>();
        if (names != null) {
            for (int i = 0; i < names.length; i++) {
                if (names[i] == null || names[i].trim().isEmpty()) continue;
                AssetPurchaseItem item = new AssetPurchaseItem();
                item.setAssetName(names[i].trim());
                item.setCategoryId(parseInt(categoryIds != null && i < categoryIds.length ? categoryIds[i] : null));
                item.setBrand(brands != null && i < brands.length ? brands[i] : null);
                item.setModel(models != null && i < models.length ? models[i] : null);
                item.setQuantity(parseInt(quantities != null && i < quantities.length ? quantities[i] : "1", 1));
                item.setUnitPrice(new BigDecimal(unitPrices != null && i < unitPrices.length ? unitPrices[i] : "0"));
                item.setWarrantyMonths(parseInt(warrantyMonths != null && i < warrantyMonths.length ? warrantyMonths[i] : "12", 12));
                items.add(item);
            }
        }

        if (items.isEmpty()) {
            resp.sendRedirect(req.getContextPath() + "/purchase/add?error=empty");
            return;
        }

        purchaseService.save(purchase, items);
        resp.sendRedirect(req.getContextPath() + "/purchase/list");
    }

    private void doInbound(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        Integer purchaseId = parseInt(req.getParameter("id"));
        String[] itemIds = req.getParameterValues("itemIds");
        String[] receiveQtys = req.getParameterValues("receiveQtys");

        Map<Integer, Integer> receiveMap = new HashMap<>();
        if (itemIds != null) {
            for (int i = 0; i < itemIds.length; i++) {
                int itemId = Integer.parseInt(itemIds[i]);
                int qty = parseInt(receiveQtys != null && i < receiveQtys.length ? receiveQtys[i] : "0", 0);
                if (qty > 0) {
                    receiveMap.put(itemId, qty);
                }
            }
        }

        if (!receiveMap.isEmpty()) {
            purchaseService.inbound(purchaseId, receiveMap);
        }
        resp.sendRedirect(req.getContextPath() + "/purchase/detail?id=" + purchaseId);
    }

    private Integer parseInt(String str) { return parseInt(str, null); }
    private Integer parseInt(String str, Integer def) {
        if (str == null || str.isEmpty()) return def;
        try { return Integer.parseInt(str); } catch (Exception e) { return def; }
    }
}