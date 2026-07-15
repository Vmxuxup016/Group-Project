<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>RFID管理 - 企业轻量资产管理系统</title>
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
                    <h2 class="page-title">RFID管理</h2>
                    <p class="page-subtitle">物联网概念：标签绑定、扫描追踪</p>
                </div>
                <div class="flex gap-3">
                    <a href="${pageContext.request.contextPath}/rfid/add" class="btn btn-primary">
                        <i class="fas fa-plus mr-2"></i>注册标签
                    </a>
                    <a href="${pageContext.request.contextPath}/rfid/batchScan" class="btn" style="background:#7c3aed;color:white"
                       onclick="return confirm('确定对所有正常标签执行批量扫描吗？')">
                        <i class="fas fa-wifi mr-2"></i>批量扫描
                    </a>
                </div>
            </div>

            <div class="card p-6 mb-6" style="background: linear-gradient(to right, #f5f3ff, #eff6ff); border: 1px solid #ddd6fe;">
                <div class="flex items-start gap-4">
                    <div class="w-12 h-12 bg-purple-100 rounded-xl flex items-center justify-center flex-shrink-0">
                        <i class="fas fa-wifi text-purple-600 text-xl"></i>
                    </div>
                    <div>
                        <h3 class="font-bold text-gray-800 text-lg mb-1">RFID 物联网技术介绍</h3>
                        <p class="text-gray-600 text-sm leading-relaxed">
                            RFID（Radio Frequency Identification）无线射频识别技术，通过无线电波自动识别目标对象并获取相关数据。
                            在资产管理中，每个资产绑定唯一的RFID标签（EPC编码），配合手持扫描设备或固定式读写器，可实现：
                            <span style="font-weight:600;color:#7c3aed">批量快速盘点（每秒识别数百个标签）</span>、
                            <span style="font-weight:600;color:#7c3aed">无接触式出入库登记</span>、
                            <span style="font-weight:600;color:#7c3aed">实时位置追踪</span>。
                            相比传统条码，RFID无需可视、可穿透读取、存储容量大，大幅提升资产管理效率。
                        </p>
                    </div>
                </div>
            </div>

            <div class="card overflow-hidden">
                <table class="data-table">
                    <thead>
                        <tr>
                            <th>标签编码(EPC)</th>
                            <th>绑定资产</th>
                            <th class="text-center">状态</th>
                            <th class="text-center">绑定时间</th>
                            <th class="text-center">最后扫描</th>
                            <th class="text-center">扫描次数</th>
                            <th class="text-center">操作</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${rfidList}" var="tag">
                        <tr class="table-row">
                            <td class="font-mono text-purple-600 font-medium">${tag.tagCode}</td>
                            <td class="font-medium">${tag.assetName != null ? tag.assetName : '<span style="color:#9ca3af">未绑定</span>'}</td>
                            <td class="text-center">
                                <c:choose>
                                    <c:when test="${tag.tagStatus == 1}"><span class="status-badge status-2">正常</span></c:when>
                                    <c:when test="${tag.tagStatus == 2}"><span class="status-badge status-4">损坏</span></c:when>
                                    <c:when test="${tag.tagStatus == 3}"><span class="status-badge" style="background:#f3f4f6;color:#6b7280">未绑定</span></c:when>
                                </c:choose>
                            </td>
                            <td class="text-center">${tag.bindTime != null ? tag.bindTime : '-'}</td>
                            <td class="text-center">${tag.lastScanTime != null ? tag.lastScanTime : '-'}</td>
                            <td class="text-center font-medium">${tag.scanCount}</td>
                            <td class="text-center">
                                <c:if test="${tag.tagStatus == 3}">
                                <a href="${pageContext.request.contextPath}/rfid/detail?id=${tag.id}" class="text-emerald-600 hover:text-emerald-800 mr-2" title="绑定资产">
                                    <i class="fas fa-link"></i>
                                </a>
                                </c:if>
                                <c:if test="${tag.tagStatus == 1}">
                                <a href="${pageContext.request.contextPath}/rfid/unbind?id=${tag.id}" class="text-rose-600 hover:text-rose-800 mr-2" title="解绑" onclick="return confirm('确定解绑该资产吗？')">
                                    <i class="fas fa-unlink"></i>
                                </a>
                                </c:if>
                                <a href="${pageContext.request.contextPath}/rfid/detail?id=${tag.id}" class="text-blue-600 hover:text-blue-800 mr-2" title="详情">
                                    <i class="fas fa-eye"></i>
                                </a>
                                <a href="${pageContext.request.contextPath}/rfid/delete?id=${tag.id}" class="text-red-500 hover:text-red-700" title="删除" onclick="return confirm('确定删除该标签吗？')">
                                    <i class="fas fa-trash-alt"></i>
                                </a>
                            </td>
                        </tr>
                        </c:forEach>
                        <c:if test="${empty rfidList}">
                        <tr>
                            <td colspan="7" class="text-center py-12 text-gray-400">
                                <i class="fas fa-inbox text-4xl mb-3"></i>
                                <p>暂无RFID标签</p>
                            </td>
                        </tr>
                        </c:if>
                    </tbody>
                </table>
            </div>
        </main>
<%@ include file="/views/common/footer.jsp" %>