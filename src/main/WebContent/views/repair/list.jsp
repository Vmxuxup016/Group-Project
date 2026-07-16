<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>维修管理 - 企业轻量资产管理系统</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body>
<div class="flex h-screen">
    <%@ include file="/views/common/sidebar.jsp" %>
    <div class="flex-1 flex flex-col min-w-0">
        <%@ include file="/views/common/header.jsp" %>
        <main class="content-area">
            <div class="page-header">
                <div>
                    <h2 class="page-title">维修管理</h2>
                    <p class="page-subtitle">故障报修、维修跟踪与记录</p>
                </div>
                <a href="${pageContext.request.contextPath}/repair/add" class="btn btn-primary">
                    <i class="fas fa-plus mr-2"></i>新增维修单
                </a>
            </div>

            <div class="grid grid-cols-1 md:grid-cols-4 gap-4 mb-6">
                <div class="card p-4 border-l-4 border-amber-500">
                    <p class="text-gray-500 text-sm">待维修</p>
                    <p class="text-2xl font-bold text-amber-600">${waitRepair != null ? waitRepair : '5'}</p>
                </div>
                <div class="card p-4 border-l-4 border-blue-500">
                    <p class="text-gray-500 text-sm">维修中</p>
                    <p class="text-2xl font-bold text-blue-600">${inRepair != null ? inRepair : '8'}</p>
                </div>
                <div class="card p-4 border-l-4 border-emerald-500">
                    <p class="text-gray-500 text-sm">已完成</p>
                    <p class="text-2xl font-bold text-emerald-600">${doneRepair != null ? doneRepair : '42'}</p>
                </div>
                <div class="card p-4 border-l-4 border-rose-500">
                    <p class="text-gray-500 text-sm">无法修复</p>
                    <p class="text-2xl font-bold text-rose-600">${unfixable != null ? unfixable : '3'}</p>
                </div>
            </div>

            <!-- 状态筛选 -->
            <div class="card p-4 mb-6">
                <div class="flex items-center gap-3">
                    <span class="text-sm text-gray-600 font-medium">状态筛选：</span>
                    <a href="${pageContext.request.contextPath}/repair/list"
                       class="px-3 py-1 rounded-full text-sm ${empty currentStatus ? 'bg-blue-500 text-white' : 'bg-gray-100 text-gray-600 hover:bg-gray-200'}">全部</a>
                    <a href="${pageContext.request.contextPath}/repair/list?status=1"
                       class="px-3 py-1 rounded-full text-sm ${currentStatus == 1 ? 'bg-amber-500 text-white' : 'bg-gray-100 text-gray-600 hover:bg-gray-200'}">待维修</a>
                    <a href="${pageContext.request.contextPath}/repair/list?status=2"
                       class="px-3 py-1 rounded-full text-sm ${currentStatus == 2 ? 'bg-blue-500 text-white' : 'bg-gray-100 text-gray-600 hover:bg-gray-200'}">维修中</a>
                    <a href="${pageContext.request.contextPath}/repair/list?status=3"
                       class="px-3 py-1 rounded-full text-sm ${currentStatus == 3 ? 'bg-emerald-500 text-white' : 'bg-gray-100 text-gray-600 hover:bg-gray-200'}">已完成</a>
                    <a href="${pageContext.request.contextPath}/repair/list?status=4"
                       class="px-3 py-1 rounded-full text-sm ${currentStatus == 4 ? 'bg-rose-500 text-white' : 'bg-gray-100 text-gray-600 hover:bg-gray-200'}">无法修复</a>
                </div>
            </div>

            <div class="card overflow-hidden">
                <table class="data-table">
                    <thead>
                        <tr>
                            <th>维修单号</th>
                            <th>资产名称</th>
                            <th>故障描述</th>
                            <th class="text-center">故障类型</th>
                            <th class="text-center">维修方式</th>
                            <th class="text-center">状态</th>
                            <th class="text-right">费用</th>
                            <th class="text-center">操作</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${repairList}" var="r">
                        <tr class="table-row">
                            <td class="font-mono text-blue-600">${r.repairNo}</td>
                            <td class="font-medium">${r.assetName}</td>
                            <td class="text-gray-600 max-w-xs truncate">${r.faultDesc}</td>
                            <td class="text-center">
                                <c:choose>
                                    <c:when test="${r.faultType == 1}"><span class="status-badge" style="background:#fee2e2;color:#991b1b">硬件故障</span></c:when>
                                    <c:when test="${r.faultType == 2}"><span class="status-badge" style="background:#dbeafe;color:#1e40af">软件故障</span></c:when>
                                    <c:when test="${r.faultType == 3}"><span class="status-badge" style="background:#fef3c7;color:#92400e">人为损坏</span></c:when>
                                    <c:otherwise><span class="status-badge" style="background:#f3f4f6;color:#6b7280">其他</span></c:otherwise>
                                </c:choose>
                            </td>
                            <td class="text-center">
                                <c:choose>
                                    <c:when test="${r.repairMethod == 1}">自行维修</c:when>
                                    <c:when test="${r.repairMethod == 2}">厂商保修</c:when>
                                    <c:when test="${r.repairMethod == 3}">第三方维修</c:when>
                                    <c:otherwise>-</c:otherwise>
                                </c:choose>
                            </td>
                            <td class="text-center">
                                <c:choose>
                                    <c:when test="${r.repairStatus == 1}"><span class="status-badge status-1">待维修</span></c:when>
                                    <c:when test="${r.repairStatus == 2}"><span class="status-badge status-3">维修中</span></c:when>
                                    <c:when test="${r.repairStatus == 3}"><span class="status-badge status-2">已完成</span></c:when>
                                    <c:when test="${r.repairStatus == 4}"><span class="status-badge status-4">无法修复</span></c:when>
                                </c:choose>
                            </td>
                            <td class="text-right"><fmt:formatNumber value="${r.repairCost}" type="currency" currencySymbol="¥"/></td>
                            <td class="text-center">
                                <div class="flex items-center justify-center gap-1.5">
                                <a href="${pageContext.request.contextPath}/repair/detail?id=${r.id}"
                                   class="inline-flex items-center px-2 py-1 text-xs rounded bg-gray-100 text-gray-600 hover:bg-gray-200 transition">
                                    <i class="fas fa-eye mr-1"></i>详情
                                </a>
                                <c:if test="${r.repairStatus == 1}">
                                <a href="${pageContext.request.contextPath}/repair/updateStatus?id=${r.id}&status=2"
                                   class="inline-flex items-center px-2 py-1 text-xs rounded bg-blue-500 text-white hover:bg-blue-600 transition">
                                    <i class="fas fa-play mr-1"></i>维修中
                                </a>
                                </c:if>
                                <c:if test="${r.repairStatus == 1 || r.repairStatus == 2}">
                                <a href="${pageContext.request.contextPath}/repair/updateStatus?id=${r.id}&status=3"
                                   class="inline-flex items-center px-2 py-1 text-xs rounded bg-emerald-500 text-white hover:bg-emerald-600 transition">
                                    <i class="fas fa-check mr-1"></i>已完成
                                </a>
                                </c:if>
                                <c:if test="${r.repairStatus != 3 && r.repairStatus != 4}">
                                <a href="${pageContext.request.contextPath}/repair/updateStatus?id=${r.id}&status=4"
                                   class="inline-flex items-center px-2 py-1 text-xs rounded bg-rose-500 text-white hover:bg-rose-600 transition"
                                   onclick="return confirm('确认标记为无法修复？')">
                                    <i class="fas fa-ban mr-1"></i>无法修复
                                </a>
                                </c:if>
                                <c:if test="${r.repairStatus == 3 || r.repairStatus == 4}">
                                <span class="text-xs text-gray-400">-</span>
                                </c:if>
                                </div>
                            </td>
                        </tr>
                        </c:forEach>
                        <c:if test="${empty repairList}">
                        <tr>
                            <td colspan="8" class="text-center py-12 text-gray-400">
                                <i class="fas fa-inbox text-4xl mb-3"></i>
                                <p>暂无维修记录</p>
                            </td>
                        </tr>
                        </c:if>
                    </tbody>
                </table>
            </div>
        </main>
<%@ include file="/views/common/footer.jsp" %>