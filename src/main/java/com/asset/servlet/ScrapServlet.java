package com.asset.servlet;

import com.asset.dao.AssetDao;
import com.asset.pojo.AssetScrap;
import com.asset.service.ScrapService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.math.BigDecimal;

@WebServlet("/scrap/*")
public class ScrapServlet extends HttpServlet {

    private ScrapService scrapService = new ScrapService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String path = req.getPathInfo();
        if (path == null) path = "/list";

        switch (path) {
            case "/list":
                req.setAttribute("scrapList", scrapService.findAll());
                req.getRequestDispatcher("/views/scrap/list.jsp").forward(req, resp);
                break;
            case "/detail":
                req.setAttribute("scrap", scrapService.findById(parseInt(req.getParameter("id"))));
                req.getRequestDispatcher("/views/scrap/detail.jsp").forward(req, resp);
                break;
            case "/add":
                req.setAttribute("assetList", new AssetDao().findList(null, null, null, null, 0, 1000));
                req.getRequestDispatcher("/views/scrap/add.jsp").forward(req, resp);
                break;
            case "/approve":
                Integer id = parseInt(req.getParameter("id"));
                boolean pass = "pass".equals(req.getParameter("action"));
                scrapService.approve(id, pass);
                resp.sendRedirect(req.getContextPath() + "/scrap/list");
                break;
            case "/execute":
                Integer eid = parseInt(req.getParameter("id"));
                scrapService.execute(eid, 1, null);
                resp.sendRedirect(req.getContextPath() + "/scrap/list");
                break;
            default:
                resp.sendRedirect(req.getContextPath() + "/scrap/list");
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        req.setCharacterEncoding("UTF-8");
        AssetScrap scrap = new AssetScrap();
        scrap.setAssetId(parseInt(req.getParameter("assetId")));
        scrap.setScrapReason(req.getParameter("scrapReason"));
        scrap.setScrapType(parseInt(req.getParameter("scrapType"), 1));
        String ov = req.getParameter("originalValue");
        if (ov != null && !ov.isEmpty()) {
            scrap.setOriginalValue(new BigDecimal(ov));
        } else {
            // 自动从资产档案读取原值
            com.asset.pojo.Asset asset = new AssetDao().findById(scrap.getAssetId());
            scrap.setOriginalValue(asset != null && asset.getPurchasePrice() != null
                    ? asset.getPurchasePrice() : BigDecimal.ZERO);
        }
        scrap.setCreateBy(1);
        scrapService.save(scrap);
        resp.sendRedirect(req.getContextPath() + "/scrap/list");
    }

    private Integer parseInt(String str) { return parseInt(str, null); }
    private Integer parseInt(String str, Integer def) {
        if (str == null || str.isEmpty()) return def;
        try { return Integer.parseInt(str); } catch (Exception e) { return def; }
    }
}