package com.asset.servlet;

import com.asset.pojo.Asset;
import com.asset.pojo.PageBean;
import com.asset.service.AssetService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.math.BigDecimal;
import java.util.Map;

@WebServlet("/asset/*")
public class AssetServlet extends HttpServlet {

    private AssetService assetService = new AssetService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String path = req.getPathInfo();
        if (path == null) path = "/list";

        switch (path) {
            case "/list":
                list(req, resp);
                break;
            case "/search":
                list(req, resp);
                break;
            case "/add":
                add(req, resp);
                break;
            case "/edit":
                edit(req, resp);
                break;
            case "/detail":
                detail(req, resp);
                break;
            case "/delete":
                delete(req, resp);
                break;
            case "/export":
                export(req, resp);
                break;
            default:
                list(req, resp);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String path = req.getPathInfo();
        if (path == null) path = "";

        switch (path) {
            case "/save":
                save(req, resp);
                break;
            case "/update":
                update(req, resp);
                break;
            default:
                resp.sendRedirect(req.getContextPath() + "/asset/list");
        }
    }

    private void list(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String keyword = req.getParameter("keyword");
        Integer status = parseInt(req.getParameter("status"));
        Integer categoryId = parseInt(req.getParameter("categoryId"));
        Integer deptId = parseInt(req.getParameter("deptId"));
        int page = parseInt(req.getParameter("page"), 1);

        PageBean<Asset> pageInfo = assetService.findByPage(keyword, status, categoryId, deptId, page, 10);
        req.setAttribute("assetList", pageInfo.getList());
        req.setAttribute("pageInfo", pageInfo);
        Map<String, Object> filterData = assetService.getAddFormData();
        req.setAttribute("categoryList", filterData.get("categoryList"));
        req.setAttribute("deptList", filterData.get("deptList"));
        req.setAttribute("pageTitle", "资产档案");
        req.getRequestDispatcher("/views/asset/list.jsp").forward(req, resp);
    }

    private void add(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Map<String, Object> data = assetService.getAddFormData();
        for (Map.Entry<String, Object> entry : data.entrySet()) {
            req.setAttribute(entry.getKey(), entry.getValue());
        }
        String error = req.getParameter("error");
        if ("category_required".equals(error)) {
            req.setAttribute("errorMsg", "资产分类为必填项");
        } else if ("save_failed".equals(error)) {
            req.setAttribute("errorMsg", "保存失败，请检查输入信息后重试");
        }
        req.setAttribute("pageTitle", "资产档案");
        req.getRequestDispatcher("/views/asset/add.jsp").forward(req, resp);
    }

    private void edit(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Integer id = parseInt(req.getParameter("id"));
        Asset asset = assetService.findById(id);
        req.setAttribute("asset", asset);
        Map<String, Object> data = assetService.getAddFormData();
        for (Map.Entry<String, Object> entry : data.entrySet()) {
            req.setAttribute(entry.getKey(), entry.getValue());
        }
        req.setAttribute("pageTitle", "资产档案");
        req.getRequestDispatcher("/views/asset/edit.jsp").forward(req, resp);
    }

    private void detail(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Integer id = parseInt(req.getParameter("id"));
        Asset asset = assetService.findById(id);
        req.setAttribute("asset", asset);
        req.setAttribute("pageTitle", "资产档案");
        req.getRequestDispatcher("/views/asset/detail.jsp").forward(req, resp);
    }

    private void save(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        req.setCharacterEncoding("UTF-8");
        try {
            Asset asset = new Asset();
            asset.setAssetName(req.getParameter("assetName"));
            Integer categoryId = parseInt(req.getParameter("categoryId"));
            if (categoryId == null) {
                resp.sendRedirect(req.getContextPath() + "/asset/add?error=category_required");
                return;
            }
            asset.setCategoryId(categoryId);
            asset.setDepartmentId(parseInt(req.getParameter("departmentId")));
            asset.setBrand(req.getParameter("brand"));
            asset.setModel(req.getParameter("model"));
            asset.setSnCode(req.getParameter("snCode"));
            asset.setRfidTag(req.getParameter("rfidTag"));
            asset.setBarcode(req.getParameter("barcode"));
            asset.setPurchaseDate(req.getParameter("purchaseDate"));
            String priceStr = req.getParameter("purchasePrice");
            if (priceStr != null && !priceStr.isEmpty()) {
                asset.setPurchasePrice(new BigDecimal(priceStr));
            }
            asset.setSupplierId(parseInt(req.getParameter("supplierId")));
            asset.setLocation(req.getParameter("location"));
            asset.setRemark(req.getParameter("remark"));
            asset.setWarrantyExpiry(req.getParameter("warrantyExpiry"));
            assetService.save(asset);
            resp.sendRedirect(req.getContextPath() + "/asset/list");
        } catch (Exception e) {
            resp.sendRedirect(req.getContextPath() + "/asset/add?error=save_failed");
        }
    }

    private void update(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        req.setCharacterEncoding("UTF-8");
        Asset asset = new Asset();
        asset.setId(parseInt(req.getParameter("id")));
        asset.setAssetName(req.getParameter("assetName"));
        asset.setCategoryId(parseInt(req.getParameter("categoryId")));
        asset.setDepartmentId(parseInt(req.getParameter("departmentId")));
        asset.setBrand(req.getParameter("brand"));
        asset.setModel(req.getParameter("model"));
        asset.setSnCode(req.getParameter("snCode"));
        asset.setRfidTag(req.getParameter("rfidTag"));
        asset.setBarcode(req.getParameter("barcode"));
        asset.setPurchaseDate(req.getParameter("purchaseDate"));
        String priceStr = req.getParameter("purchasePrice");
        if (priceStr != null && !priceStr.isEmpty()) {
            asset.setPurchasePrice(new BigDecimal(priceStr));
        }
        asset.setSupplierId(parseInt(req.getParameter("supplierId")));
        asset.setLocation(req.getParameter("location"));
        asset.setRemark(req.getParameter("remark"));
        asset.setWarrantyExpiry(req.getParameter("warrantyExpiry"));
        Asset existing = assetService.findById(asset.getId());
        asset.setCurrentValue(existing.getCurrentValue());
        asset.setDepreciableMonths(existing.getDepreciableMonths());
        asset.setDepreciatedMonths(existing.getDepreciatedMonths());
        asset.setDepreciableStartDate(existing.getDepreciableStartDate());
        asset.setStatus(existing.getStatus());
        assetService.update(asset);
        resp.sendRedirect(req.getContextPath() + "/asset/list");
    }

    private void delete(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        Integer id = parseInt(req.getParameter("id"));
        assetService.delete(id);
        resp.sendRedirect(req.getContextPath() + "/asset/list");
    }

    private void export(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        resp.setContentType("text/plain;charset=UTF-8");
        resp.setHeader("Content-Disposition", "attachment;filename=assets.csv");
        resp.getWriter().write("资产导出功能待实现");
    }

    private Integer parseInt(String str) {
        return parseInt(str, null);
    }

    private Integer parseInt(String str, Integer defaultVal) {
        if (str == null || str.isEmpty()) return defaultVal;
        try { return Integer.parseInt(str); } catch (Exception e) { return defaultVal; }
    }
}
