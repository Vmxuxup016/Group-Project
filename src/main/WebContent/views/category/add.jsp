<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>新增分类 - 企业轻量资产管理系统</title>
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
          <h2 class="page-title">新增分类</h2>
          <p class="page-subtitle">添加资产分类节点</p>
        </div>
      </div>

      <div class="card p-6 max-w-2xl">
        <form id="categoryForm" action="${pageContext.request.contextPath}/category/save" method="post" onsubmit="return validateCategoryForm()">
          <div class="form-group">
            <label class="form-label">上级分类</label>
            <select name="parentId" id="parentSelect" class="form-select" onchange="autoFillLevel()">
              <option value="0">无（作为一级分类）</option>
              <c:forEach items="${categoryList}" var="cat">
                <c:if test="${cat.categoryLevel <= 2}">
                  <option value="${cat.id}" data-level="${cat.categoryLevel}">
                    <c:if test="${cat.categoryLevel == 2}">└ </c:if>
                      ${cat.categoryName}（${cat.categoryLevel == 1 ? '一级' : '二级'}）
                  </option>
                </c:if>
              </c:forEach>
            </select>
            <p class="text-xs text-gray-400 mt-1">选择"无"创建一级分类；选择一级分类创建二级子分类；选择二级分类创建三级子分类</p>
          </div>
          <div class="form-group">
            <label class="form-label">分类层级 <span class="required">*</span></label>
            <select name="categoryLevel" id="levelSelect" class="form-select">
              <option value="1" selected>一级分类</option>
              <option value="2">二级分类</option>
              <option value="3">三级分类</option>
            </select>
          </div>
          <div class="form-group">
            <label class="form-label">分类名称 <span class="required">*</span></label>
            <input type="text" name="categoryName" class="form-input" placeholder="请输入分类名称" required>
          </div>
          <div class="form-group">
            <label class="form-label">分类编码 <span class="required">*</span></label>
            <input type="text" name="categoryCode" class="form-input" placeholder="如: DZ、JSJ、NB" required>
            <p class="text-xs text-gray-400 mt-1">建议2-5个大写字母，用于资产编码前缀</p>
          </div>
          <div class="grid grid-cols-2 gap-6">
            <div class="form-group">
              <label class="form-label">默认折旧月数</label>
              <input type="number" name="depreciableLife" class="form-input" value="36" min="0" max="600">
            </div>
            <div class="form-group">
              <label class="form-label">排序号</label>
              <input type="number" name="sortOrder" class="form-input" value="0" min="0">
            </div>
          </div>
          <div class="flex justify-end gap-3 pt-4 border-t">
            <a href="${pageContext.request.contextPath}/category/list" class="btn btn-secondary">取消</a>
            <button type="submit" class="btn btn-primary">
              <i class="fas fa-save mr-2"></i>保存
            </button>
          </div>
        </form>
      </div>
    </main>
    <%@ include file="/views/common/footer.jsp" %>
    <script>
      function autoFillLevel() {
        var sel = document.getElementById('parentSelect');
        var opt = sel.options[sel.selectedIndex];
        var parentLevel = parseInt(opt.getAttribute('data-level')) || 0;
        var levelSelect = document.getElementById('levelSelect');
        var newLevel = parentLevel + 1;
        if (newLevel > 3) newLevel = 3;
        levelSelect.value = newLevel;
      }

      function validateCategoryForm() {
        var form = document.getElementById('categoryForm');
        var name = form.querySelector('[name="categoryName"]').value.trim();
        var code = form.querySelector('[name="categoryCode"]').value.trim();
        if (!name) { alert('请输入分类名称'); return false; }
        if (!code) { alert('请输入分类编码'); return false; }
        return true;
      }
    </script>
  </div>
</body>
</html>