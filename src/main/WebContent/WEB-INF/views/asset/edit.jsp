<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>编辑资产 - 企业轻量资产管理系统</title>
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
                    <h2 class="page-title">编辑资产</h2>
                    <p class="page-subtitle">修改资产信息</p>
                </div>
            </div>

            <div class="card p-6 max-w-4xl">
                <form id="assetForm" action="${pageContext.request.contextPath}/asset/update" method="post" onsubmit="return validateForm('assetForm')">
                    <input type="hidden" name="id" value="${asset.id}">
                    <div class="grid grid-cols-2 gap-6">
                        <div class="form-group">
                            <label class="form-label">资产编码</label>
                            <input type="text" class="form-input" value="${asset.assetCode}" disabled>
                        </div>
                        <div class="form-group">
                            <label class="form-label">资产名称 <span class="required">*</span></label>
                            <input type="text" name="assetName" class="form-input" value="${asset.assetName}" required>
                        </div>
                    </div>
                    <div class="grid grid-cols-2 gap-6">
                        <div class="form-group">
                            <label class="form-label">资产分类 <span class="required">*</span></label>
                            <select name="categoryId" class="form-select" required>
                                <option value="">请选择分类</option>
                                <c:forEach items="${categoryList}" var="cat">
                                <option value="${cat.id}" ${asset.categoryId == cat.id ? 'selected' : ''}>${cat.categoryName}</option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="form-group">
                            <label class="form-label">所属部门</label>
                            <select name="departmentId" class="form-select">
                                <option value="">在库</option>
                                <c:forEach items="${deptList}" var="dept">
                                <option value="${dept.id}" ${asset.departmentId == dept.id ? 'selected' : ''}>${dept.deptName}</option>
                                </c:forEach>
                            </select>
                        </div>
                    </div>
                    <div class="grid grid-cols-2 gap-6">
                        <div class="form-group">
                            <label class="form-label">品牌</label>
                            <input type="text" name="brand" class="form-input" value="${asset.brand}">
                        </div>
                        <div class="form-group">
                            <label class="form-label">型号</label>
                            <input type="text" name="model" class="form-input" value="${asset.model}">
                        </div>
                    </div>
                    <div class="grid grid-cols-2 gap-6">
                        <div class="form-group">
                            <label class="form-label">序列号(SN)</label>
                            <input type="text" name="snCode" class="form-input" value="${asset.snCode}">
                        </div>
                        <div class="form-group">
                            <label class="form-label">RFID标签号</label>
                            <input type="text" name="rfidTag" class="form-input" value="${asset.rfidTag}">
                        </div>
                    </div>
                    <div class="grid grid-cols-2 gap-6">
                        <div class="form-group">
                            <label class="form-label">条形码</label>
                            <input type="text" name="barcode" class="form-input" value="${asset.barcode}">
                        </div>
                        <div class="form-group">
                            <label class="form-label">采购价格</label>
                            <input type="number" name="purchasePrice" step="0.01" class="form-input" value="${asset.purchasePrice}">
                        </div>
                    </div>
                    <div class="grid grid-cols-2 gap-6">
                        <div class="form-group">
                            <label class="form-label">采购日期</label>
                            <input type="date" name="purchaseDate" class="form-input" value="${asset.purchaseDate}">
                        </div>
                        <div class="form-group">
                            <label class="form-label">质保到期日</label>
                            <input type="date" name="warrantyExpiry" class="form-input" value="${asset.warrantyExpiry}">
                        </div>
                    </div>
                    <div class="grid grid-cols-2 gap-6">
                        <div class="form-group">
                            <label class="form-label">供应商</label>
                            <select name="supplierId" class="form-select">
                                <option value="">请选择供应商</option>
                                <c:forEach items="${supplierList}" var="sup">
                                <option value="${sup.id}" ${asset.supplierId == sup.id ? 'selected' : ''}>${sup.supplierName}</option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="form-group">
                            <label class="form-label">存放位置</label>
                            <input type="text" name="location" class="form-input" value="${asset.location}">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="form-label">备注</label>
                        <textarea name="remark" rows="3" class="form-textarea">${asset.remark}</textarea>
                    </div>
                    <div class="flex justify-end gap-3 pt-4 border-t">
                        <a href="${pageContext.request.contextPath}/asset/list" class="btn btn-secondary">取消</a>
                        <button type="submit" class="btn btn-primary">
                            <i class="fas fa-save mr-2"></i>保存修改
                        </button>
                    </div>
                </form>
            </div>
        </main>
<%@ include file="/WEB-INF/views/common/footer.jsp" %>