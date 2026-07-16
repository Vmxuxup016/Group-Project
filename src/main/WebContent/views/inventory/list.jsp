<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>资产盘点 - 企业轻量资产管理系统</title>
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
                    <h2 class="page-title">资产盘点</h2>
                    <p class="page-subtitle">盘点任务创建、执行与结果分析</p>
                </div>
                <a href="${pageContext.request.contextPath}/inventory/add" class="btn btn-primary">
                    <i class="fas fa-plus mr-2"></i>新建盘点任务
                </a>
            </div>

            <div class="grid grid-cols-1 md:grid-cols-3 gap-4 mb-6">
                <div class="card p-4">
                    <div class="flex items-center gap-3">
                        <div class="w-10 h-10 bg-blue-100 rounded-lg flex items-center justify-center">
                            <i class="fas fa-clipboard-list text-blue-600"></i>
                        </div>
                        <div>
                            <p class="text-gray-500 text-sm">待盘点</p>
                            <p class="text-xl font-bold">${waitInventory != null ? waitInventory : '2'}</p>
                        </div>
                    </div>
                </div>
                <div class="card p-4">
                    <div class="flex items-center gap-3">
                        <div class="w-10 h-10 bg-amber-100 rounded-lg flex items-center justify-center">
                            <i class="fas fa-spinner text-amber-600"></i>
                        </div>
                        <div>
                            <p class="text-gray-500 text-sm">盘点中</p>
                            <p class="text-xl font-bold">${inInventory != null ? inInventory : '1'}</p>
                        </div>
                    </div>
                </div>
                <div class="card p-4">
                    <div class="flex items-center gap-3">
                        <div class="w-10 h-10 bg-emerald-100 rounded-lg flex items-center justify-center">
                            <i class="fas fa-check-double text-emerald-600"></i>
                        </div>
                        <div>
                            <p class="text-gray-500 text-sm">已完成</p>
                            <p class="text-xl font-bold">${doneInventory != null ? doneInventory : '8'}</p>
                        </div>
                    </div>
                </div>
            </div>

            <div class="card overflow-hidden">
                <table class="data-table">
                    <thead>
                        <tr>
                            <th>盘点单号</th>
                            <th>任务名称</th>
                            <th class="text-center">盘点类型</th>
                            <th class="text-center">计划日期</th>
                            <th class="text-center">盘点方式</th>
                            <th class="text-center">状态</th>
                            <th class="text-center">结果</th>
                            <th class="text-center">操作</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${inventoryList}" var="inv">
                        <tr class="table-row">
                            <td class="font-mono text-blue-600">${inv.inventoryNo}</td>
                            <td class="font-medium">${inv.inventoryName}</td>
                            <td class="text-center">
                                <c:choose>
                                    <c:when test="${inv.inventoryType == 1}">全面盘点</c:when>
                                    <c:when test="${inv.inventoryType == 2}">按部门</c:when>
                                    <c:when test="${inv.inventoryType == 3}">按分类</c:when>
                                </c:choose>
                            </td>
                            <td class="text-center">${inv.planDate != null ? inv.planDate : '-'}</td>
                            <td class="text-center">
                                <c:choose>
                                    <c:when test="${inv.inventoryMethod == 1}"><span class="status-badge" style="background:#dbeafe;color:#1e40af"><i class="fas fa-mobile-alt mr-1"></i>人工扫码</span></c:when>
                                    <c:when test="${inv.inventoryMethod == 2}"><span class="status-badge" style="background:#e0e7ff;color:#3730a3"><i class="fas fa-wifi mr-1"></i>RFID批量</span></c:when>
                                </c:choose>
                            </td>
                            <td class="text-center">
                                <c:choose>
                                    <c:when test="${inv.status == 1}"><span class="status-badge status-1">待盘点</span></c:when>
                                    <c:when test="${inv.status == 2}"><span class="status-badge status-3">盘点中</span></c:when>
                                    <c:when test="${inv.status == 3}"><span class="status-badge status-2">已完成</span></c:when>
                                </c:choose>
                            </td>
                            <td class="text-center">
                                <c:choose>
                                    <c:when test="${inv.resultStatus == 0}"><span class="status-badge" style="background:#f3f4f6;color:#6b7280">未出结果</span></c:when>
                                    <c:when test="${inv.resultStatus == 1}"><span class="status-badge status-2">正常</span></c:when>
                                    <c:when test="${inv.resultStatus == 2}"><span class="status-badge status-4">存在异常</span></c:when>
                                </c:choose>
                            </td>
                            <td class="text-center">
                                <c:if test="${inv.status == 1 || inv.status == 2}">
                                <a href="${pageContext.request.contextPath}/inventory/scan?id=${inv.id}" class="text-blue-600 hover:text-blue-800 mr-2" title="开始盘点"><i class="fas fa-play"></i></a>
                                </c:if>
                                <a href="${pageContext.request.contextPath}/inventory/detail?id=${inv.id}" class="text-blue-600 hover:text-blue-800"><i class="fas fa-eye"></i></a>
                            </td>
                        </tr>
                        </c:forEach>
                        <c:if test="${empty inventoryList}">
                        <tr>
                            <td colspan="8" class="text-center py-12 text-gray-400">
                                <i class="fas fa-inbox text-4xl mb-3"></i>
                                <p>暂无盘点任务</p>
                            </td>
                        </tr>
                        </c:if>
                    </tbody>
                </table>
            </div>
        </main>
<%@ include file="/views/common/footer.jsp" %>