<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="sidebar-overlay" onclick="toggleSidebar()"></div>

<aside class="sidebar flex flex-col">
    <div class="p-6 border-b border-gray-800">
        <div class="flex items-center gap-3">
            <div class="w-10 h-10 bg-amber-500 rounded-lg flex items-center justify-center">
                <i class="fas fa-boxes text-white text-lg"></i>
            </div>
            <div>
                <h1 class="text-white font-bold text-lg leading-tight">资产管理系统</h1>
                <p class="text-gray-400 text-xs">EAM Lite v1.0</p>
            </div>
        </div>
    </div>

    <nav class="flex-1 overflow-y-auto py-4">
        <div class="sidebar-section-title">核心模块</div>

        <a href="${pageContext.request.contextPath}/dashboard" 
           class="sidebar-item ${pageTitle == '数据仪表盘' ? 'active' : ''}">
            <i class="fas fa-chart-pie w-5 text-center"></i>
            <span>数据仪表盘</span>
        </a>

        <a href="${pageContext.request.contextPath}/asset/list" 
           class="sidebar-item ${pageTitle == '资产档案' ? 'active' : ''}">
            <i class="fas fa-box w-5 text-center"></i>
            <span>资产档案</span>
        </a>

        <a href="${pageContext.request.contextPath}/category/list" 
           class="sidebar-item ${pageTitle == '资产分类' ? 'active' : ''}">
            <i class="fas fa-tags w-5 text-center"></i>
            <span>资产分类</span>
        </a>

        <a href="${pageContext.request.contextPath}/purchase/list" 
           class="sidebar-item ${pageTitle == '采购入库' ? 'active' : ''}">
            <i class="fas fa-shopping-cart w-5 text-center"></i>
            <span>采购入库</span>
        </a>

        <a href="${pageContext.request.contextPath}/use/list" 
           class="sidebar-item ${pageTitle == '领用归还' ? 'active' : ''}">
            <i class="fas fa-hand-holding w-5 text-center"></i>
            <span>领用归还</span>
        </a>

        <a href="${pageContext.request.contextPath}/repair/list" 
           class="sidebar-item ${pageTitle == '维修管理' ? 'active' : ''}">
            <i class="fas fa-tools w-5 text-center"></i>
            <span>维修管理</span>
        </a>

        <a href="${pageContext.request.contextPath}/scrap/list" 
           class="sidebar-item ${pageTitle == '报废管理' ? 'active' : ''}">
            <i class="fas fa-trash-alt w-5 text-center"></i>
            <span>报废管理</span>
        </a>

        <a href="${pageContext.request.contextPath}/inventory/list" 
           class="sidebar-item ${pageTitle == '资产盘点' ? 'active' : ''}">
            <i class="fas fa-clipboard-check w-5 text-center"></i>
            <span>资产盘点</span>
        </a>

        <div class="sidebar-section-title">前瞻拓展</div>

        <a href="${pageContext.request.contextPath}/depreciation/list" 
           class="sidebar-item ${pageTitle == '折旧计算' ? 'active' : ''}">
            <i class="fas fa-calculator w-5 text-center"></i>
            <span>折旧计算</span>
        </a>

        <a href="${pageContext.request.contextPath}/rfid/list" 
           class="sidebar-item ${pageTitle == 'RFID管理' ? 'active' : ''}">
            <i class="fas fa-wifi w-5 text-center"></i>
            <span>RFID管理</span>
        </a>

        <a href="${pageContext.request.contextPath}/transfer/list" 
           class="sidebar-item ${pageTitle == '调拨审批' ? 'active' : ''}">
            <i class="fas fa-exchange-alt w-5 text-center"></i>
            <span>调拨审批</span>
        </a>

        <div class="sidebar-section-title">系统设置</div>

        <a href="${pageContext.request.contextPath}/dept/list" 
           class="sidebar-item ${pageTitle == '部门管理' ? 'active' : ''}">
            <i class="fas fa-sitemap w-5 text-center"></i>
            <span>部门管理</span>
        </a>

        <a href="${pageContext.request.contextPath}/user/list" 
           class="sidebar-item ${pageTitle == '用户管理' ? 'active' : ''}">
            <i class="fas fa-users w-5 text-center"></i>
            <span>用户管理</span>
        </a>

        <a href="${pageContext.request.contextPath}/supplier/list" 
           class="sidebar-item ${pageTitle == '供应商管理' ? 'active' : ''}">
            <i class="fas fa-truck w-5 text-center"></i>
            <span>供应商</span>
        </a>
    </nav>

    <div class="p-4 border-t border-gray-800">
        <div class="flex items-center gap-3">
            <c:if test="${sessionScope.user != null}">
            <div class="w-9 h-9 bg-amber-600 rounded-full flex items-center justify-center text-white font-bold text-sm">
                ${sessionScope.user.realName.substring(0,1)}
            </div>
            <div class="flex-1 min-w-0">
                <p class="text-white text-sm font-medium truncate">${sessionScope.user.realName}</p>
                <p class="text-gray-400 text-xs truncate">${sessionScope.user.username} | ${sessionScope.user.deptName != null ? sessionScope.user.deptName : '集团总部'}</p>
            </div>
            </c:if>
            <a href="${pageContext.request.contextPath}/logout" class="text-gray-400 hover:text-white transition" title="退出登录">
                <i class="fas fa-sign-out-alt"></i>
            </a>
        </div>
    </div>
</aside>