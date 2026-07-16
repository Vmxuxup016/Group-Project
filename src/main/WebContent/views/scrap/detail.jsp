<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>报废单详情 - 企业轻量资产管理系统</title>
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
                    <h2 class="page-title">报废单详情</h2>
                    <p class="page-subtitle">${scrap.scrapNo}</p>
                </div>
                <div class="flex gap-3">
                    <a href="${pageContext.request.contextPath}/scrap/list" class="btn btn-secondary">
                        <i class="fas fa-arrow-left mr-2"></i>返回列表
                    </a>
                </div>
            </div>

            <c:if test="${scrap == null}">
                <div class="card p-12 text-center text-gray-400">
                    <i class="fas fa-exclamation-circle text-4xl mb-3"></i>
                    <p>未找到该报废单</p>
                </div>
            </c:if>

            <c:if test="${scrap != null}">
            <div class="grid grid-cols-1 lg:grid-cols-3 gap-6">
                <!-- 左侧:报废信息 -->
                <div class="card p-6 lg:col-span-2">
                    <h3 class="font-bold text-gray-800 text-lg mb-4">报废信息</h3>
                    <div class="grid grid-cols-2 gap-4 text-sm">
                        <div class="flex justify-between py-2 border-b border-gray-100">
                            <span class="text-gray-500">报废单号</span>
                            <span class="font-mono font-medium text-blue-600">${scrap.scrapNo}</span>
                        </div>
                        <div class="flex justify-between py-2 border-b border-gray-100">
                            <span class="text-gray-500">资产名称</span>
                            <span class="font-medium">${scrap.assetName != null ? scrap.assetName : '-'}</span>
                        </div>
                        <div class="flex justify-between py-2 border-b border-gray-100">
                            <span class="text-gray-500">资产编码</span>
                            <span class="font-mono">${scrap.assetCode != null ? scrap.assetCode : '-'}</span>
                        </div>
                        <div class="flex justify-between py-2 border-b border-gray-100">
                            <span class="text-gray-500">报废类型</span>
                            <span>
                                <c:choose>
                                    <c:when test="${scrap.scrapType == 1}"><span class="status-badge" style="background:#dbeafe;color:#1e40af">达到年限</span></c:when>
                                    <c:when test="${scrap.scrapType == 2}"><span class="status-badge" style="background:#e0e7ff;color:#3730a3">技术淘汰</span></c:when>
                                    <c:when test="${scrap.scrapType == 3}"><span class="status-badge" style="background:#fee2e2;color:#991b1b">无法修复</span></c:when>
                                    <c:otherwise><span class="status-badge" style="background:#f3f4f6;color:#6b7280">其他</span></c:otherwise>
                                </c:choose>
                            </span>
                        </div>
                        <div class="flex justify-between py-2 border-b border-gray-100">
                            <span class="text-gray-500">状态</span>
                            <span>
                                <c:choose>
                                    <c:when test="${scrap.status == 1}"><span class="status-badge status-1">待审批</span></c:when>
                                    <c:when test="${scrap.status == 2}"><span class="status-badge status-2">已通过</span></c:when>
                                    <c:when test="${scrap.status == 3}"><span class="status-badge status-3">已执行</span></c:when>
                                    <c:when test="${scrap.status == 4}"><span class="status-badge status-4">驳回</span></c:when>
                                </c:choose>
                            </span>
                        </div>
                        <div class="flex justify-between py-2 border-b border-gray-100">
                            <span class="text-gray-500">资产原值</span>
                            <span class="font-medium"><fmt:formatNumber value="${scrap.originalValue}" type="currency" currencySymbol="¥"/></span>
                        </div>
                        <div class="flex justify-between py-2 border-b border-gray-100">
                            <span class="text-gray-500">残值</span>
                            <span class="font-medium text-amber-600"><fmt:formatNumber value="${scrap.scrapValue}" type="currency" currencySymbol="¥"/></span>
                        </div>
                        <div class="flex justify-between py-2 border-b border-gray-100">
                            <span class="text-gray-500">处置方式</span>
                            <span>
                                <c:choose>
                                    <c:when test="${scrap.disposeMethod == 1}">回收</c:when>
                                    <c:when test="${scrap.disposeMethod == 2}">捐赠</c:when>
                                    <c:when test="${scrap.disposeMethod == 3}">出售</c:when>
                                    <c:when test="${scrap.disposeMethod == 4}">环保处理</c:when>
                                    <c:otherwise>-</c:otherwise>
                                </c:choose>
                            </span>
                        </div>
                        <div class="flex justify-between py-2 border-b border-gray-100">
                            <span class="text-gray-500">执行日期</span>
                            <span>${scrap.executeDate != null ? scrap.executeDate : '-'}</span>
                        </div>
                    </div>

                    <!-- 报废原因 -->
                    <div class="mt-6">
                        <h4 class="font-semibold text-gray-800 mb-2">报废原因</h4>
                        <div class="bg-gray-50 rounded-lg p-4 text-sm text-gray-700">${scrap.scrapReason}</div>
                    </div>
                </div>

                <!-- 右侧:审批和执行信息 -->
                <div class="space-y-6">
                    <div class="card p-6">
                        <h3 class="font-bold text-gray-800 text-lg mb-4">审批信息</h3>
                        <div class="space-y-3 text-sm">
                            <div class="flex justify-between">
                                <span class="text-gray-500">申请人ID</span>
                                <span>${scrap.createBy != null ? scrap.createBy : '-'}</span>
                            </div>
                            <div class="flex justify-between">
                                <span class="text-gray-500">创建时间</span>
                                <span>${scrap.createTime != null ? scrap.createTime : '-'}</span>
                            </div>
                        </div>
                    </div>

                    <div class="card p-6">
                        <h3 class="font-bold text-gray-800 text-lg mb-4">执行信息</h3>
                        <div class="space-y-3 text-sm">
                            <div class="flex justify-between">
                                <span class="text-gray-500">执行人ID</span>
                                <span>${scrap.executorId != null ? scrap.executorId : '-'}</span>
                            </div>
                            <div class="flex justify-between">
                                <span class="text-gray-500">执行日期</span>
                                <span>${scrap.executeDate != null ? scrap.executeDate : '未执行'}</span>
                            </div>
                        </div>
                    </div>

                    <!-- 操作按钮 -->
                    <div class="card p-6">
                        <h3 class="font-bold text-gray-800 text-lg mb-4">快捷操作</h3>
                        <div class="space-y-2">
                            <c:if test="${scrap.status == 1}">
                                <a href="${pageContext.request.contextPath}/scrap/approve?id=${scrap.id}&action=pass" class="btn btn-success w-full justify-center">
                                    <i class="fas fa-check mr-2"></i>审批通过
                                </a>
                                <a href="${pageContext.request.contextPath}/scrap/approve?id=${scrap.id}&action=reject" class="btn btn-danger w-full justify-center">
                                    <i class="fas fa-times mr-2"></i>审批驳回
                                </a>
                            </c:if>
                            <c:if test="${scrap.status == 2}">
                                <a href="${pageContext.request.contextPath}/scrap/execute?id=${scrap.id}" class="btn btn-success w-full justify-center">
                                    <i class="fas fa-play mr-2"></i>执行报废
                                </a>
                            </c:if>
                        </div>
                    </div>
                </div>
            </div>
            </c:if>
        </main>
        <%@ include file="/views/common/footer.jsp" %>
    </div>
</div>
</body>
</html>
