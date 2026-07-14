<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>新增采购单 - 企业轻量资产管理系统</title>
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
                    <h2 class="page-title">新增采购单</h2>
                    <p class="page-subtitle">录入采购信息并添加采购明细</p>
                </div>
            </div>

            <c:if test="${param.error == 'empty'}">
                <div class="max-w-5xl mx-auto px-4">
                    <div class="bg-red-50 border border-red-200 text-red-700 px-4 py-3 rounded-lg flex items-center gap-2">
                        <i class="fas fa-exclamation-circle"></i>
                        <span>请至少添加一条采购明细</span>
                    </div>
                </div>
            </c:if>

            <form id="purchaseForm" action="${pageContext.request.contextPath}/purchase/save" method="post"
                  class="max-w-5xl mx-auto px-4 space-y-6">
                <div class="card p-6">
                    <h3 class="text-lg font-semibold mb-4">基本信息</h3>
                    <div class="grid grid-cols-2 gap-6">
                        <div class="form-group">
                            <label class="form-label">供应商 <span class="required">*</span></label>
                            <select name="supplierId" class="form-select" required>
                                <option value="">请选择供应商</option>
                                <c:forEach items="${supplierList}" var="sup">
                                    <option value="${sup.id}">${sup.supplierName}</option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="form-group">
                            <label class="form-label">采购日期 <span class="required">*</span></label>
                            <input type="date" name="purchaseDate" class="form-input" required>
                        </div>
                    </div>
                    <div class="grid grid-cols-2 gap-6">
                        <div class="form-group">
                            <label class="form-label">发票号</label>
                            <input type="text" name="invoiceNo" class="form-input" placeholder="请输入发票号">
                        </div>
                        <div class="form-group">
                            <label class="form-label">备注</label>
                            <input type="text" name="remark" class="form-input" placeholder="请输入备注">
                        </div>
                    </div>
                </div>

                <div class="card p-6">
                    <div class="flex justify-between items-center mb-4">
                        <h3 class="text-lg font-semibold">采购明细</h3>
                        <button type="button" onclick="addItemRow()" class="btn btn-primary btn-sm">
                            <i class="fas fa-plus mr-1"></i>添加行
                        </button>
                    </div>
                    <div class="overflow-x-auto">
                        <table class="data-table" id="itemsTable">
                            <thead>
                            <tr>
                                <th style="min-width:120px">分类</th>
                                <th style="min-width:140px">资产名称</th>
                                <th style="min-width:100px">品牌</th>
                                <th style="min-width:100px">型号</th>
                                <th style="width:80px">数量</th>
                                <th style="width:110px">单价</th>
                                <th style="width:100px">质保(月)</th>
                                <th style="width:110px">小计</th>
                                <th style="width:50px">操作</th>
                            </tr>
                            </thead>
                            <tbody id="itemsBody">
                            </tbody>
                            <tfoot>
                            <tr class="bg-gray-50 font-semibold">
                                <td colspan="7" class="text-right pr-4">合计：</td>
                                <td id="totalAmount" class="text-left">¥0.00</td>
                                <td></td>
                            </tr>
                            </tfoot>
                        </table>
                    </div>
                </div>

                <div class="flex justify-end gap-3 pb-6">
                    <a href="${pageContext.request.contextPath}/purchase/list" class="btn btn-secondary">取消</a>
                    <button type="submit" class="btn btn-primary">
                        <i class="fas fa-save mr-2"></i>保存采购单
                    </button>
                </div>
            </form>
        </main>
        <%@ include file="/views/common/footer.jsp" %>
        <script>
            let rowIndex = 0;
            const categoryOptions = '<option value="">选择分类</option>'
                    <c:forEach items="${categoryList}" var="cat">
                    + '<option value="${cat.id}">${cat.categoryName}</option>'
                </c:forEach>;

            function addItemRow() {
                rowIndex++;
                const tr = document.createElement('tr');
                tr.className = 'table-row item-row';
                tr.innerHTML =
                    '<td><select name="categoryIds" class="form-select form-select-sm">' + categoryOptions + '</select></td>' +
                    '<td><input type="text" name="itemNames" class="form-input form-input-sm" placeholder="资产名称" required></td>' +
                    '<td><input type="text" name="brands" class="form-input form-input-sm" placeholder="品牌"></td>' +
                    '<td><input type="text" name="models" class="form-input form-input-sm" placeholder="型号"></td>' +
                    '<td><input type="number" name="quantities" class="form-input form-input-sm qty" value="1" min="1" onchange="calcRow(this)" oninput="calcRow(this)"></td>' +
                    '<td><input type="number" name="unitPrices" step="0.01" class="form-input form-input-sm price" value="0" min="0" onchange="calcRow(this)" oninput="calcRow(this)"></td>' +
                    '<td><input type="number" name="warrantyMonths" class="form-input form-input-sm" value="12" min="0"></td>' +
                    '<td class="subtotal text-right font-medium">¥0.00</td>' +
                    '<td class="text-center"><button type="button" onclick="removeRow(this)" class="text-red-500 hover:text-red-700"><i class="fas fa-trash"></i></button></td>';
                document.getElementById('itemsBody').appendChild(tr);
            }

            function removeRow(btn) {
                btn.closest('tr').remove();
                calcTotal();
            }

            function calcRow(el) {
                const tr = el.closest('tr');
                const qty = parseFloat(tr.querySelector('.qty').value) || 0;
                const price = parseFloat(tr.querySelector('.price').value) || 0;
                tr.querySelector('.subtotal').textContent = '¥' + (qty * price).toFixed(2);
                calcTotal();
            }

            function calcTotal() {
                let total = 0;
                document.querySelectorAll('.item-row').forEach(function (row) {
                    const qty = parseFloat(row.querySelector('.qty').value) || 0;
                    const price = parseFloat(row.querySelector('.price').value) || 0;
                    total += qty * price;
                });
                document.getElementById('totalAmount').textContent = '¥' + total.toFixed(2);
            }

            document.getElementById('purchaseForm').addEventListener('submit', function (e) {
                if (document.querySelectorAll('.item-row').length === 0) {
                    e.preventDefault();
                    alert('请至少添加一条采购明细');
                }
            });

            addItemRow();
        </script>
