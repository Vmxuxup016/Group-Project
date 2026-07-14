<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>部门管理 - 企业轻量资产管理系统</title>
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
                    <h2 class="page-title">部门管理</h2>
                    <p class="page-subtitle">树形部门架构维护</p>
                </div>
                <a href="${pageContext.request.contextPath}/dept/add" class="btn btn-primary">
                    <i class="fas fa-plus mr-2"></i>新增部门
                </a>
            </div>

            <div class="card p-6">
                <div class="space-y-3">
                    <c:forEach items="${deptList}" var="dept">
                    <c:if test="${dept.parentId == 0}">
                    <div class="flex items-center gap-3 p-4 bg-gray-50 rounded-xl">
                        <div class="w-10 h-10 bg-amber-100 rounded-lg flex items-center justify-center">
                            <i class="fas fa-building text-amber-600"></i>
                        </div>
                        <div class="flex-1">
                            <span class="font-bold text-gray-800">${dept.deptName}</span>
                            <span class="text-gray-400 text-sm ml-2">${dept.deptCode}</span>
                        </div>
                        <span class="text-sm text-gray-500">根节点</span>
                        <div class="flex gap-2">
                            <a href="${pageContext.request.contextPath}/dept/edit?id=${dept.id}" class="text-blue-600 hover:text-blue-800"><i class="fas fa-edit"></i></a>
                            <a href="${pageContext.request.contextPath}/dept/delete?id=${dept.id}" class="text-rose-600 hover:text-rose-800" onclick="return confirmDelete()"><i class="fas fa-trash"></i></a>
                        </div>
                    </div>
                    <div class="ml-8 space-y-3">
                        <c:forEach items="${deptList}" var="child">
                        <c:if test="${child.parentId == dept.id}">
                        <div class="flex items-center gap-3 p-4 bg-white border border-gray-200 rounded-xl">
                            <div class="w-10 h-10 bg-blue-100 rounded-lg flex items-center justify-center">
                                <i class="fas fa-briefcase text-blue-600"></i>
                            </div>
                            <div class="flex-1">
                                <span class="font-semibold text-gray-800">${child.deptName}</span>
                                <span class="text-gray-400 text-sm ml-2">${child.deptCode}</span>
                            </div>
                            <span class="text-sm text-gray-500">资产: ${child.assetCount != null ? child.assetCount : '0'}</span>
                            <div class="flex gap-2">
                                <a href="${pageContext.request.contextPath}/dept/edit?id=${child.id}" class="text-blue-600 hover:text-blue-800"><i class="fas fa-edit"></i></a>
                                <a href="${pageContext.request.contextPath}/dept/delete?id=${child.id}" class="text-rose-600 hover:text-rose-800" onclick="return confirmDelete()"><i class="fas fa-trash"></i></a>
                            </div>
                        </div>
                        </c:if>
                        </c:forEach>
                    </div>
                    </c:if>
                    </c:forEach>
                    <c:if test="${empty deptList}">
                    <div class="flex items-center gap-3 p-4 bg-gray-50 rounded-xl">
                        <div class="w-10 h-10 bg-amber-100 rounded-lg flex items-center justify-center">
                            <i class="fas fa-building text-amber-600"></i>
                        </div>
                        <div class="flex-1">
                            <span class="font-bold text-gray-800">集团总部</span>
                            <span class="text-gray-400 text-sm ml-2">GROUP</span>
                        </div>
                        <span class="text-sm text-gray-500">根节点</span>
                        <div class="flex gap-2">
                            <a href="#" class="text-blue-600 hover:text-blue-800"><i class="fas fa-edit"></i></a>
                            <a href="#" class="text-rose-600 hover:text-rose-800" onclick="return confirmDelete()"><i class="fas fa-trash"></i></a>
                        </div>
                    </div>
                    <div class="ml-8 space-y-3">
                        <div class="flex items-center gap-3 p-4 bg-white border border-gray-200 rounded-xl">
                            <div class="w-10 h-10 bg-blue-100 rounded-lg flex items-center justify-center">
                                <i class="fas fa-briefcase text-blue-600"></i>
                            </div>
                            <div class="flex-1">
                                <span class="font-semibold text-gray-800">行政部</span>
                                <span class="text-gray-400 text-sm ml-2">XZ</span>
                            </div>
                            <span class="text-sm text-gray-500">资产: 128</span>
                            <div class="flex gap-2">
                                <a href="#" class="text-blue-600 hover:text-blue-800"><i class="fas fa-edit"></i></a>
                                <a href="#" class="text-rose-600 hover:text-rose-800" onclick="return confirmDelete()"><i class="fas fa-trash"></i></a>
                            </div>
                        </div>
                        <div class="flex items-center gap-3 p-4 bg-white border border-gray-200 rounded-xl">
                            <div class="w-10 h-10 bg-emerald-100 rounded-lg flex items-center justify-center">
                                <i class="fas fa-calculator text-emerald-600"></i>
                            </div>
                            <div class="flex-1">
                                <span class="font-semibold text-gray-800">财务部</span>
                                <span class="text-gray-400 text-sm ml-2">CW</span>
                            </div>
                            <span class="text-sm text-gray-500">资产: 86</span>
                            <div class="flex gap-2">
                                <a href="#" class="text-blue-600 hover:text-blue-800"><i class="fas fa-edit"></i></a>
                                <a href="#" class="text-rose-600 hover:text-rose-800" onclick="return confirmDelete()"><i class="fas fa-trash"></i></a>
                            </div>
                        </div>
                        <div class="flex items-center gap-3 p-4 bg-white border border-gray-200 rounded-xl">
                            <div class="w-10 h-10 bg-purple-100 rounded-lg flex items-center justify-center">
                                <i class="fas fa-code text-purple-600"></i>
                            </div>
                            <div class="flex-1">
                                <span class="font-semibold text-gray-800">技术部</span>
                                <span class="text-gray-400 text-sm ml-2">JS</span>
                            </div>
                            <span class="text-sm text-gray-500">资产: 245</span>
                            <div class="flex gap-2">
                                <a href="#" class="text-blue-600 hover:text-blue-800"><i class="fas fa-edit"></i></a>
                                <a href="#" class="text-rose-600 hover:text-rose-800" onclick="return confirmDelete()"><i class="fas fa-trash"></i></a>
                            </div>
                        </div>
                        <div class="flex items-center gap-3 p-4 bg-white border border-gray-200 rounded-xl">
                            <div class="w-10 h-10 bg-rose-100 rounded-lg flex items-center justify-center">
                                <i class="fas fa-user-tie text-rose-600"></i>
                            </div>
                            <div class="flex-1">
                                <span class="font-semibold text-gray-800">人事部</span>
                                <span class="text-gray-400 text-sm ml-2">RS</span>
                            </div>
                            <span class="text-sm text-gray-500">资产: 62</span>
                            <div class="flex gap-2">
                                <a href="#" class="text-blue-600 hover:text-blue-800"><i class="fas fa-edit"></i></a>
                                <a href="#" class="text-rose-600 hover:text-rose-800" onclick="return confirmDelete()"><i class="fas fa-trash"></i></a>
                            </div>
                        </div>
                        <div class="flex items-center gap-3 p-4 bg-white border border-gray-200 rounded-xl">
                            <div class="w-10 h-10 bg-cyan-100 rounded-lg flex items-center justify-center">
                                <i class="fas fa-server text-cyan-600"></i>
                            </div>
                            <div class="flex-1">
                                <span class="font-semibold text-gray-800">IT运维部</span>
                                <span class="text-gray-400 text-sm ml-2">IT</span>
                            </div>
                            <span class="text-sm text-gray-500">资产: 198</span>
                            <div class="flex gap-2">
                                <a href="#" class="text-blue-600 hover:text-blue-800"><i class="fas fa-edit"></i></a>
                                <a href="#" class="text-rose-600 hover:text-rose-800" onclick="return confirmDelete()"><i class="fas fa-trash"></i></a>
                            </div>
                        </div>
                    </div>
                    </c:if>
                </div>
            </div>
        </main>
<%@ include file="/views/common/footer.jsp" %>