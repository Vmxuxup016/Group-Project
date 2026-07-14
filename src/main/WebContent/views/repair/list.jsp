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
                                <a href="${pageContext.request.contextPath}/repair/detail?id=${r.id}" class="text-blue-600 hover:text-blue-800"><i class="fas fa-eye"></i></a>
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