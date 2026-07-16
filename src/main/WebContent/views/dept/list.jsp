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

            <c:if test="${not empty deleteError}">
            <div class="mb-4 p-4 bg-red-50 border border-red-200 rounded-xl text-red-700 text-sm">
                <i class="fas fa-exclamation-circle mr-2"></i>${deleteError}
            </div>
            </c:if>

            <div class="card p-6">
                <div class="space-y-2">
                    <c:forEach items="${deptTreeList}" var="item">
                    <c:set var="d" value="${item.dept}"/>
                    <c:set var="depth" value="${item.depth}"/>
                    <div class="flex items-center gap-3 p-4 rounded-xl transition hover:shadow-sm
                        <c:choose>
                            <c:when test="${depth == 0}">bg-amber-50 border border-amber-200</c:when>
                            <c:when test="${depth == 1}">bg-white border border-gray-200 ml-8</c:when>
                            <c:otherwise>bg-gray-50 border border-gray-100 ml-16</c:otherwise>
                        </c:choose>"
                        style="margin-left: <c:out value='${depth * 32}'/>px;">

                        <c:choose>
                            <c:when test="${depth == 0}">
                                <div class="w-10 h-10 bg-amber-100 rounded-lg flex items-center justify-center">
                                    <i class="fas fa-building text-amber-600"></i>
                                </div>
                            </c:when>
                            <c:when test="${depth == 1}">
                                <div class="w-10 h-10 bg-blue-100 rounded-lg flex items-center justify-center">
                                    <i class="fas fa-briefcase text-blue-600"></i>
                                </div>
                            </c:when>
                            <c:otherwise>
                                <div class="w-10 h-10 bg-emerald-100 rounded-lg flex items-center justify-center">
                                    <i class="fas fa-sitemap text-emerald-600"></i>
                                </div>
                            </c:otherwise>
                        </c:choose>

                        <div class="flex-1 min-w-0">
                            <span class="font-semibold text-gray-800">${d.deptName}</span>
                            <span class="text-gray-400 text-sm ml-2">${d.deptCode}</span>
                        </div>

                        <c:choose>
                            <c:when test="${depth == 0}">
                                <span class="text-xs px-2 py-1 bg-amber-100 text-amber-700 rounded-full">顶级部门</span>
                            </c:when>
                            <c:otherwise>
                                <span class="text-sm text-gray-400">第${depth + 1}级</span>
                            </c:otherwise>
                        </c:choose>

                        <div class="flex gap-2">
                            <a href="${pageContext.request.contextPath}/dept/edit?id=${d.id}" class="text-blue-600 hover:text-blue-800" title="编辑"><i class="fas fa-edit"></i></a>
                            <a href="${pageContext.request.contextPath}/dept/delete?id=${d.id}" class="text-rose-600 hover:text-rose-800" title="删除" onclick="return confirm('确定删除部门【${d.deptName}】吗？如有子部门将无法删除。')"><i class="fas fa-trash"></i></a>
                        </div>
                    </div>
                    </c:forEach>

                    <c:if test="${empty deptTreeList}">
                    <div class="text-center py-12 text-gray-400">
                        <i class="fas fa-building text-5xl mb-4 opacity-30"></i>
                        <p>暂无部门数据，请先新增部门</p>
                    </div>
                    </c:if>
                </div>
            </div>
        </main>
<%@ include file="/views/common/footer.jsp" %>
</div>
</body>
</html>
