<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${type == '1' ? '领用登记' : '归还登记'} - 企业轻量资产管理系统</title>
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
                    <h2 class="page-title">${type == '1' ? '领用登记' : '归还登记'}</h2>
                    <p class="page-subtitle">${type == '1' ? '将资产从仓库领用到使用部门' : '将资产从使用部门归还至仓库'}</p>
                </div>
            </div>

            <div class="card p-6 max-w-4xl">
                <c:if test="${errorMsg != null}">
                    <div class="bg-red-50 border border-red-200 text-red-700 px-4 py-3 rounded-lg mb-6 flex items-center gap-2">
                        <i class="fas fa-exclamation-circle"></i>
                        <span>${errorMsg}</span>
                    </div>
                </c:if>
                <form id="useForm" action="${pageContext.request.contextPath}/use/save" method="post">
                    <input type="hidden" name="operationType" value="${type}">
                    <input type="hidden" name="operatorId" value="1">

                    <div class="grid grid-cols-2 gap-6">
                        <div class="form-group">
                            <label class="form-label">资产 <span class="required">*</span></label>
                            <c:choose>
                                <c:when test="${asset != null}">
                                    <input type="text" class="form-input"
                                           value="${asset.assetCode} - ${asset.assetName}" disabled>
                                    <input type="hidden" name="assetId" value="${asset.id}">
                                </c:when>
                                <c:otherwise>
                                    <select name="assetId" class="form-select" required>
                                        <option value="">请选择资产</option>
                                        <c:forEach items="${assetList}" var="a">
                                            <option value="${a.id}">${a.assetCode} - ${a.assetName}</option>
                                        </c:forEach>
                                    </select>
                                </c:otherwise>
                            </c:choose>
                        </div>
                        <div class="form-group">
                            <label class="form-label">操作日期 <span class="required">*</span></label>
                            <input type="date" name="useDate" class="form-input" value="${today}" required>
                        </div>
                    </div>

                    <c:if test="${type == '1'}">
                        <div class="grid grid-cols-2 gap-6">
                            <div class="form-group">
                                <label class="form-label">领用部门 <span class="required">*</span></label>
                                <select name="toDeptId" class="form-select" required>
                                    <option value="">请选择领用部门</option>
                                    <c:forEach items="${deptList}" var="dept">
                                        <option value="${dept.id}">${dept.deptName}</option>
                                    </c:forEach>
                                </select>
                            </div>
                            <div class="form-group">
                                <label class="form-label">预计归还日期</label>
                                <input type="date" name="expectedReturnDate" class="form-input">
                            </div>
                        </div>
                        <input type="hidden" name="fromDeptId" value="">
                    </c:if>

                    <c:if test="${type == '2'}">
                        <div class="grid grid-cols-2 gap-6">
                            <div class="form-group">
                                <label class="form-label">归还来源部门 <span class="required">*</span></label>
                                <select name="fromDeptId" class="form-select" required>
                                    <option value="">请选择部门</option>
                                    <c:forEach items="${deptList}" var="dept">
                                        <option value="${dept.id}">${dept.deptName}</option>
                                    </c:forEach>
                                </select>
                            </div>
                            <div class="form-group">
                                <label class="form-label">归还至</label>
                                <input type="text" class="form-input" value="仓库（在库）" disabled>
                            </div>
                        </div>
                        <input type="hidden" name="toDeptId" value="">
                    </c:if>

                    <div class="form-group">
                        <label class="form-label">用途/原因</label>
                        <textarea name="purpose" rows="3" class="form-textarea"
                                  placeholder="${type == '1' ? '请输入领用用途' : '请输入归还说明'}"></textarea>
                    </div>

                    <div class="flex justify-end gap-3 pt-4 border-t">
                        <a href="${pageContext.request.contextPath}/use/list" class="btn btn-secondary">取消</a>
                        <button type="submit" class="btn btn-primary">
                            <i class="fas fa-save mr-2"></i>提交
                        </button>
                    </div>
                </form>
            </div>
        </main>
        <%@ include file="/views/common/footer.jsp" %>
