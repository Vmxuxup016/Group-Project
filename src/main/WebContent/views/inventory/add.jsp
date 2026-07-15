<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>新建盘点任务 - 企业轻量资产管理系统</title>
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
                    <h2 class="page-title">新建盘点任务</h2>
                    <p class="page-subtitle">创建盘点任务并指定盘点范围</p>
                </div>
            </div>

            <form action="${pageContext.request.contextPath}/inventory/list" method="post"
                  class="max-w-5xl mx-auto px-4 space-y-6">
                <div class="card p-6">
                    <h3 class="text-lg font-semibold mb-4">任务信息</h3>
                    <div class="grid grid-cols-2 gap-6">
                        <div class="form-group">
                            <label class="form-label">任务名称 <span class="required">*</span></label>
                            <input type="text" name="inventoryName" class="form-input" placeholder="如：2024年度年终盘点" required>
                        </div>
                        <div class="form-group">
                            <label class="form-label">计划日期 <span class="required">*</span></label>
                            <input type="date" name="planDate" class="form-input" required>
                        </div>
                    </div>
                    <div class="grid grid-cols-3 gap-6 mt-4">
                        <div class="form-group">
                            <label class="form-label">盘点类型 <span class="required">*</span></label>
                            <select name="inventoryType" id="inventoryType" class="form-select" required onchange="toggleScope()">
                                <option value="1">全面盘点</option>
                                <option value="2">按部门</option>
                                <option value="3">按分类</option>
                            </select>
                        </div>
                        <div class="form-group">
                            <label class="form-label">盘点方式 <span class="required">*</span></label>
                            <select name="inventoryMethod" class="form-select" required>
                                <option value="1">人工扫码</option>
                                <option value="2">RFID批量</option>
                            </select>
                        </div>
                        <div class="form-group">
                            <label class="form-label">负责人 <span class="required">*</span></label>
                            <select name="operatorId" class="form-select" required>
                                <option value="">请选择负责人</option>
                                <c:forEach items="${userList}" var="u">
                                    <option value="${u.id}">${u.realName} (${u.username})</option>
                                </c:forEach>
                            </select>
                        </div>
                    </div>
                    <div class="mt-4" id="scopeDept" style="display:none;">
                        <div class="form-group">
                            <label class="form-label">盘点部门（可多选）</label>
                            <div class="grid grid-cols-3 gap-2 border rounded-lg p-4">
                                <c:forEach items="${deptList}" var="d">
                                    <label class="flex items-center gap-2 cursor-pointer hover:bg-gray-50 p-1 rounded">
                                        <input type="checkbox" name="scopeDeptIds" value="${d.id}" class="rounded"> ${d.deptName}
                                    </label>
                                </c:forEach>
                            </div>
                        </div>
                    </div>
                    <div class="mt-4" id="scopeCategory" style="display:none;">
                        <div class="form-group">
                            <label class="form-label">盘点分类（可多选）</label>
                            <div class="grid grid-cols-3 gap-2 border rounded-lg p-4">
                                <c:forEach items="${categoryList}" var="c">
                                    <label class="flex items-center gap-2 cursor-pointer hover:bg-gray-50 p-1 rounded">
                                        <input type="checkbox" name="scopeCatIds" value="${c.id}" class="rounded"> ${c.categoryName}
                                    </label>
                                </c:forEach>
                            </div>
                        </div>
                    </div>
                    <!-- Hidden field for comma-separated scope IDs -->
                    <input type="hidden" name="scopeIds" id="scopeIds" value="">
                    <div class="mt-4">
                        <div class="form-group">
                            <label class="form-label">备注</label>
                            <input type="text" name="remark" class="form-input" placeholder="盘点任务备注">
                        </div>
                    </div>
                </div>

                <div class="flex justify-end gap-3 pb-6">
                    <a href="${pageContext.request.contextPath}/inventory/list" class="btn btn-secondary">取消</a>
                    <button type="submit" class="btn btn-primary" onclick="prepareSubmit()">
                        <i class="fas fa-save mr-2"></i>创建盘点任务
                    </button>
                </div>
            </form>
        </main>
        <%@ include file="/views/common/footer.jsp" %>
    </div>
</div>
<script>
    function toggleScope() {
        var type = document.getElementById('inventoryType').value;
        document.getElementById('scopeDept').style.display = (type === '2') ? 'block' : 'none';
        document.getElementById('scopeCategory').style.display = (type === '3') ? 'block' : 'none';
    }
    function prepareSubmit() {
        var type = document.getElementById('inventoryType').value;
        var ids = [];
        if (type === '2') {
            document.querySelectorAll('input[name="scopeDeptIds"]:checked').forEach(function(cb) {
                ids.push(cb.value);
            });
        } else if (type === '3') {
            document.querySelectorAll('input[name="scopeCatIds"]:checked').forEach(function(cb) {
                ids.push(cb.value);
            });
        }
        document.getElementById('scopeIds').value = ids.join(',');
    }
</script>
</body>
</html>
