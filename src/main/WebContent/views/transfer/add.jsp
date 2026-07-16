<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>发起调拨 - 企业轻量资产管理系统</title>
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
                    <h2 class="page-title">发起调拨</h2>
                    <p class="page-subtitle">将资产从一个部门调拨到另一个部门，需经审批后生效</p>
                </div>
            </div>

            <div class="max-w-4xl mx-auto px-4 space-y-6">
                <c:if test="${not empty errorMsg}">
                <div class="p-4 bg-red-50 border border-red-200 rounded-xl text-red-700 text-sm flex items-center justify-between">
                    <span><i class="fas fa-exclamation-circle mr-2"></i>${errorMsg}</span>
                    <button type="button" onclick="this.parentElement.remove()" class="text-red-400 hover:text-red-600"><i class="fas fa-times"></i></button>
                </div>
                </c:if>
                <div class="card p-6">
                    <div class="flex items-start gap-4 mb-6 p-4 rounded-lg" style="background:#eff6ff;border:1px solid #bfdbfe;">
                        <div class="w-10 h-10 bg-blue-100 rounded-lg flex items-center justify-center flex-shrink-0">
                            <i class="fas fa-info-circle text-blue-600"></i>
                        </div>
                        <div class="text-sm text-gray-600">
                            <p class="font-medium text-gray-800 mb-1">调拨流程说明</p>
                            <p>1. 提交调拨申请 → 资产状态变为<strong>"调拨中"</strong></p>
                            <p>2. 审批通过 → 资产自动归属到目标部门，状态恢复为<strong>"部门在用"</strong></p>
                            <p>3. 审批驳回 → 资产状态恢复，保留在原部门</p>
                        </div>
                    </div>

                    <form action="${pageContext.request.contextPath}/transfer/save" method="post">
                        <input type="hidden" name="operatorId" value="1">

                        <div class="grid grid-cols-2 gap-6">
                            <div class="form-group">
                                <label class="form-label">
                                    调拨资产 <span class="required">*</span>
                                </label>
                                <select name="assetId" id="assetSelect" class="form-select" required
                                        onchange="autoFillDept()">
                                    <option value="">请选择资产</option>
                                    <c:forEach items="${assetList}" var="a">
                                        <option value="${a.id}"
                                                data-dept-id="${a.departmentId}"
                                                data-dept-name="${a.deptName}">
                                            ${a.assetCode} - ${a.assetName}
                                            <c:if test="${a.deptName != null}">[${a.deptName}]</c:if>
                                        </option>
                                    </c:forEach>
                                </select>
                                <c:if test="${empty assetList}">
                                <p class="text-amber-600 text-xs mt-1">
                                    <i class="fas fa-exclamation-triangle mr-1"></i>暂无可调拨的资产（需要状态为"部门在用"的资产）
                                </p>
                                </c:if>
                            </div>
                            <div class="form-group">
                                <label class="form-label">调拨日期 <span class="required">*</span></label>
                                <input type="date" name="useDate" class="form-input" value="${today}" required>
                            </div>
                        </div>

                        <div class="grid grid-cols-2 gap-6 mt-4">
                            <div class="form-group">
                                <label class="form-label">
                                    调出部门 <span class="required">*</span>
                                </label>
                                <input type="text" id="fromDeptDisplay" class="form-input bg-gray-50"
                                       value="选择资产后自动填充" disabled>
                                <input type="hidden" name="fromDeptId" id="fromDeptId">
                            </div>
                            <div class="form-group">
                                <label class="form-label">
                                    调入部门 <span class="required">*</span>
                                </label>
                                <select name="toDeptId" class="form-select" required>
                                    <option value="">请选择目标部门</option>
                                    <c:forEach items="${deptList}" var="dept">
                                        <option value="${dept.id}">${dept.deptName}</option>
                                    </c:forEach>
                                </select>
                            </div>
                        </div>

                        <div class="form-group mt-4">
                            <label class="form-label">调拨原因 <span class="required">*</span></label>
                            <textarea name="purpose" rows="3" class="form-textarea"
                                      placeholder="请详细说明调拨原因，如：业务调整、部门重组、设备优化配置等"
                                      required></textarea>
                        </div>

                        <div class="flex justify-end gap-3 pt-4 border-t mt-4">
                            <a href="${pageContext.request.contextPath}/transfer/list" class="btn btn-secondary">
                                <i class="fas fa-arrow-left mr-2"></i>取消
                            </a>
                            <button type="submit" class="btn btn-primary">
                                <i class="fas fa-paper-plane mr-2"></i>提交调拨申请
                            </button>
                        </div>
                    </form>
                </div>
            </div>
        </main>
        <%@ include file="/views/common/footer.jsp" %>
    </div>
</div>
<script>
function autoFillDept() {
    var select = document.getElementById('assetSelect');
    var option = select.options[select.selectedIndex];
    var deptName = option.getAttribute('data-dept-name');
    var deptId = option.getAttribute('data-dept-id');
    if (deptId) {
        document.getElementById('fromDeptDisplay').value = deptName || '未分配部门';
        document.getElementById('fromDeptId').value = deptId;
    } else {
        document.getElementById('fromDeptDisplay').value = '选择资产后自动填充';
        document.getElementById('fromDeptId').value = '';
    }
}
</script>
</body>
</html>
