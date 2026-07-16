<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>编辑用户 - 企业轻量资产管理系统</title>
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
                    <h2 class="page-title">编辑用户</h2>
                    <p class="page-subtitle">修改用户信息与权限</p>
                </div>
            </div>
            <c:if test="${empty user}">
            <div class="card p-12 text-center">
                <i class="fas fa-exclamation-triangle text-5xl text-amber-400 mb-4"></i>
                <h3 class="text-xl font-bold text-gray-700 mb-2">用户不存在</h3>
                <a href="${pageContext.request.contextPath}/user/list" class="btn btn-primary">返回列表</a>
            </div>
            </c:if>
            <c:if test="${not empty user}">
            <div class="max-w-3xl mx-auto px-4">
                <div class="card p-6">
                    <form action="${pageContext.request.contextPath}/user/update" method="post">
                        <input type="hidden" name="id" value="${user.id}">
                        <div class="grid grid-cols-2 gap-6">
                            <div class="form-group">
                                <label class="form-label">登录账号</label>
                                <input type="text" class="form-input bg-gray-50" value="${user.username}" disabled>
                                <p class="text-xs text-gray-400 mt-1">账号不可修改</p>
                            </div>
                            <div class="form-group">
                                <label class="form-label">真实姓名 <span class="required">*</span></label>
                                <input type="text" name="realName" class="form-input" value="${user.realName}" required>
                            </div>
                        </div>
                        <div class="grid grid-cols-3 gap-6 mt-4">
                            <div class="form-group">
                                <label class="form-label">所属部门</label>
                                <select name="deptId" class="form-select">
                                    <option value="">未分配</option>
                                    <c:forEach items="${deptList}" var="d">
                                        <option value="${d.id}" ${user.deptId == d.id ? 'selected' : ''}>${d.deptName}</option>
                                    </c:forEach>
                                </select>
                            </div>
                            <div class="form-group">
                                <label class="form-label">角色 <span class="required">*</span></label>
                                <select name="role" class="form-select" required>
                                    <option value="user" ${user.role == 'user' ? 'selected' : ''}>普通用户</option>
                                    <option value="asset" ${user.role == 'asset' ? 'selected' : ''}>资产管理员</option>
                                    <option value="admin" ${user.role == 'admin' ? 'selected' : ''}>管理员</option>
                                </select>
                            </div>
                            <div class="form-group">
                                <label class="form-label">状态</label>
                                <select name="status" class="form-select">
                                    <option value="1" ${user.status == 1 ? 'selected' : ''}>正常</option>
                                    <option value="0" ${user.status == 0 ? 'selected' : ''}>禁用</option>
                                </select>
                            </div>
                        </div>
                        <div class="form-group mt-4">
                            <label class="form-label">联系电话</label>
                            <input type="text" name="phone" class="form-input" value="${user.phone}">
                        </div>
                        <div class="flex justify-end gap-3 pt-4 border-t mt-6">
                            <a href="${pageContext.request.contextPath}/user/list" class="btn btn-secondary">取消</a>
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
