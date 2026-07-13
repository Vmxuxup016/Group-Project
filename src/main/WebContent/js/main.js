/* ============================================================
   企业轻量资产管理系统 - 全局脚本
   ============================================================ */

// 页面切换
function showPage(pageId, element) {
    document.querySelectorAll('.page-section').forEach(page => {
        page.style.display = 'none';
    });
    const target = document.getElementById('page-' + pageId);
    if (target) target.style.display = 'block';

    document.querySelectorAll('.sidebar-item').forEach(item => {
        item.classList.remove('active');
    });
    if (element) element.classList.add('active');

    const titles = {
        'dashboard': '数据仪表盘',
        'asset': '资产档案',
        'category': '资产分类',
        'purchase': '采购入库',
        'use': '领用归还',
        'repair': '维修管理',
        'scrap': '报废管理',
        'inventory': '资产盘点',
        'depreciation': '折旧计算',
        'rfid': 'RFID管理',
        'transfer': '调拨审批',
        'dept': '部门管理',
        'user': '用户管理',
        'supplier': '供应商管理'
    };
    const titleEl = document.getElementById('page-title');
    if (titleEl) titleEl.textContent = titles[pageId] || '数据仪表盘';
}

// 模态框控制
function openModal(modalId) {
    const modal = document.getElementById(modalId);
    if (modal) modal.classList.add('show');
}

function closeModal(modalId) {
    const modal = document.getElementById(modalId);
    if (modal) modal.classList.remove('show');
}

// 点击模态框背景关闭
document.addEventListener('DOMContentLoaded', function() {
    document.querySelectorAll('.modal-overlay').forEach(modal => {
        modal.addEventListener('click', function(e) {
            if (e.target === this) this.classList.remove('show');
        });
    });
});

// Toast 提示
function showToast(message, type) {
    let container = document.querySelector('.toast-container');
    if (!container) {
        container = document.createElement('div');
        container.className = 'toast-container';
        document.body.appendChild(container);
    }

    const toast = document.createElement('div');
    const icons = {
        success: 'fa-check-circle',
        error: 'fa-times-circle',
        info: 'fa-info-circle',
        warning: 'fa-exclamation-circle'
    };
    toast.className = 'toast toast-' + (type || 'info');
    toast.innerHTML = '<i class="fas ' + (icons[type] || icons.info) + '"></i>' + message;
    container.appendChild(toast);

    setTimeout(() => toast.classList.add('show'), 10);

    setTimeout(() => {
        toast.classList.remove('show');
        setTimeout(() => toast.remove(), 300);
    }, 3000);
}

// 表单验证
function validateForm(formId) {
    const form = document.getElementById(formId);
    if (!form) return true;

    let valid = true;
    form.querySelectorAll('[required]').forEach(field => {
        if (!field.value.trim()) {
            field.style.borderColor = '#dc2626';
            valid = false;
        } else {
            field.style.borderColor = '#d1d5db';
        }
    });

    if (!valid) showToast('请填写必填项', 'error');
    return valid;
}

// 确认删除
function confirmDelete(message) {
    return confirm(message || '确定要删除吗？此操作不可撤销。');
}

// 全选/反选
function toggleSelectAll(source, name) {
    document.querySelectorAll('input[name="' + name + '"]').forEach(cb => {
        cb.checked = source.checked;
    });
}

// 移动端侧边栏切换
function toggleSidebar() {
    const sidebar = document.querySelector('.sidebar');
    const overlay = document.querySelector('.sidebar-overlay');
    if (sidebar) sidebar.classList.toggle('show');
    if (overlay) overlay.classList.toggle('show');
}

// 日期格式化
function formatDate(dateStr) {
    if (!dateStr) return '-';
    const d = new Date(dateStr);
    return d.getFullYear() + '-' + String(d.getMonth()+1).padStart(2,'0') + '-' + String(d.getDate()).padStart(2,'0');
}

// 金额格式化
function formatMoney(amount) {
    if (amount === null || amount === undefined) return '-';
    return '¥' + parseFloat(amount).toLocaleString('zh-CN', {minimumFractionDigits: 2, maximumFractionDigits: 2});
}

// 状态映射
const statusMap = {
    assetStatus: {
        1: { text: '在库', class: 'status-1' },
        2: { text: '部门在用', class: 'status-2' },
        3: { text: '维修中', class: 'status-3' },
        4: { text: '报废', class: 'status-4' },
        5: { text: '调拨中', class: 'status-5' }
    },
    purchaseStatus: {
        1: { text: '待入库', class: 'status-1' },
        2: { text: '部分入库', class: 'status-3' },
        3: { text: '已入库', class: 'status-2' }
    },
    repairStatus: {
        1: { text: '待维修', class: 'status-1' },
        2: { text: '维修中', class: 'status-3' },
        3: { text: '已完成', class: 'status-2' },
        4: { text: '无法修复', class: 'status-4' }
    },
    scrapStatus: {
        1: { text: '待审批', class: 'status-1' },
        2: { text: '已通过', class: 'status-2' },
        3: { text: '已执行', class: 'status-2' },
        4: { text: '驳回', class: 'status-4' }
    },
    inventoryStatus: {
        1: { text: '待盘点', class: 'status-1' },
        2: { text: '盘点中', class: 'status-3' },
        3: { text: '已完成', class: 'status-2' }
    }
};

function getStatusHtml(status, type) {
    const map = statusMap[type];
    if (!map || !map[status]) return '<span class="status-badge">未知</span>';
    const s = map[status];
    return '<span class="status-badge ' + s.class + '">' + s.text + '</span>';
}
