<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>RFID标签详情 - 企业轻量资产管理系统</title>
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
                    <h2 class="page-title">RFID标签详情</h2>
                    <p class="page-subtitle">查看标签信息、绑定资产、扫描追踪</p>
                </div>
                <div class="flex gap-3">
                    <a href="${pageContext.request.contextPath}/rfid/list" class="btn btn-secondary">
                        <i class="fas fa-arrow-left mr-2"></i>返回列表
                    </a>
                    <a href="${pageContext.request.contextPath}/rfid/delete?id=${tag.id}"
                       class="btn" style="background:#dc2626;color:white"
                       onclick="return confirm('确定删除此标签吗？如已绑定资产将自动解绑。')">
                        <i class="fas fa-trash mr-2"></i>删除标签
                    </a>
                </div>
            </div>

            <c:if test="${empty tag}">
            <div class="card p-12 text-center">
                <i class="fas fa-exclamation-triangle text-5xl text-amber-400 mb-4"></i>
                <h3 class="text-xl font-bold text-gray-700 mb-2">标签不存在</h3>
                <p class="text-gray-500 mb-4">该标签可能已被删除</p>
                <a href="${pageContext.request.contextPath}/rfid/list" class="btn btn-primary">返回列表</a>
            </div>
            </c:if>

            <c:if test="${not empty tag}">
            <div class="max-w-5xl mx-auto px-4 space-y-6">

                <%-- 标签基本信息卡片 --%>
                <div class="card overflow-hidden">
                    <div class="p-5 border-b border-gray-100" style="background: linear-gradient(to right, #faf5ff, #eff6ff);">
                        <div class="flex items-center gap-3">
                            <div class="w-12 h-12 rounded-xl flex items-center justify-center"
                                 style="background: ${tag.tagStatus == 1 ? '#dcfce7' : (tag.tagStatus == 2 ? '#fee2e2' : '#f3f4f6')}">
                                <i class="fas fa-wifi text-xl"
                                   style="color: ${tag.tagStatus == 1 ? '#16a34a' : (tag.tagStatus == 2 ? '#dc2626' : '#9ca3af')}"></i>
                            </div>
                            <div>
                                <div class="flex items-center gap-2">
                                    <h3 class="text-lg font-bold text-gray-800 font-mono">${tag.tagCode}</h3>
                                    <c:choose>
                                        <c:when test="${tag.tagStatus == 1}"><span class="status-badge status-2">正常</span></c:when>
                                        <c:when test="${tag.tagStatus == 2}"><span class="status-badge status-4">损坏</span></c:when>
                                        <c:when test="${tag.tagStatus == 3}"><span class="status-badge" style="background:#f3f4f6;color:#6b7280">未绑定</span></c:when>
                                    </c:choose>
                                </div>
                                <p class="text-sm text-gray-500">创建时间：${tag.createTime}</p>
                            </div>
                        </div>
                    </div>
                    <div class="p-6">
                        <div class="grid grid-cols-2 md:grid-cols-4 gap-6">
                            <div>
                                <p class="text-xs text-gray-400 mb-1">标签编码 (EPC)</p>
                                <p class="font-mono font-medium">${tag.tagCode}</p>
                            </div>
                            <div>
                                <p class="text-xs text-gray-400 mb-1">标签状态</p>
                                <p class="font-medium">
                                    ${tag.tagStatus == 1 ? '正常' : (tag.tagStatus == 2 ? '损坏' : '未绑定')}
                                </p>
                            </div>
                            <div>
                                <p class="text-xs text-gray-400 mb-1">绑定时间</p>
                                <p class="font-medium">${tag.bindTime != null ? tag.bindTime : '-'}</p>
                            </div>
                            <div>
                                <p class="text-xs text-gray-400 mb-1">累计扫描次数</p>
                                <p class="font-medium text-lg" style="color:#7c3aed;">${tag.scanCount != null ? tag.scanCount : 0}</p>
                            </div>
                            <div>
                                <p class="text-xs text-gray-400 mb-1">最后扫描时间</p>
                                <p class="font-medium">${tag.lastScanTime != null ? tag.lastScanTime : '-'}</p>
                            </div>
                            <div>
                                <p class="text-xs text-gray-400 mb-1">最后扫描位置</p>
                                <p class="font-medium">${tag.lastScanLocation != null ? tag.lastScanLocation : '-'}</p>
                            </div>
                            <div>
                                <p class="text-xs text-gray-400 mb-1">更新時間</p>
                                <p class="font-medium">${tag.updateTime != null ? tag.updateTime : '-'}</p>
                            </div>
                        </div>
                    </div>
                </div>

                <%-- 绑定资产管理 --%>
                <div class="card p-6">
                    <h3 class="text-lg font-semibold mb-4">
                        <i class="fas fa-link mr-2" style="color:#7c3aed;"></i>
                        <c:choose>
                            <c:when test="${tag.tagStatus == 1 && tag.assetId != null}">已绑定资产</c:when>
                            <c:otherwise>绑定资产</c:otherwise>
                        </c:choose>
                    </h3>

                    <%-- 已绑定状态 --%>
                    <c:if test="${tag.tagStatus == 1 && tag.assetId != null}">
                    <div class="flex items-center gap-4 p-4 rounded-lg" style="background:#f0fdf4;border:1px solid #bbf7d0;">
                        <div class="w-14 h-14 bg-emerald-100 rounded-xl flex items-center justify-center flex-shrink-0">
                            <i class="fas fa-box text-emerald-600 text-xl"></i>
                        </div>
                        <div class="flex-1">
                            <p class="text-sm text-emerald-600 font-medium mb-1">当前绑定</p>
                            <p class="font-bold text-lg">
                                <span class="font-mono text-emerald-700">${tag.assetCode}</span>
                                <span class="mx-2 text-gray-300">|</span>
                                <span>${tag.assetName}</span>
                            </p>
                        </div>
                        <div class="flex gap-2">
                            <a href="${pageContext.request.contextPath}/rfid/unbind?id=${tag.id}"
                               class="btn btn-secondary text-sm"
                               onclick="return confirm('确定解绑该资产吗？')">
                                <i class="fas fa-unlink mr-1"></i>解绑
                            </a>
                            <a href="${pageContext.request.contextPath}/asset/detail?id=${tag.assetId}"
                               class="btn btn-primary text-sm">
                                <i class="fas fa-eye mr-1"></i>查看资产
                            </a>
                        </div>
                    </div>
                    </c:if>

                    <%-- 未绑定状态：显示绑定表单 --%>
                    <c:if test="${tag.tagStatus != 1 || tag.assetId == null}">
                    <c:if test="${tag.tagStatus != 2}">
                    <form action="${pageContext.request.contextPath}/rfid/bind" method="get" class="space-y-4">
                        <input type="hidden" name="id" value="${tag.id}">
                        <div class="form-group">
                            <label class="form-label">选择要绑定的资产 <span class="required">*</span></label>
                            <select name="assetId" class="form-select" required>
                                <option value="">-- 请选择资产 --</option>
                                <c:forEach items="${assetList}" var="a">
                                    <c:if test="${a.status != 4 && (a.rfidTag == null || a.rfidTag == '')}">
                                    <option value="${a.id}">
                                        ${a.assetCode} - ${a.assetName}
                                        <c:if test="${a.deptName != null}">[${a.deptName}]</c:if>
                                        <c:if test="${a.status == 1}">(在库)</c:if>
                                        <c:if test="${a.status == 2}">(在用)</c:if>
                                        <c:if test="${a.status == 3}">(维修中)</c:if>
                                    </option>
                                    </c:if>
                                </c:forEach>
                            </select>
                            <p class="text-gray-400 text-xs mt-1">仅显示未报废且未绑定RFID的资产</p>
                        </div>
                        <button type="submit" class="btn btn-primary">
                            <i class="fas fa-link mr-2"></i>确认绑定
                        </button>
                    </form>
                    </c:if>
                    <c:if test="${tag.tagStatus == 2}">
                    <div class="p-4 rounded-lg" style="background:#fef2f2;border:1px solid #fecaca;">
                        <p class="text-red-600"><i class="fas fa-exclamation-triangle mr-2"></i>标签已标记为"损坏"，无法绑定资产。请先将标签状态恢复为正常。</p>
                    </div>
                    </c:if>
                    </c:if>
                </div>

                <%-- 扫描模拟 & 状态管理 --%>
                <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                    <%-- 模拟扫描 --%>
                    <div class="card p-6">
                        <h3 class="text-lg font-semibold mb-4">
                            <i class="fas fa-broadcast-tower mr-2" style="color:#7c3aed;"></i>模拟扫描
                        </h3>
                        <p class="text-sm text-gray-500 mb-4">模拟RFID读写器扫描此标签，记录扫描时间和位置，累计扫描次数。</p>
                        <form action="${pageContext.request.contextPath}/rfid/scan" method="post">
                            <input type="hidden" name="id" value="${tag.id}">
                            <div class="form-group mb-3">
                                <label class="form-label">扫描位置</label>
                                <select name="location" class="form-select">
                                    <option value="仓库A区">仓库A区</option>
                                    <option value="仓库B区">仓库B区</option>
                                    <option value="1楼大厅">1楼大厅</option>
                                    <option value="2楼办公区">2楼办公区</option>
                                    <option value="3楼技术部">3楼技术部</option>
                                    <option value="机房">机房</option>
                                    <option value="会议室">会议室</option>
                                </select>
                            </div>
                            <button type="submit" class="btn" style="background:#7c3aed;color:white;width:100%">
                                <i class="fas fa-wifi mr-2"></i>模拟扫描
                            </button>
                        </form>
                    </div>

                    <%-- 状态管理 --%>
                    <div class="card p-6">
                        <h3 class="text-lg font-semibold mb-4">
                            <i class="fas fa-toggle-on mr-2" style="color:#f59e0b;"></i>状态管理
                        </h3>
                        <form action="${pageContext.request.contextPath}/rfid/updateStatus" method="post" class="space-y-4">
                            <input type="hidden" name="id" value="${tag.id}">
                            <div class="form-group">
                                <label class="form-label">当前状态</label>
                                <p class="text-sm font-medium mb-3">
                                    <c:choose>
                                        <c:when test="${tag.tagStatus == 1}"><span class="text-emerald-600"><i class="fas fa-check-circle mr-1"></i>正常</span></c:when>
                                        <c:when test="${tag.tagStatus == 2}"><span class="text-red-600"><i class="fas fa-times-circle mr-1"></i>损坏</span></c:when>
                                        <c:when test="${tag.tagStatus == 3}"><span class="text-gray-500"><i class="fas fa-circle mr-1"></i>未绑定</span></c:when>
                                    </c:choose>
                                </p>
                                <label class="form-label">更改状态</label>
                                <select name="status" class="form-select">
                                    <option value="1" ${tag.tagStatus == 1 ? 'selected' : ''}>正常</option>
                                    <option value="2" ${tag.tagStatus == 2 ? 'selected' : ''}>损坏</option>
                                    <option value="3" ${tag.tagStatus == 3 ? 'selected' : ''}>未绑定</option>
                                </select>
                            </div>
                            <button type="submit" class="btn btn-secondary" style="width:100%">
                                <i class="fas fa-save mr-2"></i>更新状态
                            </button>
                        </form>
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
