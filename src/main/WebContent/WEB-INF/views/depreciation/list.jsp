<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>折旧计算 - 企业轻量资产管理系统</title>
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
                    <h2 class="page-title">折旧计算</h2>
                    <p class="page-subtitle">按月计提折旧，支撑财务对账</p>
                </div>
                <form action="${pageContext.request.contextPath}/depreciation/calculate" method="post" style="display:inline">
                    <button type="submit" class="btn btn-primary" onclick="return confirm('确定计提本月折旧吗？')">
                        <i class="fas fa-calculator mr-2"></i>计提本月折旧
                    </button>
                </form>
            </div>

            <div class="grid grid-cols-1 md:grid-cols-3 gap-4 mb-6">
                <div class="card p-6 bg-gradient-to-br from-blue-500 to-blue-600 text-white">
                    <p class="text-blue-100 text-sm mb-1">资产原值总计</p>
                    <h3 class="text-3xl font-bold">¥${totalOriginal != null ? totalOriginal : '3,310,000'}</h3>
                </div>
                <div class="card p-6 bg-gradient-to-br from-emerald-500 to-emerald-600 text-white">
                    <p class="text-emerald-100 text-sm mb-1">累计折旧</p>
                    <h3 class="text-3xl font-bold">¥${totalAccumulated != null ? totalAccumulated : '1,110,000'}</h3>
                </div>
                <div class="card p-6 bg-gradient-to-br from-amber-500 to-amber-600 text-white">
                    <p class="text-amber-100 text-sm mb-1">资产净值</p>
                    <h3 class="text-3xl font-bold">¥${totalNet != null ? totalNet : '2,200,000'}</h3>
                </div>
            </div>

            <div class="card overflow-hidden">
                <div class="p-4 border-b border-gray-200 flex justify-between items-center">
                    <h3 class="font-bold text-gray-800">折旧明细记录</h3>
                    <form action="${pageContext.request.contextPath}/depreciation/list" method="get" style="display:inline">
                        <select name="month" class="form-select" style="width:auto" onchange="this.form.submit()">
                            <option value="2024-06" ${param.month == '2024-06' ? 'selected' : ''}>2024年6月</option>
                            <option value="2024-05" ${param.month == '2024-05' ? 'selected' : ''}>2024年5月</option>
                            <option value="2024-04" ${param.month == '2024-04' ? 'selected' : ''}>2024年4月</option>
                        </select>
                    </form>
                </div>
                <table class="data-table">
                    <thead>
                        <tr>
                            <th>资产编码</th>
                            <th>资产名称</th>
                            <th class="text-right">原值</th>
                            <th class="text-right">本月折旧</th>
                            <th class="text-right">累计折旧</th>
                            <th class="text-right">净值</th>
                            <th class="text-center">剩余月数</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${depreciationList}" var="d">
                        <tr class="table-row">
                            <td class="font-mono text-blue-600">${d.assetCode}</td>
                            <td class="font-medium">${d.assetName}</td>
                            <td class="text-right"><fmt:formatNumber value="${d.originalValue}" type="currency" currencySymbol="¥"/></td>
                            <td class="text-right font-medium text-amber-600"><fmt:formatNumber value="${d.depreciationAmount}" type="currency" currencySymbol="¥"/></td>
                            <td class="text-right"><fmt:formatNumber value="${d.accumulatedDepreciation}" type="currency" currencySymbol="¥"/></td>
                            <td class="text-right font-medium"><fmt:formatNumber value="${d.netValue}" type="currency" currencySymbol="¥"/></td>
                            <td class="text-center">${d.remainingMonths}</td>
                        </tr>
                        </c:forEach>
                        <c:if test="${empty depreciationList}">
                        <tr>
                            <td colspan="7" class="text-center py-12 text-gray-400">
                                <i class="fas fa-inbox text-4xl mb-3"></i>
                                <p>暂无折旧记录</p>
                            </td>
                        </tr>
                        </c:if>
                    </tbody>
                </table>
            </div>
        </main>
<%@ include file="/WEB-INF/views/common/footer.jsp" %>