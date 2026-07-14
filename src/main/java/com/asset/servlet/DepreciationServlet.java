package com.asset.servlet;

import com.asset.service.DepreciationService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Map;

@WebServlet("/depreciation/*")
public class DepreciationServlet extends HttpServlet {

    private DepreciationService depreciationService = new DepreciationService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Map<String, Object> data = depreciationService.getDashboardData();
        for (Map.Entry<String, Object> e : data.entrySet()) req.setAttribute(e.getKey(), e.getValue());
        req.setAttribute("depreciationList", depreciationService.findAll());
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