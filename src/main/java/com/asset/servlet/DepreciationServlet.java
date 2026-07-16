package com.asset.servlet;

import com.asset.service.DepreciationService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;
import java.util.Map;

@WebServlet("/depreciation/*")
public class DepreciationServlet extends HttpServlet {

    private DepreciationService depreciationService = new DepreciationService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String month = req.getParameter("month");

        Map<String, Object> data = depreciationService.getDashboardDataByMonth(month);
        for (Map.Entry<String, Object> e : data.entrySet()) req.setAttribute(e.getKey(), e.getValue());

        List<?> depreciationList = (month != null && !month.isEmpty())
                ? depreciationService.findByMonth(month)
                : depreciationService.findAll();
        req.setAttribute("depreciationList", depreciationList);

        req.setAttribute("selectedMonth", month != null ? month : "");
        req.setAttribute("availableMonths", depreciationService.findAvailableMonths());

        req.setAttribute("pageTitle", "折旧计算");
        req.getRequestDispatcher("/views/depreciation/list.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String path = req.getPathInfo();
        if ("/calculate".equals(path)) {
            depreciationService.calculateMonthly();
        }
        resp.sendRedirect(req.getContextPath() + "/depreciation/list");
    }
}