<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>新增报废单 - 企业轻量资产管理系统</title>
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
                    <h2 class="page-title">新增报废单</h2>
                    <p class="page-subtitle">提交资产报废申请</p>
                </div>
            </div>

            <form action="${pageContext.request.contextPath}/scrap/list" method="post"
                  class="max-w-5xl mx-auto px-4 space-y-6">
                <div class="card p-6">
                    <h3 class="text-lg font-semibold mb-4">报废信息</h3>
                    <div class="grid grid-cols-2 gap-6">
                        <div class="form-group">
                            <label class="form-label">报废资产 <span class="required">*</span></label>
                            <select name="assetId" class="form-select" required>
                                <option value="">请选择资产</option>
                                <c:forEach items="${assetList}" var="a">
                                    <option value="${a.id}">${a.assetCode} - ${a.assetName}</option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="form-group">
                            <label class="form-label">报废类型 <span class="required">*</span></label>
                            <select name="scrapType" class="form-select" required>
                                <option value="1">达到年限</option>
                                <option value="2">技术淘汰</option>
                                <option value="3">无法修复</option>
                                <option value="4">其他</option>
                            </select>
                        </div>
                    </div>
                    <div class="mt-4">
                        <div class="form-group">
                            <label class="form-label">报废原因 <span class="required">*</span></label>
                            <textarea name="scrapReason" class="form-input" rows="4" placeholder="请详细描述报废原因" required></textarea>
                        </div>
                    </div>
                    <div class="grid grid-cols-2 gap-6 mt-4">
                        <div class="form-group">
                            <label class="form-label">资产原值 (¥)</label>
                            <input type="number" name="originalValue" class="form-input" step="0.01" min="0" placeholder="0.00">
                            <p class="text-gray-400 text-xs mt-1">留空则自动从资产档案读取</p>
                        </div>
                    </div>
                </div>

                <div class="flex justify-end gap-3 pb-6">
                    <a href="${pageContext.request.contextPath}/scrap/list" class="btn btn-secondary">取消</a>
                    <button type="submit" class="btn btn-primary">
                        <i class="fas fa-save mr-2"></i>提交报废单
                    </button>
                </div>
            </form>
        </main>
        <%@ include file="/views/common/footer.jsp" %>
    </div>
</div>
</body>
</html>
