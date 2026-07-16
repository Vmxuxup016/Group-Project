<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>调拨详情 - 企业轻量资产管理系统</title>
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
                    <h2 class="page-title">调拨详情</h2>
                    <p class="page-subtitle">${record.assetName} - 调拨审批记录</p>
                </div>
                <div class="flex gap-3">
                    <c:if test="${record.approvalStatus == 1}">
                    <a href="${pageContext.request.contextPath}/transfer/approve?id=${record.id}&action=pass"
                       class="btn btn-success" onclick="return confirm('确定通过此调拨申请吗？资产将转移至目标部门。')">
                        <i class="fas fa-check mr-2"></i>审批通过
                    </a>
                    <a href="${pageContext.request.contextPath}/transfer/approve?id=${record.id}&action=reject"
                       class="btn" style="background:#dc2626;color:white"
                       onclick="return confirm('确定驳回此调拨申请吗？资产将恢复原状态。')">
                        <i class="fas fa-times mr-2"></i>驳回
                    </a>
                    </c:if>
                    <a href="${pageContext.request.contextPath}/transfer/list" class="btn btn-secondary">
                        <i class="fas fa-arrow-left mr-2"></i>返回列表
                    </a>
                </div>
            </div>

            <c:if test="${empty record}">
            <div class="card p-12 text-center">
                <i class="fas fa-exclamation-triangle text-5xl text-amber-400 mb-4"></i>
                <h3 class="text-xl font-bold text-gray-700 mb-2">记录不存在</h3>
                <p class="text-gray-500 mb-4">该调拨记录可能已被删除</p>
                <a href="${pageContext.request.contextPath}/transfer/list" class="btn btn-primary">返回列表</a>
            </div>
            </c:if>

            <c:if test="${not empty record}">
            <div class="max-w-5xl mx-auto px-4 space-y-6">

                <%-- 审批状态横幅 --%>
                <c:if test="${record.approvalStatus == 1}">
                <div class="p-4 rounded-lg flex items-center gap-3" style="background:#fef3c7;border:1px solid #fcd34d;">
                    <i class="fas fa-clock text-amber-500 text-xl"></i>
                    <div>
                        <p class="font-bold text-amber-800">审批中</p>
                        <p class="text-sm text-amber-600">此调拨申请正在等待审批，请确认后点击"审批通过"或"驳回"。</p>
                    </div>
                </div>
                </c:if>
                <c:if test="${record.approvalStatus == 2}">
                <div class="p-4 rounded-lg flex items-center gap-3" style="background:#d1fae5;border:1px solid #6ee7b7;">
                    <i class="fas fa-check-circle text-emerald-500 text-xl"></i>
                    <div>
                        <p class="font-bold text-emerald-800">已通过</p>
                        <p class="text-sm text-emerald-600">资产已成功调拨至目标部门。</p>
                    </div>
                </div>
                </c:if>
                <c:if test="${record.approvalStatus == 3}">
                <div class="p-4 rounded-lg flex items-center gap-3" style="background:#fee2e2;border:1px solid #fca5a5;">
                    <i class="fas fa-times-circle text-red-500 text-xl"></i>
                    <div>
                        <p class="font-bold text-red-800">已驳回</p>
                        <p class="text-sm text-red-600">此调拨申请已被驳回，资产保留在原部门。</p>
                    </div>
                </div>
                </c:if>

                <div class="grid grid-cols-1 lg:grid-cols-3 gap-6">
                    <%-- 调拨信息 --%>
                    <div class="card p-6 lg:col-span-2">
                        <h3 class="font-bold text-gray-800 text-lg mb-4">
                            <i class="fas fa-exchange-alt mr-2 text-blue-600"></i>调拨信息
                        </h3>
                        <div class="grid grid-cols-2 gap-4 text-sm">
                            <div class="flex justify-between py-2 border-b border-gray-100">
                                <span class="text-gray-500">资产编码</span>
                                <span class="font-mono font-medium text-blue-600">${record.assetCode}</span>
                            </div>
                            <div class="flex justify-between py-2 border-b border-gray-100">
                                <span class="text-gray-500">资产名称</span>
                                <span class="font-medium">${record.assetName}</span>
                            </div>
                            <div class="flex justify-between py-2 border-b border-gray-100">
                                <span class="text-gray-500">操作类型</span>
                                <span><span class="status-badge" style="background:#dbeafe;color:#1e40af">调拨</span></span>
                            </div>
                            <div class="flex justify-between py-2 border-b border-gray-100">
                                <span class="text-gray-500">调拨日期</span>
                                <span>${record.useDate}</span>
                            </div>
                            <div class="flex justify-between py-2 border-b border-gray-100">
                                <span class="text-gray-500">调出部门</span>
                                <span class="font-medium text-orange-600">${record.fromDeptName != null ? record.fromDeptName : '仓库（在库）'}</span>
                            </div>
                            <div class="flex justify-between py-2 border-b border-gray-100">
                                <span class="text-gray-500">调入部门</span>
                                <span class="font-medium text-emerald-600">${record.toDeptName != null ? record.toDeptName : '-'}</span>
                            </div>
                            <div class="flex justify-between py-2 border-b border-gray-100">
                                <span class="text-gray-500">审批状态</span>
                                <span>
                                    <c:choose>
                                        <c:when test="${record.approvalStatus == 0}"><span class="status-badge" style="background:#f3f4f6;color:#6b7280">无需审批</span></c:when>
                                        <c:when test="${record.approvalStatus == 1}"><span class="status-badge status-3">审批中</span></c:when>
                                        <c:when test="${record.approvalStatus == 2}"><span class="status-badge status-2">已通过</span></c:when>
                                        <c:when test="${record.approvalStatus == 3}"><span class="status-badge status-4">驳回</span></c:when>
                                    </c:choose>
                                </span>
                            </div>
                            <div class="flex justify-between py-2 border-b border-gray-100">
                                <span class="text-gray-500">操作人</span>
                                <span>${record.operatorName != null ? record.operatorName : '-'}</span>
                            </div>
                        </div>
                        <c:if test="${record.purpose != null && !record.purpose.isEmpty()}">
                        <div class="mt-4 pt-4 border-t">
                            <h4 class="text-sm font-medium text-gray-500 mb-2">调拨原因</h4>
                            <p class="text-sm text-gray-700 bg-gray-50 rounded-lg p-3">${record.purpose}</p>
                        </div>
                        </c:if>
                    </div>

                    <%-- 审批时间线 --%>
                    <div class="card p-6">
                        <h3 class="font-bold text-gray-800 text-lg mb-4">
                            <i class="fas fa-history mr-2 text-purple-600"></i>审批时间线
                        </h3>
                        <div class="space-y-4">
                            <%-- 提交申请 --%>
                            <div class="flex items-start gap-3">
                                <div class="w-8 h-8 rounded-full bg-blue-100 flex items-center justify-center flex-shrink-0">
                                    <i class="fas fa-paper-plane text-blue-600 text-xs"></i>
                                </div>
                                <div>
                                    <p class="text-sm font-medium">提交调拨申请</p>
                                    <p class="text-xs text-gray-400">${record.createTime}</p>
                                </div>
                            </div>

                            <%-- 审批中 --%>
                            <c:if test="${record.approvalStatus == 1}">
                            <div class="flex items-start gap-3">
                                <div class="w-8 h-8 rounded-full bg-amber-100 flex items-center justify-center flex-shrink-0">
                                    <i class="fas fa-clock text-amber-600 text-xs"></i>
                                </div>
                                <div>
                                    <p class="text-sm font-medium text-amber-700">等待审批</p>
                                    <p class="text-xs text-gray-400">资产状态：调拨中</p>
                                </div>
                            </div>
                            </c:if>

                            <%-- 已通过 --%>
                            <c:if test="${record.approvalStatus == 2}">
                            <div class="flex items-start gap-3">
                                <div class="w-8 h-8 rounded-full bg-emerald-100 flex items-center justify-center flex-shrink-0">
                                    <i class="fas fa-check text-emerald-600 text-xs"></i>
                                </div>
                                <div>
                                    <p class="text-sm font-medium text-emerald-700">审批通过</p>
                                    <p class="text-xs text-gray-400">资产已转入${record.toDeptName}</p>
                                </div>
                            </div>
                            </c:if>

                            <%-- 驳回 --%>
                            <c:if test="${record.approvalStatus == 3}">
                            <div class="flex items-start gap-3">
                                <div class="w-8 h-8 rounded-full bg-red-100 flex items-center justify-center flex-shrink-0">
                                    <i class="fas fa-times text-red-600 text-xs"></i>
                                </div>
                                <div>
                                    <p class="text-sm font-medium text-red-700">审批驳回</p>
                                    <p class="text-xs text-gray-400">资产保留在${record.fromDeptName}</p>
                                </div>
                            </div>
                            </c:if>
                        </div>

                        <%-- 审批操作区（仅审批中状态显示） --%>
                        <c:if test="${record.approvalStatus == 1}">
                        <div class="mt-6 pt-4 border-t space-y-3">
                            <p class="text-sm font-medium text-gray-700 mb-2">快捷操作</p>
                            <a href="${pageContext.request.contextPath}/transfer/approve?id=${record.id}&action=pass"
                               class="btn btn-success" style="display:block;text-align:center;width:100%"
                               onclick="return confirm('确定通过吗？资产将转移至 ${record.toDeptName}。')">
                                <i class="fas fa-check mr-2"></i>审批通过
                            </a>
                            <a href="${pageContext.request.contextPath}/transfer/approve?id=${record.id}&action=reject"
                               class="btn" style="display:block;text-align:center;width:100%;background:#dc2626;color:white"
                               onclick="return confirm('确定驳回吗？资产将保留在 ${record.fromDeptName}。')">
                                <i class="fas fa-times mr-2"></i>驳回申请
                            </a>
                        </div>
                        </c:if>
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
