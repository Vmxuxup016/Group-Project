<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>资产分类 - 企业轻量资产管理系统</title>
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
                    <h2 class="page-title">资产分类</h2>
                    <p class="page-subtitle">树形结构管理，支持三级分类</p>
                </div>
                <a href="${pageContext.request.contextPath}/category/add" class="btn btn-primary">
                    <i class="fas fa-plus mr-2"></i>新增分类
                </a>
            </div>

            <div class="card p-6">
                <div class="space-y-2">
                    <c:forEach items="${categoryList}" var="cat1">
                    <c:if test="${cat1.categoryLevel == 1}">
                    <div class="tree-item bg-gray-50">
                        <i class="fas fa-chevron-down text-gray-400 w-4 cursor-pointer"></i>
                        <div class="w-8 h-8 bg-blue-100 rounded-lg flex items-center justify-center">
                            <i class="fas fa-microchip text-blue-600 text-sm"></i>
                        </div>
                        <div class="flex-1">
                            <span class="font-semibold text-gray-800">${cat1.categoryName}</span>
                            <span class="text-gray-400 text-sm ml-2">${cat1.categoryCode}</span>
                        </div>
                        <span class="text-sm text-gray-500">默认折旧: ${cat1.depreciableLife}个月</span>
                        <div class="flex gap-2">
                            <a href="${pageContext.request.contextPath}/category/edit?id=${cat1.id}" class="text-blue-600 hover:text-blue-800"><i class="fas fa-edit"></i></a>
                            <a href="${pageContext.request.contextPath}/category/delete?id=${cat1.id}" class="text-rose-600 hover:text-rose-800" onclick="return confirmDelete()"><i class="fas fa-trash"></i></a>
                        </div>
                    </div>
                    <div class="tree-children space-y-2">
                        <c:forEach items="${categoryList}" var="cat2">
                        <c:if test="${cat2.parentId == cat1.id && cat2.categoryLevel == 2}">
                        <div class="tree-item bg-gray-50">
                            <i class="fas fa-chevron-down text-gray-400 w-4 cursor-pointer"></i>
                            <div class="w-8 h-8 bg-blue-100 rounded-lg flex items-center justify-center">
                                <i class="fas fa-laptop text-blue-600 text-sm"></i>
                            </div>
                            <div class="flex-1">
                                <span class="font-semibold text-gray-800">${cat2.categoryName}</span>
                                <span class="text-gray-400 text-sm ml-2">${cat2.categoryCode}</span>
                            </div>
                            <span class="text-sm text-gray-500">默认折旧: ${cat2.depreciableLife}个月</span>
                            <div class="flex gap-2">
                                <a href="${pageContext.request.contextPath}/category/edit?id=${cat2.id}" class="text-blue-600 hover:text-blue-800"><i class="fas fa-edit"></i></a>
                                <a href="${pageContext.request.contextPath}/category/delete?id=${cat2.id}" class="text-rose-600 hover:text-rose-800" onclick="return confirmDelete()"><i class="fas fa-trash"></i></a>
                            </div>
                        </div>
                        <div class="tree-children space-y-2">
                            <c:forEach items="${categoryList}" var="cat3">
                            <c:if test="${cat3.parentId == cat2.id && cat3.categoryLevel == 3}">
                            <div class="tree-item bg-white border border-gray-200">
                                <div class="w-4"></div>
                                <div class="w-8 h-8 bg-blue-100 rounded-lg flex items-center justify-center">
                                    <i class="fas fa-laptop-code text-blue-600 text-sm"></i>
                                </div>
                                <div class="flex-1">
                                    <span class="font-semibold text-gray-800">${cat3.categoryName}</span>
                                    <span class="text-gray-400 text-sm ml-2">${cat3.categoryCode}</span>
                                </div>
                                <span class="text-sm text-gray-500">默认折旧: ${cat3.depreciableLife}个月</span>
                                <div class="flex gap-2">
                                    <a href="${pageContext.request.contextPath}/category/edit?id=${cat3.id}" class="text-blue-600 hover:text-blue-800"><i class="fas fa-edit"></i></a>
                                    <a href="${pageContext.request.contextPath}/category/delete?id=${cat3.id}" class="text-rose-600 hover:text-rose-800" onclick="return confirmDelete()"><i class="fas fa-trash"></i></a>
                                </div>
                            </div>
                            </c:if>
                            </c:forEach>
                        </div>
                        </c:if>
                        </c:forEach>
                    </div>
                    </c:if>
                    </c:forEach>
                    <c:if test="${empty categoryList}">
                    <div class="tree-item bg-gray-50">
                        <i class="fas fa-chevron-down text-gray-400 w-4"></i>
                        <div class="w-8 h-8 bg-blue-100 rounded-lg flex items-center justify-center">
                            <i class="fas fa-microchip text-blue-600 text-sm"></i>
                        </div>
                        <div class="flex-1">
                            <span class="font-semibold text-gray-800">电子设备</span>
                            <span class="text-gray-400 text-sm ml-2">DZ</span>
                        </div>
                        <span class="text-sm text-gray-500">默认折旧: 36个月</span>
                        <div class="flex gap-2">
                            <a href="#" class="text-blue-600 hover:text-blue-800"><i class="fas fa-edit"></i></a>
                            <a href="#" class="text-rose-600 hover:text-rose-800" onclick="return confirmDelete()"><i class="fas fa-trash"></i></a>
                        </div>
                    </div>
                    <div class="tree-children space-y-2">
                        <div class="tree-item bg-gray-50">
                            <i class="fas fa-chevron-down text-gray-400 w-4"></i>
                            <div class="w-8 h-8 bg-blue-100 rounded-lg flex items-center justify-center">
                                <i class="fas fa-laptop text-blue-600 text-sm"></i>
                            </div>
                            <div class="flex-1">
                                <span class="font-semibold text-gray-800">计算机设备</span>
                                <span class="text-gray-400 text-sm ml-2">JSJ</span>
                            </div>
                            <span class="text-sm text-gray-500">默认折旧: 36个月</span>
                            <div class="flex gap-2">
                                <a href="#" class="text-blue-600 hover:text-blue-800"><i class="fas fa-edit"></i></a>
                                <a href="#" class="text-rose-600 hover:text-rose-800" onclick="return confirmDelete()"><i class="fas fa-trash"></i></a>
                            </div>
                        </div>
                        <div class="tree-children space-y-2">
                            <div class="tree-item bg-white border border-gray-200">
                                <div class="w-4"></div>
                                <div class="w-8 h-8 bg-blue-100 rounded-lg flex items-center justify-center">
                                    <i class="fas fa-laptop-code text-blue-600 text-sm"></i>
                                </div>
                                <div class="flex-1">
                                    <span class="font-semibold text-gray-800">笔记本电脑</span>
                                    <span class="text-gray-400 text-sm ml-2">NB</span>
                                </div>
                                <span class="text-sm text-gray-500">默认折旧: 36个月</span>
                                <div class="flex gap-2">
                                    <a href="#" class="text-blue-600 hover:text-blue-800"><i class="fas fa-edit"></i></a>
                                    <a href="#" class="text-rose-600 hover:text-rose-800" onclick="return confirmDelete()"><i class="fas fa-trash"></i></a>
                                </div>
                            </div>
                            <div class="tree-item bg-white border border-gray-200">
                                <div class="w-4"></div>
                                <div class="w-8 h-8 bg-blue-100 rounded-lg flex items-center justify-center">
                                    <i class="fas fa-desktop text-blue-600 text-sm"></i>
                                </div>
                                <div class="flex-1">
                                    <span class="font-semibold text-gray-800">台式电脑</span>
                                    <span class="text-gray-400 text-sm ml-2">PC</span>
                                </div>
                                <span class="text-sm text-gray-500">默认折旧: 36个月</span>
                                <div class="flex gap-2">
                                    <a href="#" class="text-blue-600 hover:text-blue-800"><i class="fas fa-edit"></i></a>
                                    <a href="#" class="text-rose-600 hover:text-rose-800" onclick="return confirmDelete()"><i class="fas fa-trash"></i></a>
                                </div>
                            </div>
                        </div>
                        <div class="tree-item bg-gray-50">
                            <i class="fas fa-chevron-right text-gray-400 w-4"></i>
                            <div class="w-8 h-8 bg-blue-100 rounded-lg flex items-center justify-center">
                                <i class="fas fa-network-wired text-blue-600 text-sm"></i>
                            </div>
                            <div class="flex-1">
                                <span class="font-semibold text-gray-800">网络设备</span>
                                <span class="text-gray-400 text-sm ml-2">WL</span>
                            </div>
                            <span class="text-sm text-gray-500">默认折旧: 36个月</span>
                            <div class="flex gap-2">
                                <a href="#" class="text-blue-600 hover:text-blue-800"><i class="fas fa-edit"></i></a>
                                <a href="#" class="text-rose-600 hover:text-rose-800" onclick="return confirmDelete()"><i class="fas fa-trash"></i></a>
                            </div>
                        </div>
                    </div>
                    <div class="tree-item bg-gray-50">
                        <i class="fas fa-chevron-right text-gray-400 w-4"></i>
                        <div class="w-8 h-8 bg-emerald-100 rounded-lg flex items-center justify-center">
                            <i class="fas fa-couch text-emerald-600 text-sm"></i>
                        </div>
                        <div class="flex-1">
                            <span class="font-semibold text-gray-800">办公家具</span>
                            <span class="text-gray-400 text-sm ml-2">BG</span>
                        </div>
                        <span class="text-sm text-gray-500">默认折旧: 60个月</span>
                        <div class="flex gap-2">
                            <a href="#" class="text-blue-600 hover:text-blue-800"><i class="fas fa-edit"></i></a>
                            <a href="#" class="text-rose-600 hover:text-rose-800" onclick="return confirmDelete()"><i class="fas fa-trash"></i></a>
                        </div>
                    </div>
                    </c:if>
                </div>
            </div>
        </main>
<%@ include file="/WEB-INF/views/common/footer.jsp" %>