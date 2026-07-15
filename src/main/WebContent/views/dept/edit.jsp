<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>编辑部门 - 企业轻量资产管理系统</title>
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
                    <h2 class="page-title">编辑部门</h2>
                    <p class="page-subtitle">修改部门信息</p>
                </div>
            </div>
            <c:if test="${empty dept}">
            <div class="card p-12 text-center">
                <i class="fas fa-exclamation-triangle text-5xl text-amber-400 mb-4"></i>
                <h3 class="text-xl font-bold text-gray-700 mb-2">部门不存在</h3>
                <a href="${pageContext.request.contextPath}/dept/list" class="btn btn-primary">返回列表</a>
            </div>
            </c:if>
            <c:if test="${not empty dept}">
            <div class="max-w-3xl mx-auto px-4">
                <div class="card p-6">
                    <form action="${pageContext.request.contextPath}/dept/update" method="post">
                        <input type="hidden" name="id" value="${dept.id}">
                        <div class="grid grid-cols-2 gap-6">
                            <div class="form-group">
                                <label class="form-label">部门名称 <span class="required">*</span></label>
                                <input type="text" name="deptName" class="form-input" value="${dept.deptName}" required>
                            </div>
                            <div class="form-group">
                                <label class="form-label">部门编码 <span class="required">*</span></label>
                                <input type="text" name="deptCode" class="form-input" value="${dept.deptCode}" required>
                            </div>
                        </div>
                        <div class="grid grid-cols-2 gap-6 mt-4">
                            <div class="form-group">
                                <label class="form-label">上级部门</label>
                                <select name="parentId" class="form-select">
                                    <option value="0" ${dept.parentId == 0 ? 'selected' : ''}>无（顶级部门）</option>
                                    <c:forEach items="${deptList}" var="d">
                                        <c:if test="${d.parentId == 0 && d.id != dept.id}">
                                        <option value="${d.id}" ${dept.parentId == d.id ? 'selected' : ''}>${d.deptName}</option>
                                        </c:if>
                                    </c:forEach>
                                </select>
                            </div>
                            <div class="form-group">
                                <label class="form-label">排序</label>
                                <input type="number" name="sortOrder" class="form-input" value="${dept.sortOrder}" min="0">
                            </div>
                        </div>
                        <div class="flex justify-end gap-3 pt-4 border-t mt-6">
                            <a href="${pageContext.request.contextPath}/dept/list" class="btn btn-secondary">取消</a>
                            <button type="submit" class="btn btn-primary"><i class="fas fa-save mr-2"></i>保存修改</button>
                        </div>
                    </form>
                </div>
            </div>
            </c:if>
        </main>
        <%@ include file="/views/common/footer.jsp" %>
    </div>
</div>
</body>
</html>
