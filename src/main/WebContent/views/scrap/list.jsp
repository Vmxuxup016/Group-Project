<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>报废管理 - 企业轻量资产管理系统</title>
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
                    <h2 class="page-title">报废管理</h2>
                    <p class="page-subtitle">报废申请、审批与执行</p>
                </div>
                <a href="${pageContext.request.contextPath}/scrap/add" class="btn btn-primary">
                    <i class="fas fa-plus mr-2"></i>新增报废单
                </a>
            </div>

            <div class="card overflow-hidden">
                <table class="data-table">
                    <thead>
                        <tr>
                            <th>报废单号</th>
                            <th>资产名称</th>
                            <th>报废原因</th>
                            <th class="text-center">报废类型</th>
                            <th class="text-right">原值</th>
                            <th class="text-right">残值</th>
                            <th class="text-center">状态</th>
                            <th class="text-center">操作</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${scrapList}" var="s">
                        <tr class="table-row">
                            <td class="font-mono text-blue-600">${s.scrapNo}</td>
                            <td class="font-medium">${s.assetName}</td>
                            <td class="text-gray-600 max-w-xs truncate">${s.scrapReason}</td>
                            <td class="text-center">
                                <c:choose>
                                    <c:when test="${s.scrapType == 1}"><span class="status-badge" style="background:#dbeafe;color:#1e40af">达到年限</span></c:when>
                                    <c:when test="${s.scrapType == 2}"><span class="status-badge" style="background:#e0e7ff;color:#3730a3">技术淘汰</span></c:when>
                                    <c:when test="${s.scrapType == 3}"><span class="status-badge" style="background:#fee2e2;color:#991b1b">无法修复</span></c:when>
                                    <c:otherwise><span class="status-badge" style="background:#f3f4f6;color:#6b7280">其他</span></c:otherwise>
                                </c:choose>
                            </td>
                            <td class="text-right"><fmt:formatNumber value="${s.originalValue}" type="currency" currencySymbol="¥"/></td>
                            <td class="text-right"><fmt:formatNumber value="${s.scrapValue}" type="currency" currencySymbol="¥"/></td>
                            <td class="text-center">
                                <c:choose>
                                    <c:when test="${s.status == 1}"><span class="status-badge status-1">待审批</span></c:when>
                                    <c:when test="${s.status == 2}"><span class="status-badge status-2">已通过</span></c:when>
                                    <c:when test="${s.status == 3}"><span class="status-badge status-2">已执行</span></c:when>
                                    <c:when test="${s.status == 4}"><span class="status-badge status-4">驳回</span></c:when>
                                </c:choose>
                            </td>
                            <td class="text-center">
                                <c:if test="${s.status == 1}">
                                <a href="${pageContext.request.contextPath}/scrap/approve?id=${s.id}&action=pass" class="text-emerald-600 hover:text-emerald-800 mr-2" title="通过"><i class="fas fa-check"></i></a>
                                <a href="${pageContext.request.contextPath}/scrap/approve?id=${s.id}&action=reject" class="text-rose-600 hover:text-rose-800 mr-2" title="驳回"><i class="fas fa-times"></i></a>
                                </c:if>
                                <c:if test="${s.status == 2}">
                                <a href="${pageContext.request.contextPath}/scrap/execute?id=${s.id}" class="text-emerald-600 hover:text-emerald-800 mr-2" title="执行报废"><i class="fas fa-play"></i></a>
                                </c:if>
                                <a href="${pageContext.request.contextPath}/scrap/detail?id=${s.id}" class="text-blue-600 hover:text-blue-800"><i class="fas fa-eye"></i></a>
                            </td>
                        </tr>
                        </c:forEach>
                        <c:if test="${empty scrapList}">
                        <tr>
                            <td colspan="8" class="text-center py-12 text-gray-400">
                                <i class="fas fa-inbox text-4xl mb-3"></i>
                                <p>暂无报废记录</p>
                            </td>
                        </tr>
                        </c:if>
                    </tbody>
                </table>
            </div>
        </main>
<%@ include file="/views/common/footer.jsp" %>