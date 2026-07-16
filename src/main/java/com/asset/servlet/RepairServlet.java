package com.asset.servlet;

import com.asset.dao.AssetDao;
import com.asset.dao.DepartmentDao;
import com.asset.pojo.AssetRepair;
import com.asset.service.RepairService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.math.BigDecimal;
import java.util.Map;

@WebServlet("/repair/*")
public class RepairServlet extends HttpServlet {

    private RepairService repairService = new RepairService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String path = req.getPathInfo();
        if (path == null) path = "/list";

        switch (path) {
            case "/list":
                String statusParam = req.getParameter("status");
                Integer filterStatus = (statusParam != null && !statusParam.isEmpty()) ? Integer.parseInt(statusParam) : null;
                Map<String, Object> stats = repairService.getStats();
                for (Map.Entry<String, Object> e : stats.entrySet()) req.setAttribute(e.getKey(), e.getValue());
                req.setAttribute("repairList", repairService.findByStatus(filterStatus));
                req.setAttribute("currentStatus", filterStatus);
                req.getRequestDispatcher("/views/repair/list.jsp").forward(req, resp);
                break;
            case "/add":
                req.setAttribute("assetList", new AssetDao().findList(null, null, null, null, 0, 1000));
                req.setAttribute("deptList", new DepartmentDao().findAll());
                req.getRequestDispatcher("/views/repair/add.jsp").forward(req, resp);
                break;
            case "/detail":
                req.setAttribute("repair", repairService.findById(parseInt(req.getParameter("id"))));
                req.getRequestDispatcher("/views/repair/detail.jsp").forward(req, resp);
                break;
            case "/updateStatus":
                Integer repairId = parseInt(req.getParameter("id"));
                Integer newStatus = parseInt(req.getParameter("status"));
                if (repairId != null && newStatus != null) {
                    repairService.updateStatus(repairId, newStatus);
                }
                resp.sendRedirect(req.getContextPath() + "/repair/list");
                break;
            default:
                resp.sendRedirect(req.getContextPath() + "/repair/list");
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        req.setCharacterEncoding("UTF-8");
        AssetRepair repair = new AssetRepair();
        repair.setAssetId(parseInt(req.getParameter("assetId")));
        repair.setFaultDesc(req.getParameter("faultDesc"));
        repair.setFaultType(parseInt(req.getParameter("faultType"), 1));
        repair.setReportDeptId(parseInt(req.getParameter("reportDeptId")));
        repair.setRepairMethod(parseInt(req.getParameter("repairMethod")));
        repair.setOperatorId(parseInt(req.getParameter("operatorId"), 1));
        repair.setStartDate(req.getParameter("startDate"));
        String cost = req.getParameter("repairCost");
        if (cost != null && !cost.isEmpty()) {
            repair.setRepairCost(new BigDecimal(cost));
        }
        repairService.save(repair);
        resp.sendRedirect(req.getContextPath() + "/repair/list");
    }

    private Integer parseInt(String str) { return parseInt(str, null); }
    private Integer parseInt(String str, Integer def) {
        if (str == null || str.isEmpty()) return def;
        try { return Integer.parseInt(str); } catch (Exception e) { return def; }
    }
}