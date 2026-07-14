<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>采购入库 - 企业轻量资产管理系统</title>
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
                    <h2 class="page-title">采购入库</h2>
                    <p class="page-subtitle">采购单管理与入库登记</p>
                </div>
                <a href="${pageContext.request.contextPath}/purchase/add" class="btn btn-primary">
                    <i class="fas fa-plus mr-2"></i>新增采购单
                </a>
            </div>

            <div class="card overflow-hidden">
                <table class="data-table">
                    <thead>
                        <tr>
                            <th>采购单号</th>
                            <th>供应商</th>
                            <th class="text-center">采购日期</th>
                            <th class="text-right">总金额</th>
                            <th class="text-center">状态</th>
                            <th class="text-center">操作</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${purchaseList}" var="p">
                        <tr class="table-row">
                            <td class="font-mono text-blue-600 font-medium">${p.purchaseNo}</td>
                            <td>${p.supplierName != null ? p.supplierName : '-'}</td>
                            <td class="text-center">${p.purchaseDate != null ? p.purchaseDate : '-'}</td>
                            <td class="text-right font-medium"><fmt:formatNumber value="${p.totalAmount}" type="currency" currencySymbol="¥"/></td>
                            <td class="text-center">
                                <c:choose>
                                    <c:when test="${p.status == 1}"><span class="status-badge status-1">待入库</span></c:when>
                                    <c:when test="${p.status == 2}"><span class="status-badge status-3">部分入库</span></c:when>
                                    <c:when test="${p.status == 3}"><span class="status-badge status-2">已入库</span></c:when>
                                </c:choose>
                            </td>
                            <td class="text-center">
                                <a href="${pageContext.request.contextPath}/purchase/detail?id=${p.id}" class="text-blue-600 hover:text-blue-800 mr-2" title="查看/入库"><i class="fas fa-eye"></i></a>
                            </td>
                        </tr>
                        </c:forEach>
                        <c:if test="${empty purchaseList}">
                        <tr>
                            <td colspan="6" class="text-center py-12 text-gray-400">
                                <i class="fas fa-inbox text-4xl mb-3"></i>
                                <p>暂无采购单数据</p>
                            </td>
                        </tr>
                        </c:if>
                    </tbody>
                </table>
            </div>
        </main>
<%@ include file="/views/common/footer.jsp" %>