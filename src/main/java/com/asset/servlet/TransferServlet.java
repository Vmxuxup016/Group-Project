package com.asset.servlet;

import com.asset.pojo.AssetUseRecord;
import com.asset.service.TransferService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

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
                req.getRequestDispatcher("/views/transfer/list.jsp").forward(req, resp);
                break;
            case "/detail":
                req.setAttribute("transfer", transferService.findById(parseInt(req.getParameter("id"))));
                req.getRequestDispatcher("/views/transfer/detail.jsp").forward(req, resp);
                break;
            case "/approve":
                Integer id = parseInt(req.getParameter("id"));
                boolean pass = "pass".equals(req.getParameter("action"));
                transferService.approve(id, pass);
                resp.sendRedirect(req.getContextPath() + "/transfer/list");
                break;
            default:
                resp.sendRedirect(req.getContextPath() + "/transfer/list");
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        req.setCharacterEncoding("UTF-8");
        AssetUseRecord record = new AssetUseRecord();
        record.setAssetId(parseInt(req.getParameter("assetId")));
        record.setFromDeptId(parseInt(req.getParameter("fromDeptId")));
        record.setToDeptId(parseInt(req.getParameter("toDeptId")));
        record.setUseDate(req.getParameter("useDate"));
        record.setPurpose(req.getParameter("purpose"));
        record.setOperatorId(parseInt(req.getParameter("operatorId"), 1));
        transferService.save(record);
        resp.sendRedirect(req.getContextPath() + "/transfer/list");
    }

    private Integer parseInt(String str) { return parseInt(str, null); }
    private Integer parseInt(String str, Integer def) {
        if (str == null || str.isEmpty()) return def;
        try { return Integer.parseInt(str); } catch (Exception e) { return def; }
    }
}