<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>用户管理 - 企业轻量资产管理系统</title>
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
                    <h2 class="page-title">用户管理</h2>
                    <p class="page-subtitle">系统登录账号与权限管理</p>
                </div>
                <a href="${pageContext.request.contextPath}/user/add" class="btn btn-primary">
                    <i class="fas fa-plus mr-2"></i>新增用户
                </a>
            </div>

            <div class="card overflow-hidden">
                <table class="data-table">
                    <thead>
                        <tr>
                            <th>用户ID</th>
                            <th>登录账号</th>
                            <th>真实姓名</th>
                            <th>所属部门</th>
                            <th class="text-center">角色</th>
                            <th class="text-center">状态</th>
                            <th class="text-center">操作</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${userList}" var="u">
                        <tr class="table-row">
                            <td>${u.id}</td>
                            <td class="font-medium">${u.username}</td>
                            <td>${u.realName}</td>
                            <td>${u.deptName != null ? u.deptName : '-'}</td>
                            <td class="text-center">
                                <c:choose>
                                    <c:when test="${u.role == 'admin'}"><span class="status-badge" style="background:#fee2e2;color:#991b1b">管理员</span></c:when>
                                    <c:when test="${u.role == 'asset'}"><span class="status-badge" style="background:#dbeafe;color:#1e40af">资产管理员</span></c:when>
                                    <c:otherwise><span class="status-badge" style="background:#f3f4f6;color:#6b7280">普通用户</span></c:otherwise>
                                </c:choose>
                            </td>
                            <td class="text-center">
                                <c:choose>
                                    <c:when test="${u.status == 1}"><span class="status-badge status-2">正常</span></c:when>
                                    <c:otherwise><span class="status-badge status-4">禁用</span></c:otherwise>
                                </c:choose>
                            </td>
                            <td class="text-center">
                                <a href="${pageContext.request.contextPath}/user/edit?id=${u.id}" class="text-blue-600 hover:text-blue-800 mr-2"><i class="fas fa-edit"></i></a>
                                <a href="${pageContext.request.contextPath}/user/delete?id=${u.id}" class="text-rose-600 hover:text-rose-800" onclick="return confirmDelete()"><i class="fas fa-trash"></i></a>
                            </td>
                        </tr>
                        </c:forEach>
                        <c:if test="${empty userList}">
                        <tr>
                            <td colspan="7" class="text-center py-12 text-gray-400">
                                <i class="fas fa-inbox text-4xl mb-3"></i>
                                <p>暂无用户数据</p>
                            </td>
                        </tr>
                        </c:if>
                    </tbody>
                </table>
            </div>
        </main>
<%@ include file="/views/common/footer.jsp" %>