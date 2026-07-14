<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>领用归还 - 企业轻量资产管理系统</title>
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
                    <h2 class="page-title">领用归还</h2>
                    <p class="page-subtitle">资产在部门间的流转记录</p>
                </div>
                <div class="flex gap-3">
                    <a href="${pageContext.request.contextPath}/use/list" class="btn ${empty filter ? 'btn-primary' : 'btn-secondary'}">
                        <i class="fas fa-list mr-2"></i>全部
                    </a>
                    <a href="${pageContext.request.contextPath}/use/list?filter=unreturned" class="btn ${filter == 'unreturned' ? 'btn-danger' : 'btn-secondary'}">
                        <i class="fas fa-exclamation-circle mr-2"></i>未归还
                    </a>
                    <a href="${pageContext.request.contextPath}/use/add?type=1" class="btn btn-primary">
                        <i class="fas fa-hand-holding mr-2"></i>领用登记
                    </a>
                    <a href="${pageContext.request.contextPath}/use/add?type=2" class="btn btn-success">
                        <i class="fas fa-undo mr-2"></i>归还登记
                    </a>
                </div>
            </div>

            <div class="card overflow-hidden">
                <table class="data-table">
                    <thead>
                        <tr>
                            <th>资产编码</th>
                            <th>资产名称</th>
                            <th class="text-center">操作类型</th>
                            <th>原部门</th>
                            <th>目标部门</th>
                            <th class="text-center">操作日期</th>
                            <th class="text-center">归还状态</th>
                            <th class="text-center">操作</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${useList}" var="u">
                        <tr class="table-row">
                            <td class="font-mono text-blue-600">${u.assetCode}</td>
                            <td class="font-medium">${u.assetName}</td>
                            <td class="text-center">
                                <c:choose>
                                    <c:when test="${u.operationType == 1}"><span class="status-badge status-2">领用</span></c:when>
                                    <c:when test="${u.operationType == 2}"><span class="status-badge status-1">归还</span></c:when>
                                    <c:when test="${u.operationType == 3}"><span class="status-badge status-5">调拨</span></c:when>
                                </c:choose>
                            </td>
                            <td class="text-gray-500">${u.fromDeptName != null ? u.fromDeptName : '-'}</td>
                            <td>${u.toDeptName}</td>
                            <td class="text-center">${u.useDate}</td>
                            <td class="text-center">
                                <c:choose>
                                    <c:when test="${u.returnStatus == 0}"><span class="status-badge" style="background:#fee2e2;color:#991b1b">未归还</span></c:when>
                                    <c:when test="${u.returnStatus == 1}"><span class="status-badge status-2">正常归还</span></c:when>
                                    <c:when test="${u.returnStatus == 2}"><span class="status-badge status-3">逾期归还</span></c:when>
                                    <c:when test="${u.returnStatus == 3}"><span class="status-badge status-4">损坏归还</span></c:when>
                                    <c:otherwise><span class="status-badge" style="background:#dbeafe;color:#1e40af">无需归还</span></c:otherwise>
                                </c:choose>
                            </td>
                            <td class="text-center">
                                <a href="${pageContext.request.contextPath}/use/detail?id=${u.id}" class="text-blue-600 hover:text-blue-800 mr-3" title="查看详情"><i class="fas fa-eye"></i></a>
                                <c:if test="${u.returnStatus == 0 && u.operationType == 1}">
                                <a href="${pageContext.request.contextPath}/use/return?id=${u.id}&returnStatus=1" class="text-green-600 hover:text-green-800" title="快速归还"><i class="fas fa-undo"></i></a>
                                </c:if>
                            </td>
                        </tr>
                        </c:forEach>
                        <c:if test="${empty useList}">
                        <tr>
                            <td colspan="8" class="text-center py-12 text-gray-400">
                                <i class="fas fa-inbox text-4xl mb-3"></i>
                                <p>暂无领用归还记录</p>
                            </td>
                        </tr>
                        </c:if>
                    </tbody>
                </table>
            </div>
        </main>
<%@ include file="/views/common/footer.jsp" %>
</body>
</html>
