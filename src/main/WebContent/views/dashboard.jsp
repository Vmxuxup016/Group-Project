<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>数据仪表盘 - 企业轻量资产管理系统</title>
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
            <!-- 统计卡片 -->
            <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6 mb-6">
                <div class="card stat-card bg-blue-600">
                    <div class="flex justify-between items-start">
                        <div>
                            <p class="stat-label">资产总数</p>
                            <h3 class="stat-value">${totalAsset != null ? totalAsset : '1,286'}</h3>
                            <p class="text-sm mt-2 opacity-80"><i class="fas fa-arrow-up mr-1"></i>较上月 +23</p>
                        </div>
                        <div class="stat-icon"><i class="fas fa-box"></i></div>
                    </div>
                </div>
                <div class="card stat-card bg-emerald-600">
                    <div class="flex justify-between items-start">
                        <div>
                            <p class="stat-label">在用资产</p>
                            <h3 class="stat-value">${inUseAsset != null ? inUseAsset : '892'}</h3>
                            <p class="text-sm mt-2 opacity-80">占比 69.4%</p>
                        </div>
                        <div class="stat-icon"><i class="fas fa-check-circle"></i></div>
                    </div>
                </div>
                <div class="card stat-card bg-amber-500">
                    <div class="flex justify-between items-start">
                        <div>
                            <p class="stat-label">维修中</p>
                            <h3 class="stat-value">${repairingAsset != null ? repairingAsset : '18'}</h3>
                            <p class="text-sm mt-2 opacity-80"><i class="fas fa-arrow-down mr-1"></i>较上周 -5</p>
                        </div>
                        <div class="stat-icon"><i class="fas fa-tools"></i></div>
                    </div>
                </div>
                <div class="card stat-card bg-rose-500">
                    <div class="flex justify-between items-start">
                        <div>
                            <p class="stat-label">本月报废</p>
                            <h3 class="stat-value">${scrapAsset != null ? scrapAsset : '6'}</h3>
                            <p class="text-sm mt-2 opacity-80">待审批 2</p>
                        </div>
                        <div class="stat-icon"><i class="fas fa-trash-alt"></i></div>
                    </div>
                </div>
            </div>

            <div class="grid grid-cols-1 lg:grid-cols-3 gap-6">
                <div class="card p-6 lg:col-span-2">
                    <div class="flex justify-between items-center mb-4">
                        <h3 class="font-bold text-gray-800 text-lg">资产状态分布</h3>
                        <select class="text-sm border rounded-lg px-3 py-1 outline-none" onchange="location.href='${pageContext.request.contextPath}/dashboard?period='+this.value">
                            <option value="month" ${period == 'month' ? 'selected' : ''}>本月</option>
                            <option value="quarter" ${period == 'quarter' ? 'selected' : ''}>本季度</option>
                            <option value="year" ${period == 'year' ? 'selected' : ''}>本年度</option>
                        </select>
                    </div>
                    <div class="space-y-4">
                        <div>
                            <div class="flex justify-between text-sm mb-1">
                                <span class="text-gray-600">在库</span>
                                <span class="font-semibold">${stockCount != null ? stockCount : '320'} (${stockPercent != null ? stockPercent : '24.9'}%)</span>
                            </div>
                            <div class="progress-bar"><div class="progress-fill bg-blue-500" style="width: ${stockPercent != null ? stockPercent : 24.9}%"></div></div>
                        </div>
                        <div>
                            <div class="flex justify-between text-sm mb-1">
                                <span class="text-gray-600">部门在用</span>
                                <span class="font-semibold">${inUseCount != null ? inUseCount : '892'} (${inUsePercent != null ? inUsePercent : '69.4'}%)</span>
                            </div>
                            <div class="progress-bar"><div class="progress-fill bg-emerald-500" style="width: ${inUsePercent != null ? inUsePercent : 69.4}%"></div></div>
                        </div>
                        <div>
                            <div class="flex justify-between text-sm mb-1">
                                <span class="text-gray-600">维修中</span>
                                <span class="font-semibold">${repairCount != null ? repairCount : '18'} (${repairPercent != null ? repairPercent : '1.4'}%)</span>
                            </div>
                            <div class="progress-bar"><div class="progress-fill bg-amber-500" style="width: ${repairPercent != null ? repairPercent : 1.4}%"></div></div>
                        </div>
                        <div>
                            <div class="flex justify-between text-sm mb-1">
                                <span class="text-gray-600">报废</span>
                                <span class="font-semibold">${scrapCount != null ? scrapCount : '56'} (${scrapPercent != null ? scrapPercent : '4.3'}%)</span>
                            </div>
                            <div class="progress-bar"><div class="progress-fill bg-rose-500" style="width: ${scrapPercent != null ? scrapPercent : 4.3}%"></div></div>
                        </div>
                    </div>
                </div>

                <div class="card p-6">
                    <h3 class="font-bold text-gray-800 text-lg mb-4">最近动态</h3>
                    <div class="space-y-4">
                        <c:forEach items="${recentLogs}" var="log">
                        <div class="flex gap-3">
                            <div class="w-8 h-8 ${log.iconBg} rounded-full flex items-center justify-center flex-shrink-0">
                                <i class="fas ${log.icon} ${log.iconColor} text-xs"></i>
                            </div>
                            <div>
                                <p class="text-sm text-gray-800">${log.action} <span class="font-semibold">${log.target}</span></p>
                                <p class="text-xs text-gray-400">${log.timeAgo} | ${log.deptName}</p>
                            </div>
                        </div>
                        </c:forEach>
                        <c:if test="${empty recentLogs}">
                        <div class="flex gap-3">
                            <div class="w-8 h-8 bg-blue-100 rounded-full flex items-center justify-center flex-shrink-0">
                                <i class="fas fa-plus text-blue-600 text-xs"></i>
                            </div>
                            <div>
                                <p class="text-sm text-gray-800">新增资产 <span class="font-semibold">ThinkPad X1</span></p>
                                <p class="text-xs text-gray-400">10分钟前 | 技术部</p>
                            </div>
                        </div>
                        <div class="flex gap-3">
                            <div class="w-8 h-8 bg-amber-100 rounded-full flex items-center justify-center flex-shrink-0">
                                <i class="fas fa-tools text-amber-600 text-xs"></i>
                            </div>
                            <div>
                                <p class="text-sm text-gray-800">维修完成 <span class="font-semibold">HP打印机#1023</span></p>
                                <p class="text-xs text-gray-400">1小时前 | 行政部</p>
                            </div>
                        </div>
                        <div class="flex gap-3">
                            <div class="w-8 h-8 bg-emerald-100 rounded-full flex items-center justify-center flex-shrink-0">
                                <i class="fas fa-hand-holding text-emerald-600 text-xs"></i>
                            </div>
                            <div>
                                <p class="text-sm text-gray-800">领用申请 <span class="font-semibold">显示器×3</span></p>
                                <p class="text-xs text-gray-400">2小时前 | 财务部</p>
                            </div>
                        </div>
                        <div class="flex gap-3">
                            <div class="w-8 h-8 bg-rose-100 rounded-full flex items-center justify-center flex-shrink-0">
                                <i class="fas fa-trash-alt text-rose-600 text-xs"></i>
                            </div>
                            <div>
                                <p class="text-sm text-gray-800">报废审批 <span class="font-semibold">台式机#0891</span></p>
                                <p class="text-xs text-gray-400">3小时前 | IT运维部</p>
                            </div>
                        </div>
                        </c:if>
                    </div>
                </div>
            </div>

            <div class="card p-6 mt-6">
                <h3 class="font-bold text-gray-800 text-lg mb-4">资产分类统计</h3>
                <div class="overflow-x-auto">
                    <table class="data-table">
                        <thead>
                            <tr>
                                <th>分类名称</th>
                                <th class="text-center">数量</th>
                                <th class="text-center">原值合计</th>
                                <th class="text-center">净值合计</th>
                                <th class="text-center">占比</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${categoryStats}" var="stat">
                            <tr class="table-row">
                                <td class="font-medium text-gray-800">${stat.categoryName}</td>
                                <td class="text-center">${stat.count}</td>
                                <td class="text-center"><fmt:formatNumber value="${stat.originalValue}" type="currency" currencySymbol="¥"/></td>
                                <td class="text-center"><fmt:formatNumber value="${stat.netValue}" type="currency" currencySymbol="¥"/></td>
                                <td class="text-center">
                                    <div class="flex items-center justify-center gap-2">
                                        <div class="w-16 progress-bar"><div class="progress-fill bg-blue-500" style="width: ${stat.percent}%"></div></div>
                                        <span class="text-xs">${stat.percent}%</span>
                                    </div>
                                </td>
                            </tr>
                            </c:forEach>
                            <c:if test="${empty categoryStats}">
                            <tr class="table-row">
                                <td class="font-medium text-gray-800">电子设备</td>
                                <td class="text-center">856</td>
                                <td class="text-center">¥2,450,000</td>
                                <td class="text-center">¥1,680,000</td>
                                <td class="text-center">
                                    <div class="flex items-center justify-center gap-2">
                                        <div class="w-16 progress-bar"><div class="progress-fill bg-blue-500" style="width: 66.6%"></div></div>
                                        <span class="text-xs">66.6%</span>
                                    </div>
                                </td>
                            </tr>
                            <tr class="table-row">
                                <td class="font-medium text-gray-800">办公家具</td>
                                <td class="text-center">430</td>
                                <td class="text-center">¥860,000</td>
                                <td class="text-center">¥520,000</td>
                                <td class="text-center">
                                    <div class="flex items-center justify-center gap-2">
                                        <div class="w-16 progress-bar"><div class="progress-fill bg-emerald-500" style="width: 33.4%"></div></div>
                                        <span class="text-xs">33.4%</span>
                                    </div>
                                </td>
                            </tr>
                            </c:if>
                        </tbody>
                    </table>
                </div>
            </div>
        </main>
<%@ include file="/views/common/footer.jsp" %>