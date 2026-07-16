<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>记录详情 - 企业轻量资产管理系统</title>
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
          <h2 class="page-title">记录详情</h2>
          <p class="page-subtitle">${record.assetName} - 流转记录</p>
        </div>
        <div class="flex gap-3">
          <c:if test="${record.returnStatus == 0 && record.operationType == 1}">
            <button onclick="document.getElementById('returnModal').classList.remove('hidden')" class="btn btn-success">
              <i class="fas fa-undo mr-2"></i>归还
            </button>
          </c:if>
          <a href="${pageContext.request.contextPath}/use/list" class="btn btn-secondary">
            <i class="fas fa-arrow-left mr-2"></i>返回
          </a>
        </div>
      </div>

      <div class="grid grid-cols-1 lg:grid-cols-3 gap-6">
        <div class="card p-6 lg:col-span-2">
          <h3 class="font-bold text-gray-800 text-lg mb-4">流转信息</h3>
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
              <span>
                                <c:choose>
                                  <c:when test="${record.operationType == 1}"><span class="status-badge status-2">领用</span></c:when>
                                  <c:when test="${record.operationType == 2}"><span class="status-badge status-1">归还</span></c:when>
                                  <c:when test="${record.operationType == 3}"><span class="status-badge status-5">调拨</span></c:when>
                                </c:choose>
                            </span>
            </div>
            <div class="flex justify-between py-2 border-b border-gray-100">
              <span class="text-gray-500">操作日期</span>
              <span>${record.useDate}</span>
            </div>
            <div class="flex justify-between py-2 border-b border-gray-100">
              <span class="text-gray-500">原部门</span>
              <span>${record.fromDeptName != null ? record.fromDeptName : '仓库（在库）'}</span>
            </div>
            <div class="flex justify-between py-2 border-b border-gray-100">
              <span class="text-gray-500">目标部门</span>
              <span>${record.toDeptName != null ? record.toDeptName : '仓库（在库）'}</span>
            </div>
            <div class="flex justify-between py-2 border-b border-gray-100">
              <span class="text-gray-500">归还状态</span>
              <span>
                                <c:choose>
                                  <c:when test="${record.returnStatus == 0}"><span class="status-badge" style="background:#fee2e2;color:#991b1b">未归还</span></c:when>
                                  <c:when test="${record.returnStatus == 1}"><span class="status-badge status-2">正常归还</span></c:when>
                                  <c:when test="${record.returnStatus == 2}"><span class="status-badge status-3">逾期归还</span></c:when>
                                  <c:when test="${record.returnStatus == 3}"><span class="status-badge status-4">损坏归还</span></c:when>
                                  <otherwise><span class="status-badge" style="background:#dbeafe;color:#1e40af">无需归还</span></otherwise>
                                </c:choose>
                            </span>
            </div>
            <div class="flex justify-between py-2 border-b border-gray-100">
              <span class="text-gray-500">预计归还日期</span>
              <span>${record.expectedReturnDate != null ? record.expectedReturnDate : '-'}</span>
            </div>
            <div class="flex justify-between py-2 border-b border-gray-100">
              <span class="text-gray-500">实际归还日期</span>
              <span>${record.actualReturnDate != null ? record.actualReturnDate : '-'}</span>
            </div>
            <div class="flex justify-between py-2 border-b border-gray-100">
              <span class="text-gray-500">操作人</span>
              <span>${record.operatorName != null ? record.operatorName : '-'}</span>
            </div>
          </div>
          <c:if test="${record.purpose != null && !record.purpose.isEmpty()}">
            <div class="mt-4 pt-4 border-t">
              <h4 class="text-sm font-medium text-gray-500 mb-2">用途/原因</h4>
              <p class="text-sm text-gray-700">${record.purpose}</p>
            </div>
          </c:if>
        </div>

        <div class="card p-6">
          <h3 class="font-bold text-gray-800 text-lg mb-4">操作时间线</h3>
          <div class="space-y-4">
            <div class="flex items-start gap-3">
              <div class="w-8 h-8 rounded-full bg-blue-100 flex items-center justify-center flex-shrink-0">
                <i class="fas fa-plus text-blue-600 text-xs"></i>
              </div>
              <div>
                <p class="text-sm font-medium">创建记录</p>
                <p class="text-xs text-gray-400">${record.createTime}</p>
              </div>
            </div>
            <c:if test="${record.returnStatus == 0 && record.expectedReturnDate != null}">
              <div class="flex items-start gap-3">
                <div class="w-8 h-8 rounded-full bg-yellow-100 flex items-center justify-center flex-shrink-0">
                  <i class="fas fa-clock text-yellow-600 text-xs"></i>
                </div>
                <div>
                  <p class="text-sm font-medium">预计归还</p>
                  <p class="text-xs text-gray-400">${record.expectedReturnDate}</p>
                </div>
              </div>
            </c:if>
            <c:if test="${record.actualReturnDate != null}">
              <div class="flex items-start gap-3">
                <div class="w-8 h-8 rounded-full bg-green-100 flex items-center justify-center flex-shrink-0">
                  <i class="fas fa-check text-green-600 text-xs"></i>
                </div>
                <div>
                  <p class="text-sm font-medium">已归还</p>
                  <p class="text-xs text-gray-400">${record.actualReturnDate}</p>
                </div>
              </div>
            </c:if>
          </div>
        </div>
      </div>

      <c:if test="${record.returnStatus == 0 && record.operationType == 1}">
        <div id="returnModal" class="hidden fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center z-50">
          <div class="bg-white rounded-xl shadow-xl w-full max-w-md p-6">
            <h3 class="font-bold text-lg text-gray-800 mb-4">
              <i class="fas fa-undo mr-2 text-green-600"></i>归还资产
            </h3>
            <form action="${pageContext.request.contextPath}/use/return" method="get">
              <input type="hidden" name="id" value="${record.id}">
              <div class="form-group mb-4">
                <label class="form-label">归还状态 <span class="required">*</span></label>
                <select name="returnStatus" class="form-select" required>
                  <option value="1">正常归还</option>
                  <option value="2">逾期归还</option>
                  <option value="3">损坏归还</option>
                </select>
              </div>
              <div class="form-group mb-6">
                <label class="form-label">实际归还日期</label>
                <input type="date" name="actualReturnDate" class="form-input">
              </div>
              <div class="flex justify-end gap-3">
                <button type="button" onclick="document.getElementById('returnModal').classList.add('hidden')" class="btn btn-secondary">取消</button>
                <button type="submit" class="btn btn-success">
                  <i class="fas fa-check mr-2"></i>确认归还
                </button>
              </div>
            </form>
          </div>
        </div>
      </c:if>
    </main>
    <%@ include file="/views/common/footer.jsp" %>
