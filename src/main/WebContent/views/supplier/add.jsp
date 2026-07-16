<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>新增供应商 - 企业轻量资产管理系统</title>
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
                    <h2 class="page-title">新增供应商</h2>
                    <p class="page-subtitle">添加供应商档案，用于采购关联</p>
                </div>
            </div>
            <div class="max-w-3xl mx-auto px-4">
                <div class="card p-6">
                    <form action="${pageContext.request.contextPath}/supplier/save" method="post">
                        <div class="grid grid-cols-2 gap-6">
                            <div class="form-group">
                                <label class="form-label">供应商名称 <span class="required">*</span></label>
                                <input type="text" name="supplierName" class="form-input" placeholder="如：联想科技有限公司" required>
                            </div>
                            <div class="form-group">
                                <label class="form-label">联系人</label>
                                <input type="text" name="contactPerson" class="form-input" placeholder="如：张经理">
                            </div>
                        </div>
                        <div class="grid grid-cols-2 gap-6 mt-4">
                            <div class="form-group">
                                <label class="form-label">联系电话</label>
                                <input type="text" name="phone" class="form-input" placeholder="如：13800138000">
                            </div>
                            <div class="form-group">
                                <label class="form-label">状态</label>
                                <select name="status" class="form-select">
                                    <option value="1">合作中</option>
                                    <option value="0">终止</option>
                                </select>
                            </div>
                        </div>
                        <div class="form-group mt-4">
                            <label class="form-label">地址</label>
                            <textarea name="address" rows="2" class="form-textarea" placeholder="如：北京市海淀区中关村大街1号"></textarea>
                        </div>
                        <div class="flex justify-end gap-3 pt-4 border-t mt-6">
                            <a href="${pageContext.request.contextPath}/supplier/list" class="btn btn-secondary">取消</a>
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
