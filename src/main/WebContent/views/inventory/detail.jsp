<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>盘点详情 - 企业轻量资产管理系统</title>
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
                    <h2 class="page-title">盘点详情</h2>
                    <p class="page-subtitle">${inventory.inventoryName}</p>
                </div>
                <div class="flex gap-3">
                    <c:if test="${inventory.status == 1 || inventory.status == 2}">
                        <a href="${pageContext.request.contextPath}/inventory/scan?id=${inventory.id}" class="btn btn-primary">
                            <i class="fas fa-play mr-2"></i>开始盘点
                        </a>
                    </c:if>
                    <a href="${pageContext.request.contextPath}/inventory/list" class="btn btn-secondary">
                        <i class="fas fa-arrow-left mr-2"></i>返回列表
                    </a>
                </div>
            </div>

            <c:if test="${inventory == null}">
                <div class="card p-12 text-center text-gray-400">
                    <i class="fas fa-exclamation-circle text-4xl mb-3"></i>
                    <p>未找到该盘点任务</p>
                </div>
            </c:if>

            <c:if test="${inventory != null}">
            <!-- 任务概览统计卡片 -->
            <div class="grid grid-cols-1 md:grid-cols-4 gap-4 mb-6">
                <div class="card p-4 border-l-4 border-blue-500">
                    <p class="text-gray-500 text-sm">盘点类型</p>
                    <p class="text-lg font-bold">
                        <c:choose>
                            <c:when test="${inventory.inventoryType == 1}">全面盘点</c:when>
                            <c:when test="${inventory.inventoryType == 2}">按部门</c:when>
                            <c:when test="${inventory.inventoryType == 3}">按分类</c:when>
                        </c:choose>
                    </p>
                </div>
                <div class="card p-4 border-l-4 border-amber-500">
                    <p class="text-gray-500 text-sm">状态</p>
                    <p class="text-lg font-bold">
                        <c:choose>
                            <c:when test="${inventory.status == 1}"><span class="status-badge status-1">待盘点</span></c:when>
                            <c:when test="${inventory.status == 2}"><span class="status-badge status-3">盘点中</span></c:when>
                            <c:when test="${inventory.status == 3}"><span class="status-badge status-2">已完成</span></c:when>
                        </c:choose>
                    </p>
                </div>
                <div class="card p-4 border-l-4 border-emerald-500">
                    <p class="text-gray-500 text-sm">盘点结果</p>
                    <p class="text-lg font-bold">
                        <c:choose>
                            <c:when test="${inventory.resultStatus == 0}"><span class="status-badge" style="background:#f3f4f6;color:#6b7280">未出结果</span></c:when>
                            <c:when test="${inventory.resultStatus == 1}"><span class="status-badge status-2">正常</span></c:when>
                            <c:when test="${inventory.resultStatus == 2}"><span class="status-badge status-4">存在异常</span></c:when>
                        </c:choose>
                    </p>
                </div>
                <div class="card p-4 border-l-4 border-violet-500">
                    <p class="text-gray-500 text-sm">盘点方式</p>
                    <p class="text-lg font-bold">
                        <c:choose>
                            <c:when test="${inventory.inventoryMethod == 1}">人工扫码</c:when>
                            <c:when test="${inventory.inventoryMethod == 2}">RFID批量</c:when>
                        </c:choose>
                    </p>
                </div>
            </div>

            <div class="grid grid-cols-1 lg:grid-cols-3 gap-6 mb-6">
                <!-- 左侧:任务基本信息 -->
                <div class="card p-6 lg:col-span-2">
                    <h3 class="font-bold text-gray-800 text-lg mb-4">任务信息</h3>
                    <div class="grid grid-cols-2 gap-4 text-sm">
                        <div class="flex justify-between py-2 border-b border-gray-100">
                            <span class="text-gray-500">盘点单号</span>
                            <span class="font-mono font-medium text-blue-600">${inventory.inventoryNo}</span>
                        </div>
                        <div class="flex justify-between py-2 border-b border-gray-100">
                            <span class="text-gray-500">任务名称</span>
                            <span class="font-medium">${inventory.inventoryName}</span>
                        </div>
                        <div class="flex justify-between py-2 border-b border-gray-100">
                            <span class="text-gray-500">盘点类型</span>
                            <span>
                                <c:choose>
                                    <c:when test="${inventory.inventoryType == 1}">全面盘点</c:when>
                                    <c:when test="${inventory.inventoryType == 2}">按部门</c:when>
                                    <c:when test="${inventory.inventoryType == 3}">按分类</c:when>
                                </c:choose>
                            </span>
                        </div>
                        <div class="flex justify-between py-2 border-b border-gray-100">
                            <span class="text-gray-500">盘点方式</span>
                            <span>
                                <c:choose>
                                    <c:when test="${inventory.inventoryMethod == 1}"><i class="fas fa-mobile-alt mr-1"></i>人工扫码</c:when>
                                    <c:when test="${inventory.inventoryMethod == 2}"><i class="fas fa-wifi mr-1"></i>RFID批量</c:when>
                                </c:choose>
                            </span>
                        </div>
                        <div class="flex justify-between py-2 border-b border-gray-100">
                            <span class="text-gray-500">负责人</span>
                            <span>${inventory.operatorName != null ? inventory.operatorName : '-'}</span>
                        </div>
                        <div class="flex justify-between py-2 border-b border-gray-100">
                            <span class="text-gray-500">计划日期</span>
                            <span>${inventory.planDate != null ? inventory.planDate : '-'}</span>
                        </div>
                        <div class="flex justify-between py-2 border-b border-gray-100">
                            <span class="text-gray-500">实际开始</span>
                            <span>${inventory.startDate != null ? inventory.startDate : '-'}</span>
                        </div>
                        <div class="flex justify-between py-2 border-b border-gray-100">
                            <span class="text-gray-500">实际结束</span>
                            <span>${inventory.endDate != null ? inventory.endDate : '-'}</span>
                        </div>
                        <c:if test="${inventory.scopeIds != null && inventory.scopeIds != ''}">
                        <div class="flex justify-between py-2 border-b border-gray-100">
                            <span class="text-gray-500">盘点范围ID</span>
                            <span class="font-mono text-xs">${inventory.scopeIds}</span>
                        </div>
                        </c:if>
                        <c:if test="${inventory.remark != null && inventory.remark != ''}">
                        <div class="flex justify-between py-2 border-b border-gray-100">
                            <span class="text-gray-500">备注</span>
                            <span class="text-gray-600">${inventory.remark}</span>
                        </div>
                        </c:if>
                    </div>
                </div>

                <!-- 右侧:时间信息 -->
                <div class="space-y-6">
                    <div class="card p-6">
                        <h3 class="font-bold text-gray-800 text-lg mb-4">时间信息</h3>
                        <div class="space-y-3 text-sm">
                            <div class="flex justify-between">
                                <span class="text-gray-500">计划日期</span>
                                <span>${inventory.planDate != null ? inventory.planDate : '-'}</span>
                            </div>
                            <div class="flex justify-between">
                                <span class="text-gray-500">开始日期</span>
                                <span>${inventory.startDate != null ? inventory.startDate : '未开始'}</span>
                            </div>
                            <div class="flex justify-between">
                                <span class="text-gray-500">结束日期</span>
                                <span>${inventory.endDate != null ? inventory.endDate : '未结束'}</span>
                            </div>
                            <div class="flex justify-between">
                                <span class="text-gray-500">创建时间</span>
                                <span>${inventory.createTime != null ? inventory.createTime : '-'}</span>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- 盘点明细 -->
            <div class="card overflow-hidden">
                <div class="p-6 pb-3">
                    <h3 class="font-bold text-gray-800 text-lg">盘点明细</h3>
                    <p class="text-sm text-gray-500 mt-1">共 ${details != null ? details.size() : 0} 条明细记录</p>
                </div>
                <table class="data-table">
                    <thead>
                        <tr>
                            <th>资产编码</th>
                            <th>资产名称</th>
                            <th class="text-center">账面状态</th>
                            <th class="text-center">实际状态</th>
                            <th>账面位置</th>
                            <th>实际位置</th>
                            <th class="text-center">RFID扫描</th>
                            <th>异常说明</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${details}" var="d">
                        <tr class="table-row">
                            <td class="font-mono text-blue-600">${d.assetCode != null ? d.assetCode : '-'}</td>
                            <td class="font-medium">${d.assetName != null ? d.assetName : '-'}</td>
                            <td class="text-center">
                                <c:choose>
                                    <c:when test="${d.bookStatus == 1}"><span class="status-badge status-1">在库</span></c:when>
                                    <c:when test="${d.bookStatus == 2}"><span class="status-badge status-2">部门在用</span></c:when>
                                    <c:when test="${d.bookStatus == 3}"><span class="status-badge status-3">维修中</span></c:when>
                                    <c:when test="${d.bookStatus == 4}"><span class="status-badge status-4">报废</span></c:when>
                                    <c:otherwise>-</c:otherwise>
                                </c:choose>
                            </td>
                            <td class="text-center">
                                <c:choose>
                                    <c:when test="${d.actualStatus == 1}"><span class="status-badge status-2">正常</span></c:when>
                                    <c:when test="${d.actualStatus == 2}"><span class="status-badge status-4">盘亏</span></c:when>
                                    <c:when test="${d.actualStatus == 3}"><span class="status-badge status-3">盘盈</span></c:when>
                                    <c:when test="${d.actualStatus == 4}"><span class="status-badge status-4">损坏</span></c:when>
                                    <c:when test="${d.actualStatus == 5}"><span class="status-badge status-5">位置变更</span></c:when>
                                    <c:otherwise>-</c:otherwise>
                                </c:choose>
                            </td>
                            <td class="text-gray-600 max-w-xs truncate">${d.bookLocation != null ? d.bookLocation : '-'}</td>
                            <td class="text-gray-600 max-w-xs truncate">${d.actualLocation != null ? d.actualLocation : '-'}</td>
                            <td class="text-center">
                                <c:choose>
                                    <c:when test="${d.rfidScanned == 1}"><span class="status-badge status-2"><i class="fas fa-check mr-1"></i>已扫描</span></c:when>
                                    <c:otherwise><span class="status-badge" style="background:#f3f4f6;color:#6b7280">未扫描</span></c:otherwise>
                                </c:choose>
                            </td>
                            <td class="text-gray-600 max-w-xs truncate">${d.remark != null ? d.remark : '-'}</td>
                        </tr>
                        </c:forEach>
                        <c:if test="${empty details}">
                        <tr>
                            <td colspan="8" class="text-center py-12 text-gray-400">
                                <i class="fas fa-inbox text-4xl mb-3"></i>
                                <p>暂无盘点明细，点击「开始盘点」生成明细数据</p>
                            </td>
                        </tr>
                        </c:if>
                    </tbody>
                </table>
            </div>
            </c:if>
        </main>
        <%@ include file="/views/common/footer.jsp" %>
    </div>
</div>
</body>
</html>
