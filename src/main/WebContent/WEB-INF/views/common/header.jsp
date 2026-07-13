<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<header class="header">
    <div class="flex items-center gap-4">
        <button class="text-amber-200 hover:text-white transition lg:hidden" onclick="toggleSidebar()">
            <i class="fas fa-bars text-xl"></i>
        </button>
        <div class="flex items-center gap-2 text-amber-100">
            <i class="fas fa-home text-sm"></i>
            <span class="text-sm">首页</span>
            <i class="fas fa-chevron-right text-xs opacity-60"></i>
            <span id="page-title" class="font-semibold text-white">${pageTitle != null ? pageTitle : '数据仪表盘'}</span>
        </div>
    </div>

    <div class="flex items-center gap-6">
        <div class="relative hidden md:block">
            <i class="fas fa-search absolute left-3 top-1/2 -translate-y-1/2 text-amber-300 text-sm"></i>
            <form action="${pageContext.request.contextPath}/asset/search" method="get" style="margin:0">
                <input type="text" name="keyword" placeholder="全局搜索资产、单据..." 
                       class="bg-amber-900/50 border border-amber-700/50 rounded-lg pl-9 pr-4 py-2 text-sm text-amber-100 placeholder-amber-300/60 outline-none focus:border-amber-400 w-64 transition">
            </form>
        </div>

        <div class="flex items-center gap-4">
            <button class="relative text-amber-200 hover:text-white transition" onclick="showToast('暂无新通知', 'info')">
                <i class="fas fa-bell text-lg"></i>
                <span class="absolute -top-1 -right-1 w-4 h-4 bg-red-500 rounded-full text-xs flex items-center justify-center text-white font-bold">3</span>
            </button>

            <c:if test="${sessionScope.user != null}">
            <div class="flex items-center gap-2">
                <div class="w-8 h-8 bg-amber-600 rounded-full flex items-center justify-center text-white font-bold text-xs">
                    ${sessionScope.user.realName.substring(0,1)}
                </div>
                <div class="hidden md:block">
                    <p class="text-sm font-medium text-white">${sessionScope.user.realName}</p>
                    <p class="text-xs text-amber-200">
                        <c:choose>
                            <c:when test="${sessionScope.user.role == 'admin'}">管理员</c:when>
                            <c:when test="${sessionScope.user.role == 'asset'}">资产管理员</c:when>
                            <c:otherwise>普通用户</c:otherwise>
                        </c:choose>
                    </p>
                </div>
            </div>
            </c:if>
        </div>
    </div>
</header>