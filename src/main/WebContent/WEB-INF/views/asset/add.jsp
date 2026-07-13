<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>新增资产 - 企业轻量资产管理系统</title>
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
                    <h2 class="page-title">新增资产</h2>
                    <p class="page-subtitle">录入新采购或入库的资产信息</p>
                </div>
            </div>

            <div class="card p-6 max-w-4xl">
                <form id="assetForm" action="${pageContext.request.contextPath}/asset/save" method="post" onsubmit="return validateForm('assetForm')">
                    <div class="grid grid-cols-2 gap-6">
                        <div class="form-group">
                            <label class="form-label">资产编码</label>
                            <input type="text" class="form-input" value="系统自动生成" disabled>
                        </div>
                        <div class="form-group">
                            <label class="form-label">资产名称 <span class="required">*</span></label>
                            <input type="text" name="assetName" class="form-input" placeholder="请输入资产名称" required>
                        </div>
                    </div>
                    <div class="grid grid-cols-2 gap-6">
                        <div class="form-group">
                            <label class="form-label">资产分类 <span class="required">*</span></label>
                            <select name="categoryId" class="form-select" required>
                                <option value="">请选择分类</option>
                                <c:forEach items="${categoryList}" var="cat">
                                <option value="${cat.id}">${cat.categoryName}</option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="form-group">
                            <label class="form-label">所属部门</label>
                            <select name="departmentId" class="form-select">
                                <option value="">在库</option>
                                <c:forEach items="${deptList}" var="dept">
                                <option value="${dept.id}">${dept.deptName}</option>
                                </c:forEach>
                            </select>
                        </div>
                    </div>
                    <div class="grid grid-cols-2 gap-6">
                        <div class="form-group">
                            <label class="form-label">品牌</label>
                            <input type="text" name="brand" class="form-input" placeholder="请输入品牌">
                        </div>
                        <div class="form-group">
                            <label class="form-label">型号</label>
                            <input type="text" name="model" class="form-input" placeholder="请输入型号">
                        </div>
                    </div>
                    <div class="grid grid-cols-2 gap-6">
                        <div class="form-group">
                            <label class="form-label">序列号(SN)</label>
                            <input type="text" name="snCode" class="form-input" placeholder="请输入序列号">
                        </div>
                        <div class="form-group">
                            <label class="form-label">RFID标签号</label>
                            <input type="text" name="rfidTag" class="form-input" placeholder="请输入RFID标签号">
                        </div>
                    </div>
                    <div class="grid grid-cols-2 gap-6">
                        <div class="form-group">
                            <label class="form-label">条形码</label>
                            <input type="text" name="barcode" class="form-input" placeholder="请输入条形码">
                        </div>
                        <div class="form-group">
                            <label class="form-label">采购价格</label>
                            <input type="number" name="purchasePrice" step="0.01" class="form-input" placeholder="0.00">
                        </div>
                    </div>
                    <div class="grid grid-cols-2 gap-6">
                        <div class="form-group">
                            <label class="form-label">采购日期</label>
                            <input type="date" name="purchaseDate" class="form-input">
                        </div>
                        <div class="form-group">
                            <label class="form-label">质保到期日</label>
                            <input type="date" name="warrantyExpiry" class="form-input">
                        </div>
                    </div>
                    <div class="grid grid-cols-2 gap-6">
                        <div class="form-group">
                            <label class="form-label">供应商</label>
                            <select name="supplierId" class="form-select">
                                <option value="">请选择供应商</option>
                                <c:forEach items="${supplierList}" var="sup">
                                <option value="${sup.id}">${sup.supplierName}</option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="form-group">
                            <label class="form-label">存放位置</label>
                            <input type="text" name="location" class="form-input" placeholder="请输入存放位置">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="form-label">备注</label>
                        <textarea name="remark" rows="3" class="form-textarea" placeholder="请输入备注信息"></textarea>
                    </div>
                    <div class="flex justify-end gap-3 pt-4 border-t">
                        <a href="${pageContext.request.contextPath}/asset/list" class="btn btn-secondary">取消</a>
                        <button type="submit" class="btn btn-primary">
                            <i class="fas fa-save mr-2"></i>保存
                        </button>
                    </div>
                </form>
            </div>
        </main>
<%@ include file="/WEB-INF/views/common/footer.jsp" %>