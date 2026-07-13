<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>供应商管理 - 企业轻量资产管理系统</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

</head>
<body>
<div class="flex h-screen">
    <%@ include file="/WEB-INF/views/common/sidebar.jsp" %>
    <div class="flex-1 flex flex-col min-w-0">
        <%@ include file="/WEB-INF/views/common/header.jsp" %>
        <main class="content-area">
            <div class="page-header">
                <div>
                    <h2 class="page-title">供应商管理</h2>
                    <p class="page-subtitle">供应商档案与合作关系维护</p>
                </div>
                <a href="${pageContext.request.contextPath}/supplier/add" class="btn btn-primary">
                    <i class="fas fa-plus mr-2"></i>新增供应商
                </a>
            </div>

            <div class="card overflow-hidden">
                <table class="data-table">
                    <thead>
                        <tr>
                            <th>供应商ID</th>
                            <th>供应商名称</th>
                            <th>联系人</th>
                            <th>联系电话</th>
                            <th class="text-center">状态</th>
                            <th class="text-center">操作</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${supplierList}" var="s">
                        <tr class="table-row">
                            <td>${s.id}</td>
                            <td class="font-medium">${s.supplierName}</td>
                            <td>${s.contactPerson != null ? s.contactPerson : '-'}</td>
                            <td>${s.phone != null ? s.phone : '-'}</td>
                            <td class="text-center">
                                <c:choose>
                                    <c:when test="${s.status == 1}"><span class="status-badge status-2">合作中</span></c:when>
                                    <c:otherwise><span class="status-badge status-4">终止</span></c:otherwise>
                                </c:choose>
                            </td>
                            <td class="text-center">
                                <a href="${pageContext.request.contextPath}/supplier/edit?id=${s.id}" class="text-blue-600 hover:text-blue-800 mr-2"><i class="fas fa-edit"></i></a>
                                <a href="${pageContext.request.contextPath}/supplier/delete?id=${s.id}" class="text-rose-600 hover:text-rose-800" onclick="return confirmDelete()"><i class="fas fa-trash"></i></a>
                            </td>
                        </tr>
                        </c:forEach>
                        <c:if test="${empty supplierList}">
                        <tr>
                            <td colspan="6" class="text-center py-12 text-gray-400">
                                <i class="fas fa-inbox text-4xl mb-3"></i>
                                <p>暂无供应商数据</p>
                            </td>
                        </tr>
                        </c:if>
                    </tbody>
                </table>
            </div>
        </main>
<%@ include file="/WEB-INF/views/common/footer.jsp" %>