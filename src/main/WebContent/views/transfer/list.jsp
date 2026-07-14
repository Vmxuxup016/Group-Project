<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>调拨审批 - 企业轻量资产管理系统</title>
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
                    <h2 class="page-title">调拨审批</h2>
                    <p class="page-subtitle">跨部门资产调拨申请与审批流</p>
                </div>
                <a href="${pageContext.request.contextPath}/transfer/add" class="btn btn-primary">
                    <i class="fas fa-plus mr-2"></i>发起调拨
                </a>
            </div>

            <div class="card p-6 mb-6" style="background: linear-gradient(to right, #eff6ff, #ecfeff); border: 1px solid #bfdbfe;">
                <div class="flex items-start gap-4">
                    <div class="w-12 h-12 bg-blue-100 rounded-xl flex items-center justify-center flex-shrink-0">
                        <i class="fas fa-code-branch text-blue-600 text-xl"></i>
                    </div>
                    <div>
                        <h3 class="font-bold text-gray-800 text-lg mb-1">技术对比：审批流实现方案</h3>
                        <p class="text-gray-600 text-sm leading-relaxed">
                            资产调拨审批流可采用多种技术方案实现：
                            <span style="font-weight:600;color:#2563eb">1. 状态机模式</span>（基于状态字段流转，简单轻量）、
                            <span style="font-weight:600;color:#2563eb">2. 工作流引擎</span>（如Activiti/Flowable，支持可视化流程设计）、
                            <span style="font-weight:600;color:#2563eb">3. 规则引擎</span>（Drools等，适合复杂审批规则）。
                            本系统采用状态机+简易审批链设计，满足轻量需求的同时预留扩展接口。
                        </p>
                    </div>
                </div>
            </div>

            <div class="card overflow-hidden">
                <table class="data-table">
                    <thead>
                        <tr>
                            <th>资产编码</th>
                            <th>资产名称</th>
                            <th>调出部门</th>
                            <th>调入部门</th>
                            <th>调拨原因</th>
                            <th class="text-center">审批状态</th>
                            <th class="text-center">操作</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${transferList}" var="t">
                        <tr class="table-row">
                            <td class="font-mono text-blue-600">${t.assetCode}</td>
                            <td class="font-medium">${t.assetName}</td>
                            <td>${t.fromDeptName}</td>
                            <td>${t.toDeptName}</td>
                            <td class="text-gray-600 max-w-xs truncate">${t.purpose != null ? t.purpose : '-'}</td>
                            <td class="text-center">
                                <c:choose>
                                    <c:when test="${t.approvalStatus == 0}"><span class="status-badge" style="background:#f3f4f6;color:#6b7280">无需审批</span></c:when>
                                    <c:when test="${t.approvalStatus == 1}"><span class="status-badge status-3">审批中</span></c:when>
                                    <c:when test="${t.approvalStatus == 2}"><span class="status-badge status-2">已通过</span></c:when>
                                    <c:when test="${t.approvalStatus == 3}"><span class="status-badge status-4">驳回</span></c:when>
                                </c:choose>
                            </td>
                            <td class="text-center">
                                <c:if test="${t.approvalStatus == 1}">
                                <a href="${pageContext.request.contextPath}/transfer/approve?id=${t.id}&action=pass" class="text-emerald-600 hover:text-emerald-800 mr-2" title="通过"><i class="fas fa-check"></i></a>
                                <a href="${pageContext.request.contextPath}/transfer/approve?id=${t.id}&action=reject" class="text-rose-600 hover:text-rose-800 mr-2" title="驳回"><i class="fas fa-times"></i></a>
                                </c:if>
                                <a href="${pageContext.request.contextPath}/transfer/detail?id=${t.id}" class="text-blue-600 hover:text-blue-800"><i class="fas fa-eye"></i></a>
                            </td>
                        </tr>
                        </c:forEach>
                        <c:if test="${empty transferList}">
                        <tr>
                            <td colspan="7" class="text-center py-12 text-gray-400">
                                <i class="fas fa-inbox text-4xl mb-3"></i>
                                <p>暂无调拨记录</p>
                            </td>
                        </tr>
                        </c:if>
                    </tbody>
                </table>
            </div>
        </main>
<%@ include file="/views/common/footer.jsp" %>