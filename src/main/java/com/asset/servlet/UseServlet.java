package com.asset.servlet;

import com.asset.pojo.AssetUseRecord;
import com.asset.service.UseRecordService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Map;

@WebServlet("/use/*")
public class UseServlet extends HttpServlet {

    private UseRecordService useRecordService = new UseRecordService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String path = req.getPathInfo();
        if (path == null) path = "/list";

        switch (path) {
            case "/list":
                String filter = req.getParameter("filter");
                if ("unreturned".equals(filter)) {
                    req.setAttribute("useList", useRecordService.findUnreturned());
                    req.setAttribute("filter", "unreturned");
                } else {
                    req.setAttribute("useList", useRecordService.findAll());
                }
                req.setAttribute("pageTitle", "领用归还");
                req.getRequestDispatcher("/views/use/list.jsp").forward(req, resp);
                break;
            case "/add":
                String type = req.getParameter("type");
                if (type == null) type = "1";
                Integer assetId = parseInt(req.getParameter("assetId"));
                Map<String, Object> data = useRecordService.getAddFormData(type, assetId);
                for (Map.Entry<String, Object> entry : data.entrySet()) {
                    req.setAttribute(entry.getKey(), entry.getValue());
                }
                req.setAttribute("pageTitle", "领用归还");
                req.getRequestDispatcher("/views/use/add.jsp").forward(req, resp);
                break;
            case "/detail":
                req.setAttribute("record", useRecordService.findById(parseInt(req.getParameter("id"))));
                req.setAttribute("pageTitle", "领用归还");
                req.getRequestDispatcher("/views/use/detail.jsp").forward(req, resp);
                break;
            case "/return":
                Integer id = parseInt(req.getParameter("id"));
                Integer returnStatus = parseInt(req.getParameter("returnStatus"), 1);
                String actualReturnDate = req.getParameter("actualReturnDate");
                if (actualReturnDate == null || actualReturnDate.isEmpty()) {
                    actualReturnDate = java.time.LocalDate.now().toString();
                }
                useRecordService.returnAsset(id, returnStatus, actualReturnDate);
                resp.sendRedirect(req.getContextPath() + "/use/list");
                break;
            default:
                resp.sendRedirect(req.getContextPath() + "/use/list");
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        req.setCharacterEncoding("UTF-8");
        AssetUseRecord record = new AssetUseRecord();
        record.setAssetId(parseInt(req.getParameter("assetId")));
        record.setOperationType(parseInt(req.getParameter("operationType"), 1));
        record.setFromDeptId(parseInt(req.getParameter("fromDeptId"), 0));
        record.setToDeptId(parseInt(req.getParameter("toDeptId"), 0));
        record.setUseDate(req.getParameter("useDate"));
        record.setExpectedReturnDate(req.getParameter("expectedReturnDate"));
        record.setPurpose(req.getParameter("purpose"));
        record.setOperatorId(parseInt(req.getParameter("operatorId"), 1));
        useRecordService.save(record);
        resp.sendRedirect(req.getContextPath() + "/use/list");
    }

    private Integer parseInt(String str) { return parseInt(str, null); }
    private Integer parseInt(String str, Integer def) {
        if (str == null || str.isEmpty()) return def;
        try { return Integer.parseInt(str); } catch (Exception e) { return def; }
    }
}