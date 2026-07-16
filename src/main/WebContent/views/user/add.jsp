<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>新增用户 - 企业轻量资产管理系统</title>
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
                    <h2 class="page-title">新增用户</h2>
                    <p class="page-subtitle">创建系统登录账号并分配角色权限</p>
                </div>
            </div>
            <div class="max-w-3xl mx-auto px-4">
                <div class="card p-6">
                    <form action="${pageContext.request.contextPath}/user/save" method="post">
                        <div class="grid grid-cols-2 gap-6">
                            <div class="form-group">
                                <label class="form-label">登录账号 <span class="required">*</span></label>
                                <input type="text" name="username" class="form-input" placeholder="字母或数字" required pattern="[A-Za-z0-9]{3,20}">
                            </div>
                            <div class="form-group">
                                <label class="form-label">真实姓名 <span class="required">*</span></label>
                                <input type="text" name="realName" class="form-input" placeholder="如：张三" required>
                            </div>
                        </div>
                        <div class="grid grid-cols-2 gap-6 mt-4">
                            <div class="form-group">
                                <label class="form-label">登录密码 <span class="required">*</span></label>
                                <input type="password" name="password" class="form-input" placeholder="默认：123456" required value="123456">
                                <p class="text-xs text-gray-400 mt-1">密码使用MD5加密存储</p>
                            </div>
                            <div class="form-group">
                                <label class="form-label">联系电话</label>
                                <input type="text" name="phone" class="form-input" placeholder="如：13800138000">
                            </div>
                        </div>
                        <div class="grid grid-cols-3 gap-6 mt-4">
                            <div class="form-group">
                                <label class="form-label">所属部门</label>
                                <select name="deptId" class="form-select">
                                    <option value="">未分配</option>
                                    <c:forEach items="${deptList}" var="d">
                                        <option value="${d.id}">${d.deptName}</option>
                                    </c:forEach>
                                </select>
                            </div>
                            <div class="form-group">
                                <label class="form-label">角色 <span class="required">*</span></label>
                                <select name="role" class="form-select" required>
                                    <option value="user">普通用户</option>
                                    <option value="asset">资产管理员</option>
                                    <option value="admin">管理员</option>
                                </select>
                            </div>
                            <div class="form-group">
                                <label class="form-label">状态</label>
                                <select name="status" class="form-select">
                                    <option value="1">正常</option>
                                    <option value="0">禁用</option>
                                </select>
                            </div>
                        </div>
                        <div class="flex justify-end gap-3 pt-4 border-t mt-6">
                            <a href="${pageContext.request.contextPath}/user/list" class="btn btn-secondary">取消</a>
                            <button type="submit" class="btn btn-primary"><i class="fas fa-save mr-2"></i>保存</button>
                        </div>
                    </form>
                </div>
            </div>
        </main>
        <%@ include file="/views/common/footer.jsp" %>
    </div>
</div>
</body>
</html>
