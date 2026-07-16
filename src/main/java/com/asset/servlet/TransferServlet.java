package com.asset.servlet;

import com.asset.pojo.AssetUseRecord;
import com.asset.service.TransferService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Map;

@WebServlet("/transfer/*")
public class TransferServlet extends HttpServlet {

    private TransferService transferService = new TransferService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String path = req.getPathInfo();
        if (path == null) path = "/list";

        switch (path) {
            case "/list":
                req.setAttribute("transferList", transferService.findAll());
                req.setAttribute("pageTitle", "调拨审批");
                req.getRequestDispatcher("/views/transfer/list.jsp").forward(req, resp);
                break;

            case "/add":
                Map<String, Object> formData = transferService.getAddFormData();
                for (Map.Entry<String, Object> entry : formData.entrySet()) {
                    req.setAttribute(entry.getKey(), entry.getValue());
                }
                req.setAttribute("pageTitle", "调拨审批");
                String addError = req.getParameter("error");
                if (addError != null) {
                    req.setAttribute("errorMsg", addError);
                }
                req.getRequestDispatcher("/views/transfer/add.jsp").forward(req, resp);
                break;

            case "/detail":
                Integer detailId = parseInt(req.getParameter("id"));
                if (detailId != null) {
                    req.setAttribute("record", transferService.findById(detailId));
                }
                req.setAttribute("pageTitle", "调拨审批");
                req.getRequestDispatcher("/views/transfer/detail.jsp").forward(req, resp);
                break;

            case "/approve":
                Integer id = parseInt(req.getParameter("id"));
                boolean pass = "pass".equals(req.getParameter("action"));
                if (id != null) {
                    String error = transferService.approve(id, pass);
                    if (error != null) {
                        resp.sendRedirect(req.getContextPath() + "/transfer/detail?id=" + id + "&error=" + java.net.URLEncoder.encode(error, "UTF-8"));
                        return;
                    }
                }
                resp.sendRedirect(req.getContextPath() + "/transfer/detail?id=" + id);
                break;

            default:
                resp.sendRedirect(req.getContextPath() + "/transfer/list");
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        req.setCharacterEncoding("UTF-8");
        String path = req.getPathInfo();

        if ("/save".equals(path)) {
            AssetUseRecord record = new AssetUseRecord();
            record.setAssetId(parseInt(req.getParameter("assetId")));
            record.setFromDeptId(parseInt(req.getParameter("fromDeptId")));
            record.setToDeptId(parseInt(req.getParameter("toDeptId")));
            record.setUseDate(req.getParameter("useDate"));
            record.setPurpose(req.getParameter("purpose"));
            record.setOperatorId(parseInt(req.getParameter("operatorId"), 1));

            String error = transferService.save(record);
            if (error != null) {
                resp.sendRedirect(req.getContextPath() + "/transfer/add?error=" + java.net.URLEncoder.encode(error, "UTF-8"));
            } else {
                resp.sendRedirect(req.getContextPath() + "/transfer/list");
            }
        } else {
            resp.sendRedirect(req.getContextPath() + "/transfer/list");
        }
    }

    private Integer parseInt(String str) { return parseInt(str, null); }
    private Integer parseInt(String str, Integer def) {
        if (str == null || str.isEmpty()) return def;
        try { return Integer.parseInt(str); } catch (Exception e) { return def; }
    }
}
