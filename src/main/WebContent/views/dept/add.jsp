<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>新增部门 - 企业轻量资产管理系统</title>
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
                    <h2 class="page-title">新增部门</h2>
                    <p class="page-subtitle">添加组织架构节点，支持树形层级</p>
                </div>
            </div>
            <div class="max-w-3xl mx-auto px-4">
                <c:if test="${not empty errorMsg}">
                <div id="errorAlert" class="mb-4 p-4 bg-red-50 border border-red-200 rounded-xl text-red-700 text-sm flex items-center justify-between">
                    <span><i class="fas fa-exclamation-circle mr-2"></i>${errorMsg}</span>
                    <button type="button" onclick="this.parentElement.remove()" class="text-red-400 hover:text-red-600"><i class="fas fa-times"></i></button>
                </div>
                </c:if>
                <div class="card p-6">
                    <form id="deptForm" action="${pageContext.request.contextPath}/dept/save" method="post">
                        <div class="grid grid-cols-2 gap-6">
                            <div class="form-group">
                                <label class="form-label">部门名称 <span class="required">*</span></label>
                                <input type="text" name="deptName" class="form-input" placeholder="如：技术部" required>
                            </div>
                            <div class="form-group">
                                <label class="form-label">部门编码 <span class="required">*</span></label>
                                <input type="text" name="deptCode" class="form-input" placeholder="如：JS" required>
                            </div>
                        </div>
                        <div class="grid grid-cols-2 gap-6 mt-4">
                            <div class="form-group">
                                <label class="form-label">上级部门</label>
                                <select name="parentId" class="form-select">
                                    <option value="0">无（顶级部门）</option>
                                    <c:forEach items="${deptTreeList}" var="item">
                                    <c:set var="d" value="${item.dept}"/>
                                    <c:set var="depth" value="${item.depth}"/>
                                    <option value="${d.id}">${item.displayName}</option>
                                    </c:forEach>
                                </select>
                            </div>
                            <div class="form-group">
                                <label class="form-label">排序</label>
                                <input type="number" name="sortOrder" class="form-input" value="0" min="0">
                                <p class="text-xs text-gray-400 mt-1">数值越小越靠前</p>
                            </div>
                        </div>
                        <div class="flex justify-end gap-3 pt-4 border-t mt-6">
                            <a href="${pageContext.request.contextPath}/dept/list" class="btn btn-secondary">取消</a>
                            <button type="submit" class="btn btn-primary"><i class="fas fa-save mr-2"></i>保存</button>
                        </div>
                    </form>
                </div>
            </div>
        </main>
        <%@ include file="/views/common/footer.jsp" %>
    </div>
</div>

<script>
    var existingDeptNames = [
        <c:forEach items="${deptTreeList}" var="item" varStatus="status">
        "${item.dept.deptName}"<c:if test="${!status.last}">,</c:if>
        </c:forEach>
    ];

    document.getElementById('deptForm').addEventListener('submit', function(e) {
        var deptName = document.querySelector('input[name="deptName"]').value.trim();
        var deptCode = document.querySelector('input[name="deptCode"]').value.trim();

        if (!deptName) {
            alert('部门名称不能为空');
            e.preventDefault();
            return false;
        }

        var chineseReg = /^[\u4e00-\u9fa5]+$/;
        if (!chineseReg.test(deptName)) {
            alert('部门名称必须全部为汉字，不能包含字母、数字或特殊字符');
            e.preventDefault();
            return false;
        }

        if (!deptCode) {
            alert('部门编码不能为空');
            e.preventDefault();
            return false;
        }

        for (var i = 0; i < existingDeptNames.length; i++) {
            if (existingDeptNames[i] === deptName) {
                alert('部门名称「' + deptName + '」已存在，请勿重复添加');
                e.preventDefault();
                return false;
            }
        }
    });
</script>
</body>
</html>
