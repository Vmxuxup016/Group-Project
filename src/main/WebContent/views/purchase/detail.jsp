<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>采购单详情 - 企业轻量资产管理系统</title>
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
          <h2 class="page-title">采购单详情</h2>
          <p class="page-subtitle">${purchase.purchaseNo}</p>
        </div>
        <a href="${pageContext.request.contextPath}/purchase/list" class="btn btn-secondary">
          <i class="fas fa-arrow-left mr-2"></i>返回列表
        </a>
      </div>

      <c:if test="${purchase == null}">
        <div class="card p-12 text-center text-gray-400">
          <i class="fas fa-exclamation-triangle text-5xl mb-4"></i>
          <p class="text-lg">采购单不存在</p>
        </div>
      </c:if>

      <c:if test="${purchase != null}">
        <div class="card p-6 mb-6">
          <h3 class="text-lg font-semibold mb-4">基本信息</h3>
          <div class="grid grid-cols-2 md:grid-cols-4 gap-6">
            <div>
              <p class="text-sm text-gray-500">采购单号</p>
              <p class="font-mono font-medium text-blue-600">${purchase.purchaseNo}</p>
            </div>
            <div>
              <p class="text-sm text-gray-500">供应商</p>
              <p class="font-medium">${purchase.supplierName != null ? purchase.supplierName : '-'}</p>
            </div>
            <div>
              <p class="text-sm text-gray-500">采购日期</p>
              <p class="font-medium">${purchase.purchaseDate != null ? purchase.purchaseDate : '-'}</p>
            </div>
            <div>
              <p class="text-sm text-gray-500">状态</p>
              <p>
                <c:choose>
                  <c:when test="${purchase.status == 1}"><span class="status-badge status-1">待入库</span></c:when>
                  <c:when test="${purchase.status == 2}"><span class="status-badge status-3">部分入库</span></c:when>
                  <c:when test="${purchase.status == 3}"><span class="status-badge status-2">已入库</span></c:when>
                </c:choose>
              </p>
            </div>
            <div>
              <p class="text-sm text-gray-500">发票号</p>
              <p class="font-medium">${purchase.invoiceNo != null ? purchase.invoiceNo : '-'}</p>
            </div>
            <div>
              <p class="text-sm text-gray-500">总金额</p>
              <p class="font-medium text-lg"><fmt:formatNumber value="${purchase.totalAmount}" type="currency" currencySymbol="¥"/></p>
            </div>
            <div>
              <p class="text-sm text-gray-500">备注</p>
              <p class="font-medium">${purchase.remark != null ? purchase.remark : '-'}</p>
            </div>
          </div>
        </div>

        <div class="card p-6 mb-6">
          <h3 class="text-lg font-semibold mb-4">采购明细</h3>
          <div class="overflow-x-auto">
            <table class="data-table">
              <thead>
              <tr>
                <th>分类</th>
                <th>资产名称</th>
                <th>品牌</th>
                <th>型号</th>
                <th class="text-center">数量</th>
                <th class="text-right">单价</th>
                <th class="text-right">小计</th>
                <th class="text-center">已入库</th>
                <th class="text-center">入库进度</th>
              </tr>
              </thead>
              <tbody>
              <c:forEach items="${purchaseItems}" var="item">
                <tr class="table-row">
                  <td>${item.categoryName != null ? item.categoryName : '-'}</td>
                  <td class="font-medium">${item.assetName}</td>
                  <td>${item.brand != null ? item.brand : '-'}</td>
                  <td>${item.model != null ? item.model : '-'}</td>
                  <td class="text-center">${item.quantity}</td>
                  <td class="text-right"><fmt:formatNumber value="${item.unitPrice}" type="currency" currencySymbol="¥"/></td>
                  <td class="text-right font-medium"><fmt:formatNumber value="${item.totalPrice}" type="currency" currencySymbol="¥"/></td>
                  <td class="text-center">${item.receivedQty}</td>
                  <td class="text-center">
                    <div class="flex items-center gap-2">
                      <div class="w-20 bg-gray-200 rounded-full h-2">
                        <div class="bg-blue-600 h-2 rounded-full" style="width: ${item.quantity > 0 ? (item.receivedQty * 100 / item.quantity) : 0}%"></div>
                      </div>
                      <span class="text-xs text-gray-500">${item.receivedQty}/${item.quantity}</span>
                    </div>
                  </td>
                </tr>
              </c:forEach>
              <c:if test="${empty purchaseItems}">
                <tr>
                  <td colspan="9" class="text-center py-8 text-gray-400">暂无明细数据</td>
                </tr>
              </c:if>
              </tbody>
            </table>
          </div>
        </div>

        <c:if test="${purchase.status != 3 && !empty purchaseItems}">
          <div class="card p-6 mb-6 border-2 border-blue-200">
            <h3 class="text-lg font-semibold mb-4 text-blue-700">
              <i class="fas fa-warehouse mr-2"></i>入库操作
            </h3>
            <form action="${pageContext.request.contextPath}/purchase/in" method="post">
              <input type="hidden" name="id" value="${purchase.id}">
              <table class="data-table">
                <thead>
                <tr>
                  <th>资产名称</th>
                  <th class="text-center">采购数量</th>
                  <th class="text-center">已入库</th>
                  <th class="text-center">待入库</th>
                  <th class="text-center" style="width:140px">本次入库数量</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach items="${purchaseItems}" var="item">
                  <c:set var="remaining" value="${item.quantity - item.receivedQty}"/>
                  <c:if test="${remaining > 0}">
                    <tr class="table-row">
                      <td class="font-medium">${item.assetName}</td>
                      <td class="text-center">${item.quantity}</td>
                      <td class="text-center">${item.receivedQty}</td>
                      <td class="text-center text-orange-600 font-medium">${remaining}</td>
                      <td class="text-center">
                        <input type="hidden" name="itemIds" value="${item.id}">
                        <input type="number" name="receiveQtys" class="form-input form-input-sm text-center"
                               value="${remaining}" min="0" max="${remaining}">
                      </td>
                    </tr>
                  </c:if>
                </c:forEach>
                </tbody>
              </table>
              <div class="flex justify-end gap-3 mt-4 pt-4 border-t">
                <button type="submit" class="btn btn-primary">
                  <i class="fas fa-warehouse mr-2"></i>确认入库
                </button>
              </div>
            </form>
          </div>
        </c:if>
      </c:if>
    </main>
    <%@ include file="/views/common/footer.jsp" %>