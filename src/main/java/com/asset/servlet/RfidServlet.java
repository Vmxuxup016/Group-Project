package com.asset.servlet;

import com.asset.pojo.AssetRfidTag;
import com.asset.service.RfidService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/rfid/*")
public class RfidServlet extends HttpServlet {

    private RfidService rfidService = new RfidService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String path = req.getPathInfo();
        if (path == null) path = "/list";

        switch (path) {
            case "/list":
                req.setAttribute("rfidList", rfidService.findAll());
                req.getRequestDispatcher("/views/rfid/list.jsp").forward(req, resp);
                break;
            case "/detail":
                req.setAttribute("tag", rfidService.findById(parseInt(req.getParameter("id"))));
                req.getRequestDispatcher("/views/rfid/detail.jsp").forward(req, resp);
                break;
            case "/bind":
                Integer tagId = parseInt(req.getParameter("id"));
                Integer assetId = parseInt(req.getParameter("assetId"));
                if (assetId != null) rfidService.bind(tagId, assetId);
                resp.sendRedirect(req.getContextPath() + "/rfid/list");
                break;
            case "/unbind":
                rfidService.unbind(parseInt(req.getParameter("id")));
                resp.sendRedirect(req.getContextPath() + "/rfid/list");
                break;
            default:
                resp.sendRedirect(req.getContextPath() + "/rfid/list");
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        req.setCharacterEncoding("UTF-8");
        AssetRfidTag tag = new AssetRfidTag();
        tag.setTagCode(req.getParameter("tagCode"));
        rfidService.save(tag);
        resp.sendRedirect(req.getContextPath() + "/rfid/list");
    }

    private Integer parseInt(String str) { return parseInt(str, null); }
    private Integer parseInt(String str, Integer def) {
        if (str == null || str.isEmpty()) return def;
        try { return Integer.parseInt(str); } catch (Exception e) { return def; }
    }
}