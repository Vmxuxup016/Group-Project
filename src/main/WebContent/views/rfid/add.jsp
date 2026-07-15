<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>注册RFID标签 - 企业轻量资产管理系统</title>
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
                    <h2 class="page-title">注册RFID标签</h2>
                    <p class="page-subtitle">新增RFID电子标签，录入EPC编码后可与资产绑定</p>
                </div>
            </div>

            <div class="max-w-3xl mx-auto px-4 space-y-6">
                <div class="card p-6">
                    <div class="flex items-start gap-4 mb-6">
                        <div class="w-10 h-10 bg-purple-100 rounded-lg flex items-center justify-center flex-shrink-0">
                            <i class="fas fa-info-circle text-purple-600"></i>
                        </div>
                        <div class="text-sm text-gray-600">
                            <p class="font-medium text-gray-800 mb-1">EPC编码说明</p>
                            <p>EPC（Electronic Product Code）是RFID标签的唯一标识码，通常为96位编码，以十六进制表示。
                            请确保标签编码唯一，注册后可为标签绑定资产，实现资产的无线射频识别与追踪。</p>
                        </div>
                    </div>

                    <form action="${pageContext.request.contextPath}/rfid/save" method="post">
                        <div class="form-group">
                            <label class="form-label">
                                <i class="fas fa-tag mr-1"></i>EPC标签编码 <span class="required">*</span>
                            </label>
                            <input type="text" name="tagCode" class="form-input text-lg font-mono"
                                   placeholder="例如：E2806894000050025C0A6C2B"
                                   required pattern="[A-Za-z0-9]{10,50}"
                                   title="请输入10-50位字母或数字的EPC编码">
                            <p class="text-gray-400 text-xs mt-1">支持字母和数字，长度10-50位</p>
                        </div>

                        <div class="card p-4 mb-4" style="background:#f0fdf4;border:1px solid #bbf7d0;">
                            <div class="flex items-center gap-2 text-sm text-emerald-700">
                                <i class="fas fa-lightbulb"></i>
                                <span><strong>提示：</strong>标签创建后状态为"未绑定"，可在标签详情页将其绑定到具体资产。</span>
                            </div>
                        </div>

                        <div class="flex justify-end gap-3">
                            <a href="${pageContext.request.contextPath}/rfid/list" class="btn btn-secondary">
                                <i class="fas fa-arrow-left mr-2"></i>返回列表
                            </a>
                            <button type="submit" class="btn btn-primary">
                                <i class="fas fa-save mr-2"></i>注册标签
                            </button>
                        </div>
                    </form>
                </div>

                <div class="card p-6">
                    <h3 class="font-bold text-gray-800 mb-3">
                        <i class="fas fa-list-ul mr-2 text-purple-600"></i>批量生成标签
                    </h3>
                    <p class="text-sm text-gray-500 mb-4">快速生成一批RFID标签编码（格式：RFID-YYYYMMDD-序号）</p>
                    <form action="${pageContext.request.contextPath}/rfid/save" method="post" class="flex items-end gap-4">
                        <div class="form-group flex-1">
                            <label class="form-label">生成数量</label>
                            <select id="batchCount" class="form-select" style="width:auto">
                                <option value="5">5 个</option>
                                <option value="10">10 个</option>
                                <option value="20">20 个</option>
                                <option value="50">50 个</option>
                            </select>
                        </div>
                        <button type="button" class="btn" style="background:#7c3aed;color:white;height:42px"
                                onclick="batchGenerate()">
                            <i class="fas fa-magic mr-2"></i>批量生成
                        </button>
                    </form>
                    <div id="batchPreview" class="mt-4 hidden">
                        <p class="text-sm font-medium text-gray-700 mb-2">预览生成的标签：</p>
                        <div id="batchTags" class="bg-gray-50 rounded-lg p-4 font-mono text-sm text-gray-600 max-h-40 overflow-y-auto"></div>
                    </div>
                </div>
            </div>
        </main>
        <%@ include file="/views/common/footer.jsp" %>
    </div>
</div>
<script>
function batchGenerate() {
    var count = parseInt(document.getElementById('batchCount').value);
    var today = new Date().toISOString().slice(0,10).replace(/-/g,'');
    var html = '';
    for (var i = 1; i <= count; i++) {
        var seq = String(i).padStart(3, '0');
        html += '<div class="py-1 border-b border-gray-200 last:border-0">RFID-' + today + '-' + seq + '</div>';
    }
    document.getElementById('batchTags').innerHTML = html;
    document.getElementById('batchPreview').classList.remove('hidden');
}
</script>
</body>
</html>
