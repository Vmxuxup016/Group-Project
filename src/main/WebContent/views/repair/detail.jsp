<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>维修单详情 - 企业轻量资产管理系统</title>
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
                    <h2 class="page-title">维修单详情</h2>
                    <p class="page-subtitle">${repair.repairNo}</p>
                </div>
                <div class="flex gap-3">
                    <a href="${pageContext.request.contextPath}/repair/list" class="btn btn-secondary">
                        <i class="fas fa-arrow-left mr-2"></i>返回列表
                    </a>
                </div>
            </div>

            <c:if test="${repair == null}">
                <div class="card p-12 text-center text-gray-400">
                    <i class="fas fa-exclamation-circle text-4xl mb-3"></i>
                    <p>未找到该维修单</p>
                </div>
            </c:if>

            <c:if test="${repair != null}">
            <div class="grid grid-cols-1 lg:grid-cols-3 gap-6">
                <!-- 左侧:维修信息 -->
                <div class="card p-6 lg:col-span-2">
                    <h3 class="font-bold text-gray-800 text-lg mb-4">维修信息</h3>
                    <div class="grid grid-cols-2 gap-4 text-sm">
                        <div class="flex justify-between py-2 border-b border-gray-100">
                            <span class="text-gray-500">维修单号</span>
                            <span class="font-mono font-medium text-blue-600">${repair.repairNo}</span>
                        </div>
                        <div class="flex justify-between py-2 border-b border-gray-100">
                            <span class="text-gray-500">资产名称</span>
                            <span class="font-medium">${repair.assetName != null ? repair.assetName : '-'}</span>
                        </div>
                        <div class="flex justify-between py-2 border-b border-gray-100">
                            <span class="text-gray-500">资产编码</span>
                            <span class="font-mono">${repair.assetCode != null ? repair.assetCode : '-'}</span>
                        </div>
                        <div class="flex justify-between py-2 border-b border-gray-100">
                            <span class="text-gray-500">报修部门</span>
                            <span>${repair.deptName != null ? repair.deptName : '-'}</span>
                        </div>
                        <div class="flex justify-between py-2 border-b border-gray-100">
                            <span class="text-gray-500">故障类型</span>
                            <span>
                                <c:choose>
                                    <c:when test="${repair.faultType == 1}"><span class="status-badge" style="background:#fee2e2;color:#991b1b">硬件故障</span></c:when>
                                    <c:when test="${repair.faultType == 2}"><span class="status-badge" style="background:#dbeafe;color:#1e40af">软件故障</span></c:when>
                                    <c:when test="${repair.faultType == 3}"><span class="status-badge" style="background:#fef3c7;color:#92400e">人为损坏</span></c:when>
                                    <c:otherwise><span class="status-badge" style="background:#f3f4f6;color:#6b7280">其他</span></c:otherwise>
                                </c:choose>
                            </span>
                        </div>
                        <div class="flex justify-between py-2 border-b border-gray-100">
                            <span class="text-gray-500">维修方式</span>
                            <span>
                                <c:choose>
                                    <c:when test="${repair.repairMethod == 1}">自行维修</c:when>
                                    <c:when test="${repair.repairMethod == 2}">厂商保修</c:when>
                                    <c:when test="${repair.repairMethod == 3}">第三方维修</c:when>
                                    <c:otherwise>-</c:otherwise>
                                </c:choose>
                            </span>
                        </div>
                        <div class="flex justify-between py-2 border-b border-gray-100">
                            <span class="text-gray-500">维修费用</span>
                            <span class="font-medium text-amber-600"><fmt:formatNumber value="${repair.repairCost}" type="currency" currencySymbol="¥"/></span>
                        </div>
                        <div class="flex justify-between py-2 border-b border-gray-100">
                            <span class="text-gray-500">状态</span>
                            <span>
                                <c:choose>
                                    <c:when test="${repair.repairStatus == 1}"><span class="status-badge status-1">待维修</span></c:when>
                                    <c:when test="${repair.repairStatus == 2}"><span class="status-badge status-3">维修中</span></c:when>
                                    <c:when test="${repair.repairStatus == 3}"><span class="status-badge status-2">已完成</span></c:when>
                                    <c:when test="${repair.repairStatus == 4}"><span class="status-badge status-4">无法修复</span></c:when>
                                </c:choose>
                            </span>
                        </div>
                        <div class="flex justify-between py-2 border-b border-gray-100">
                            <span class="text-gray-500">开始日期</span>
                            <span>${repair.startDate != null ? repair.startDate : '-'}</span>
                        </div>
                        <div class="flex justify-between py-2 border-b border-gray-100">
                            <span class="text-gray-500">完成日期</span>
                            <span>${repair.finishDate != null ? repair.finishDate : '-'}</span>
                        </div>
                    </div>

                    <!-- 故障描述 -->
                    <div class="mt-6">
                        <h4 class="font-semibold text-gray-800 mb-2">故障描述</h4>
                        <div class="bg-gray-50 rounded-lg p-4 text-sm text-gray-700">${repair.faultDesc}</div>
                    </div>

                    <!-- 维修结果 -->
                    <c:if test="${repair.repairResult != null && repair.repairResult != ''}">
                    <div class="mt-4">
                        <h4 class="font-semibold text-gray-800 mb-2">维修结果</h4>
                        <div class="bg-gray-50 rounded-lg p-4 text-sm text-gray-700">${repair.repairResult}</div>
                    </div>
                    </c:if>
                </div>

                <!-- 右侧:时间和操作 -->
                <div class="space-y-6">
                    <div class="card p-6">
                        <h3 class="font-bold text-gray-800 text-lg mb-4">时间信息</h3>
                        <div class="space-y-3 text-sm">
                            <div class="flex justify-between">
                                <span class="text-gray-500">创建时间</span>
                                <span>${repair.createTime != null ? repair.createTime : '-'}</span>
                            </div>
                            <div class="flex justify-between">
                                <span class="text-gray-500">更新时间</span>
                                <span>${repair.updateTime != null ? repair.updateTime : '-'}</span>
                            </div>
                        </div>
                    </div>

                    <div class="card p-6">
                        <h3 class="font-bold text-gray-800 text-lg mb-4">操作记录</h3>
                        <div class="space-y-2 text-sm">
                            <div class="flex justify-between">
                                <span class="text-gray-500">登记人ID</span>
                                <span>${repair.operatorId != null ? repair.operatorId : '-'}</span>
                            </div>
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
