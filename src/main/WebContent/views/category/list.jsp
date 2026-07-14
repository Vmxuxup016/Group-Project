<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>资产分类 - 企业轻量资产管理系统</title>
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
                    <h2 class="page-title">资产分类</h2>
                    <p class="page-subtitle">树形结构管理，支持三级分类</p>
                </div>
                <div class="flex gap-3">
                    <button onclick="expandAll()" class="btn btn-secondary">
                        <i class="fas fa-expand-alt mr-1"></i>全部展开
                    </button>
                    <button onclick="collapseAll()" class="btn btn-secondary">
                        <i class="fas fa-compress-alt mr-1"></i>全部收起
                    </button>
                    <a href="${pageContext.request.contextPath}/category/add" class="btn btn-primary">
                        <i class="fas fa-plus mr-2"></i>新增分类
                    </a>
                </div>
            </div>

            <c:if test="${param.error == 'has_children'}">
            <div class="bg-red-50 border border-red-200 text-red-700 px-4 py-3 rounded-lg mb-6 flex items-center gap-2">
                <i class="fas fa-exclamation-circle"></i>
                <span>该分类下存在子分类，请先删除子分类后再操作</span>
            </div>
            </c:if>

            <div class="card p-6">
                <div class="space-y-1" id="categoryTree">
                    <c:forEach items="${categoryList}" var="cat1">
                    <c:if test="${cat1.categoryLevel == 1}">
                    <div class="tree-node" data-level="1">
                        <div class="tree-item bg-gray-50 rounded-lg" onclick="toggleNode(this)">
                            <i class="tree-toggle fas fa-chevron-down text-gray-400 w-4 cursor-pointer transition-transform duration-200"></i>
                            <div class="w-8 h-8 bg-blue-100 rounded-lg flex items-center justify-center">
                                <i class="fas fa-folder text-blue-600 text-sm"></i>
                            </div>
                            <div class="flex-1">
                                <span class="font-semibold text-gray-800">${cat1.categoryName}</span>
                                <span class="text-gray-400 text-sm ml-2">${cat1.categoryCode}</span>
                                <span class="text-xs text-blue-500 ml-2">一级</span>
                            </div>
                            <span class="text-sm text-gray-500">折旧: ${cat1.depreciableLife}个月</span>
                            <div class="flex gap-2" onclick="event.stopPropagation()">
                                <a href="${pageContext.request.contextPath}/category/edit?id=${cat1.id}" class="text-blue-600 hover:text-blue-800"><i class="fas fa-edit"></i></a>
                                <a href="${pageContext.request.contextPath}/category/delete?id=${cat1.id}" class="text-rose-600 hover:text-rose-800" onclick="return confirmDelete()"><i class="fas fa-trash"></i></a>
                            </div>
                        </div>
                        <div class="tree-children ml-8 space-y-1">
                            <c:forEach items="${categoryList}" var="cat2">
                            <c:if test="${cat2.parentId == cat1.id && cat2.categoryLevel == 2}">
                            <div class="tree-node" data-level="2">
                                <div class="tree-item bg-gray-50 rounded-lg" onclick="toggleNode(this)">
                                    <i class="tree-toggle fas fa-chevron-down text-gray-400 w-4 cursor-pointer transition-transform duration-200"></i>
                                    <div class="w-8 h-8 bg-emerald-100 rounded-lg flex items-center justify-center">
                                        <i class="fas fa-tags text-emerald-600 text-sm"></i>
                                    </div>
                                    <div class="flex-1">
                                        <span class="font-semibold text-gray-800">${cat2.categoryName}</span>
                                        <span class="text-gray-400 text-sm ml-2">${cat2.categoryCode}</span>
                                        <span class="text-xs text-emerald-500 ml-2">二级</span>
                                    </div>
                                    <span class="text-sm text-gray-500">折旧: ${cat2.depreciableLife}个月</span>
                                    <div class="flex gap-2" onclick="event.stopPropagation()">
                                        <a href="${pageContext.request.contextPath}/category/edit?id=${cat2.id}" class="text-blue-600 hover:text-blue-800"><i class="fas fa-edit"></i></a>
                                        <a href="${pageContext.request.contextPath}/category/delete?id=${cat2.id}" class="text-rose-600 hover:text-rose-800" onclick="return confirmDelete()"><i class="fas fa-trash"></i></a>
                                    </div>
                                </div>
                                <div class="tree-children ml-8 space-y-1">
                                    <c:forEach items="${categoryList}" var="cat3">
                                    <c:if test="${cat3.parentId == cat2.id && cat3.categoryLevel == 3}">
                                    <div class="tree-node" data-level="3">
                                        <div class="tree-item bg-white border border-gray-200 rounded-lg">
                                            <div class="w-4"></div>
                                            <div class="w-8 h-8 bg-amber-100 rounded-lg flex items-center justify-center">
                                                <i class="fas fa-bookmark text-amber-600 text-sm"></i>
                                            </div>
                                            <div class="flex-1">
                                                <span class="font-medium text-gray-800">${cat3.categoryName}</span>
                                                <span class="text-gray-400 text-sm ml-2">${cat3.categoryCode}</span>
                                                <span class="text-xs text-amber-500 ml-2">三级</span>
                                            </div>
                                            <span class="text-sm text-gray-500">折旧: ${cat3.depreciableLife}个月</span>
                                            <div class="flex gap-2">
                                                <a href="${pageContext.request.contextPath}/category/edit?id=${cat3.id}" class="text-blue-600 hover:text-blue-800"><i class="fas fa-edit"></i></a>
                                                <a href="${pageContext.request.contextPath}/category/delete?id=${cat3.id}" class="text-rose-600 hover:text-rose-800" onclick="return confirmDelete()"><i class="fas fa-trash"></i></a>
                                            </div>
                                        </div>
                                    </div>
                                    </c:if>
                                    </c:forEach>
                                </div>
                            </div>
                            </c:if>
                            </c:forEach>
                        </div>
                    </div>
                    </c:if>
                    </c:forEach>
                    <c:if test="${empty categoryList}">
                    <div class="text-center py-12 text-gray-400">
                        <i class="fas fa-folder-open text-4xl mb-3"></i>
                        <p>暂无分类数据</p>
                    </div>
                    </c:if>
                </div>
            </div>
        </main>
<%@ include file="/views/common/footer.jsp" %>
<script>
function toggleNode(headerEl) {
    var node = headerEl.parentElement;
    var children = node.querySelector('.tree-children');
    if (!children) return;
    var toggle = headerEl.querySelector('.tree-toggle');
    if (children.style.display === 'none') {
        children.style.display = '';
        if (toggle) {
            toggle.classList.remove('fa-chevron-right');
            toggle.classList.add('fa-chevron-down');
        }
    } else {
        children.style.display = 'none';
        if (toggle) {
            toggle.classList.remove('fa-chevron-down');
            toggle.classList.add('fa-chevron-right');
        }
    }
}

function expandAll() {
    document.querySelectorAll('.tree-children').forEach(function(el) {
        el.style.display = '';
    });
    document.querySelectorAll('.tree-toggle').forEach(function(el) {
        el.classList.remove('fa-chevron-right');
        el.classList.add('fa-chevron-down');
    });
}

function collapseAll() {
    document.querySelectorAll('.tree-children').forEach(function(el) {
        el.style.display = 'none';
    });
    document.querySelectorAll('.tree-toggle').forEach(function(el) {
        el.classList.remove('fa-chevron-down');
        el.classList.add('fa-chevron-right');
    });
}
</script>
</div>
</body>
</html>
