<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>资产详情 - 企业轻量资产管理系统</title>
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
                    <h2 class="page-title">资产详情</h2>
                    <p class="page-subtitle">${asset.assetName}</p>
                </div>
                <div class="flex gap-3">
                    <a href="${pageContext.request.contextPath}/asset/edit?id=${asset.id}" class="btn btn-primary">
                        <i class="fas fa-edit mr-2"></i>编辑
                    </a>
                    <a href="${pageContext.request.contextPath}/asset/list" class="btn btn-secondary">
                        <i class="fas fa-arrow-left mr-2"></i>返回
                    </a>
                </div>
            </div>

            <div class="grid grid-cols-1 lg:grid-cols-3 gap-6">
                <div class="card p-6 lg:col-span-2">
                    <h3 class="font-bold text-gray-800 text-lg mb-4">基本信息</h3>
                    <div class="grid grid-cols-2 gap-4 text-sm">
                        <div class="flex justify-between py-2 border-b border-gray-100">
                            <span class="text-gray-500">资产编码</span>
                            <span class="font-mono font-medium">${asset.assetCode}</span>
                        </div>
                        <div class="flex justify-between py-2 border-b border-gray-100">
                            <span class="text-gray-500">资产名称</span>
                            <span class="font-medium">${asset.assetName}</span>
                        </div>
                        <div class="flex justify-between py-2 border-b border-gray-100">
                            <span class="text-gray-500">分类</span>
                            <span>${asset.categoryName}</span>
                        </div>
                        <div class="flex justify-between py-2 border-b border-gray-100">
                            <span class="text-gray-500">品牌/型号</span>
                            <span>${asset.brand} / ${asset.model}</span>
                        </div>
                        <div class="flex justify-between py-2 border-b border-gray-100">
                            <span class="text-gray-500">序列号</span>
                            <span class="font-mono">${asset.snCode != null ? asset.snCode : '-'}</span>
                        </div>
                        <div class="flex justify-between py-2 border-b border-gray-100">
                            <span class="text-gray-500">RFID标签</span>
                            <span class="font-mono">${asset.rfidTag != null ? asset.rfidTag : '-'}</span>
                        </div>
                        <div class="flex justify-between py-2 border-b border-gray-100">
                            <span class="text-gray-500">状态</span>
                            <span>
                                <c:choose>
                                    <c:when test="${asset.status == 1}"><span class="status-badge status-1">在库</span></c:when>
                                    <c:when test="${asset.status == 2}"><span class="status-badge status-2">部门在用</span></c:when>
                                    <c:when test="${asset.status == 3}"><span class="status-badge status-3">维修中</span></c:when>
                                    <c:when test="${asset.status == 4}"><span class="status-badge status-4">报废</span></c:when>
                                    <c:when test="${asset.status == 5}"><span class="status-badge status-5">调拨中</span></c:when>
                                </c:choose>
                            </span>
                        </div>
                        <div class="flex justify-between py-2 border-b border-gray-100">
                            <span class="text-gray-500">所属部门</span>
                            <span>${asset.deptName != null ? asset.deptName : '-'}</span>
                        </div>
                        <div class="flex justify-between py-2 border-b border-gray-100">
                            <span class="text-gray-500">存放位置</span>
                            <span>${asset.location != null ? asset.location : '-'}</span>
                        </div>
                        <div class="flex justify-between py-2 border-b border-gray-100">
                            <span class="text-gray-500">采购日期</span>
                            <span>${asset.purchaseDate != null ? asset.purchaseDate : '-'}</span>
                        </div>
                        <div class="flex justify-between py-2 border-b border-gray-100">
                            <span class="text-gray-500">采购价格</span>
                            <span class="font-medium"><fmt:formatNumber value="${asset.purchasePrice}" type="currency" currencySymbol="¥"/></span>
                        </div>
                        <div class="flex justify-between py-2 border-b border-gray-100">
                            <span class="text-gray-500">当前净值</span>
                            <span class="font-medium text-emerald-600"><fmt:formatNumber value="${asset.currentValue}" type="currency" currencySymbol="¥"/></span>
                        </div>
                        <div class="flex justify-between py-2 border-b border-gray-100">
                            <span class="text-gray-500">供应商</span>
                            <span>${asset.supplierName != null ? asset.supplierName : '-'}</span>
                        </div>
                        <div class="flex justify-between py-2 border-b border-gray-100">
                            <span class="text-gray-500">质保到期</span>
                            <span>${asset.warrantyExpiry != null ? asset.warrantyExpiry : '-'}</span>
                        </div>
                    </div>
                </div>

                <div class="space-y-6">
                    <div class="card p-6">
                        <h3 class="font-bold text-gray-800 text-lg mb-4">折旧信息</h3>
                        <div class="space-y-3 text-sm">
                            <div class="flex justify-between">
                                <span class="text-gray-500">折旧总月数</span>
                                <span>${asset.depreciableMonths} 个月</span>
                            </div>
                            <div class="flex justify-between">
                                <span class="text-gray-500">已折旧月数</span>
                                <span>${asset.depreciatedMonths} 个月</span>
                            </div>
                            <div class="flex justify-between">
                                <span class="text-gray-500">折旧开始日期</span>
                                <span>${asset.depreciableStartDate != null ? asset.depreciableStartDate : '-'}</span>
                            </div>
                            <div class="mt-4">
                                <div class="flex justify-between text-sm mb-1">
                                    <span>折旧进度</span>
                                    <span>${asset.depreciableMonths > 0 ? asset.depreciatedMonths * 100 / asset.depreciableMonths : 0}%</span>
                                </div>
                                <div class="progress-bar">
                                    <div class="progress-fill bg-blue-500" style="width: ${asset.depreciableMonths > 0 ? asset.depreciatedMonths * 100 / asset.depreciableMonths : 0}%"></div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="card p-6">
                        <h3 class="font-bold text-gray-800 text-lg mb-4">快捷操作</h3>
                        <div class="space-y-2">
                            <a href="${pageContext.request.contextPath}/use/add?assetId=${asset.id}" class="btn btn-success w-full justify-center">
                                <i class="fas fa-hand-holding mr-2"></i>领用登记
                            </a>
                            <a href="${pageContext.request.contextPath}/repair/add?assetId=${asset.id}" class="btn btn-warning w-full justify-center">
                                <i class="fas fa-tools mr-2"></i>报修登记
                            </a>
                            <a href="${pageContext.request.contextPath}/scrap/add?assetId=${asset.id}" class="btn btn-danger w-full justify-center">
                                <i class="fas fa-trash-alt mr-2"></i>报废申请
                            </a>
                            <a href="${pageContext.request.contextPath}/transfer/add?assetId=${asset.id}" class="btn btn-secondary w-full justify-center">
                                <i class="fas fa-exchange-alt mr-2"></i>调拨申请
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </main>
<%@ include file="/views/common/footer.jsp" %>