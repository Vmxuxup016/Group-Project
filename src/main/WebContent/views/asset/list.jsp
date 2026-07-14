<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>资产档案 - 企业轻量资产管理系统</title>
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
                    <h2 class="page-title">资产档案</h2>
                    <p class="page-subtitle">一物一码，全生命周期管理</p>
                </div>
                <div class="flex gap-3">
                    <a href="${pageContext.request.contextPath}/asset/add" class="btn btn-primary">
                        <i class="fas fa-plus mr-2"></i>新增资产
                    </a>
                    <a href="${pageContext.request.contextPath}/asset/export" class="btn btn-secondary">
                        <i class="fas fa-download mr-2"></i>导出
                    </a>
                </div>
            </div>

            <div class="card p-4 mb-6">
                <form action="${pageContext.request.contextPath}/asset/list" method="get" class="flex flex-wrap gap-4">
                    <div class="search-box flex-1 min-w-[200px]">
                        <i class="fas fa-search search-icon"></i>
                        <input type="text" name="keyword" value="${param.keyword}" placeholder="搜索资产编码、名称、SN..." class="form-input">
                    </div>
                    <select name="status" class="form-select" style="width: auto; min-width: 120px;">
                        <option value="">全部状态</option>
                        <option value="1" ${param.status == '1' ? 'selected' : ''}>在库</option>
                        <option value="2" ${param.status == '2' ? 'selected' : ''}>部门在用</option>
                        <option value="3" ${param.status == '3' ? 'selected' : ''}>维修中</option>
                        <option value="4" ${param.status == '4' ? 'selected' : ''}>报废</option>
                        <option value="5" ${param.status == '5' ? 'selected' : ''}>调拨中</option>
                    </select>
                    <select name="categoryId" class="form-select" style="width: auto; min-width: 120px;">
                        <option value="">全部分类</option>
                        <c:forEach items="${categoryList}" var="cat">
                        <option value="${cat.id}" ${param.categoryId == cat.id ? 'selected' : ''}>${cat.categoryName}</option>
                        </c:forEach>
                    </select>
                    <select name="deptId" class="form-select" style="width: auto; min-width: 120px;">
                        <option value="">全部部门</option>
                        <c:forEach items="${deptList}" var="dept">
                        <option value="${dept.id}" ${param.deptId == dept.id ? 'selected' : ''}>${dept.deptName}</option>
                        </c:forEach>
                    </select>
                    <button type="submit" class="btn btn-primary">
                        <i class="fas fa-search mr-1"></i>查询
                    </button>
                </form>
            </div>

            <div class="card overflow-hidden">
                <div class="overflow-x-auto">
                    <table class="data-table">
                        <thead>
                            <tr>
                                <th class="text-center" style="width: 40px;"><input type="checkbox" onclick="toggleSelectAll(this, 'assetIds')"></th>
                                <th>资产编码</th>
                                <th>资产名称</th>
                                <th>分类</th>
                                <th>品牌/型号</th>
                                <th class="text-center">状态</th>
                                <th>所属部门</th>
                                <th class="text-right">采购价格</th>
                                <th class="text-center">操作</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${assetList}" var="asset">
                            <tr class="table-row">
                                <td class="text-center"><input type="checkbox" name="assetIds" value="${asset.id}"></td>
                                <td class="font-mono text-blue-600 font-medium">${asset.assetCode}</td>
                                <td>
                                    <div class="flex items-center gap-2">
                                        <div class="w-8 h-8 bg-blue-100 rounded-lg flex items-center justify-center">
                                            <i class="fas fa-laptop text-blue-600 text-xs"></i>
                                        </div>
                                        <span class="font-medium">${asset.assetName}</span>
                                    </div>
                                </td>
                                <td class="text-gray-600">${asset.categoryName}</td>
                                <td class="text-gray-600">${asset.brand} / ${asset.model}</td>
                                <td class="text-center">
                                    <c:choose>
                                        <c:when test="${asset.status == 1}"><span class="status-badge status-1">在库</span></c:when>
                                        <c:when test="${asset.status == 2}"><span class="status-badge status-2">部门在用</span></c:when>
                                        <c:when test="${asset.status == 3}"><span class="status-badge status-3">维修中</span></c:when>
                                        <c:when test="${asset.status == 4}"><span class="status-badge status-4">报废</span></c:when>
                                        <c:when test="${asset.status == 5}"><span class="status-badge status-5">调拨中</span></c:when>
                                        <c:otherwise><span class="status-badge">未知</span></c:otherwise>
                                    </c:choose>
                                </td>
                                <td class="text-gray-600">${asset.deptName != null ? asset.deptName : '-'}</td>
                                <td class="text-right font-medium"><fmt:formatNumber value="${asset.purchasePrice}" type="currency" currencySymbol="¥"/></td>
                                <td class="text-center">
                                    <a href="${pageContext.request.contextPath}/asset/detail?id=${asset.id}" class="text-blue-600 hover:text-blue-800 mr-2" title="查看"><i class="fas fa-eye"></i></a>
                                    <a href="${pageContext.request.contextPath}/asset/edit?id=${asset.id}" class="text-amber-600 hover:text-amber-800 mr-2" title="编辑"><i class="fas fa-edit"></i></a>
                                    <a href="${pageContext.request.contextPath}/asset/delete?id=${asset.id}" class="text-rose-600 hover:text-rose-800" title="删除" onclick="return confirmDelete('确定删除资产 ${asset.assetName} 吗？')"><i class="fas fa-trash"></i></a>
                                </td>
                            </tr>
                            </c:forEach>
                            <c:if test="${empty assetList}">
                            <tr>
                                <td colspan="9" class="text-center py-12 text-gray-400">
                                    <i class="fas fa-inbox text-4xl mb-3"></i>
                                    <p>暂无资产数据</p>
                                </td>
                            </tr>
                            </c:if>
                        </tbody>
                    </table>
                </div>

                <c:if test="${pageInfo != null}">
                <div class="flex justify-between items-center p-4 border-t border-gray-200">
                    <span class="text-sm text-gray-500">共 ${pageInfo.total} 条记录，每页 ${pageInfo.pageSize} 条</span>
                    <div class="pagination">
                        <c:if test="${pageInfo.hasPreviousPage}">
                            <a href="${pageContext.request.contextPath}/asset/list?page=${pageInfo.prePage}&keyword=${param.keyword}&status=${param.status}&categoryId=${param.categoryId}&deptId=${param.deptId}">上一页</a>
                        </c:if>
                        <c:forEach items="${pageInfo.navigatepageNums}" var="num">
                            <c:choose>
                                <c:when test="${num == pageInfo.pageNum}"><span class="active">${num}</span></c:when>
                                <c:otherwise><a href="${pageContext.request.contextPath}/asset/list?page=${num}&keyword=${param.keyword}&status=${param.status}&categoryId=${param.categoryId}&deptId=${param.deptId}">${num}</a></c:otherwise>
                            </c:choose>
                        </c:forEach>
                        <c:if test="${pageInfo.hasNextPage}">
                            <a href="${pageContext.request.contextPath}/asset/list?page=${pageInfo.nextPage}&keyword=${param.keyword}&status=${param.status}&categoryId=${param.categoryId}&deptId=${param.deptId}">下一页</a>
                        </c:if>
                    </div>
                </div>
                </c:if>
            </div>
        </main>
<%@ include file="/views/common/footer.jsp" %>