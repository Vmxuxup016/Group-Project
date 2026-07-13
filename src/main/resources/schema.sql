-- ============================================================
-- 企业轻量资产管理系统 - 结课作业标准版
-- 表数量：14张
-- 核心：资产档案、采购入库、领用归还、维修、报废、盘点
-- 前瞻：折旧计算、RFID标签、调拨审批
-- 原则：资产流转只关联部门，不关联个人
-- ============================================================

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

CREATE DATABASE IF NOT EXISTS `asset_db` 
DEFAULT CHARACTER SET utf8mb4 
COLLATE utf8mb4_unicode_ci;

USE `asset_db`;

-- ----------------------------
-- 1. department 部门表
-- ----------------------------
DROP TABLE IF EXISTS `department`;
CREATE TABLE `department` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '部门ID',
  `parent_id` int(11) NOT NULL DEFAULT 0 COMMENT '上级部门ID，0为根节点',
  `dept_name` varchar(50) NOT NULL COMMENT '部门名称',
  `dept_code` varchar(20) DEFAULT NULL COMMENT '部门编码',
  `sort_order` int(11) DEFAULT 0 COMMENT '排序',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_dept_code` (`dept_code`),
  KEY `idx_parent_id` (`parent_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='部门表';

-- ----------------------------
-- 2. user 用户表
-- 说明：系统登录账号，同时作为所有业务的操作人/审批人
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '用户ID',
  `username` varchar(50) NOT NULL COMMENT '登录账号',
  `password` varchar(100) NOT NULL COMMENT '密码',
  `real_name` varchar(50) DEFAULT NULL COMMENT '真实姓名',
  `dept_id` int(11) DEFAULT NULL COMMENT '所属部门ID',
  `role` varchar(20) NOT NULL DEFAULT 'user' COMMENT '角色：admin-管理员，asset-资产管理员，user-普通用户',
  `phone` varchar(20) DEFAULT NULL COMMENT '联系电话',
  `status` tinyint(4) NOT NULL DEFAULT 1 COMMENT '状态：1-正常，0-禁用',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_username` (`username`),
  KEY `idx_dept_id` (`dept_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='用户表';

-- ----------------------------
-- 3. asset_category 资产分类表
-- ----------------------------
DROP TABLE IF EXISTS `asset_category`;
CREATE TABLE `asset_category` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '分类ID',
  `parent_id` int(11) NOT NULL DEFAULT 0 COMMENT '父分类ID，0为一级分类',
  `category_name` varchar(50) NOT NULL COMMENT '分类名称',
  `category_code` varchar(20) DEFAULT NULL COMMENT '分类编码',
  `category_level` tinyint(4) NOT NULL DEFAULT 1 COMMENT '层级：1-一级，2-二级，3-三级',
  `depreciable_life` int(11) DEFAULT 36 COMMENT '默认折旧年限（月）',
  `sort_order` int(11) DEFAULT 0 COMMENT '排序',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_parent_id` (`parent_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='资产分类表';

-- ----------------------------
-- 4. supplier 供应商表
-- ----------------------------
DROP TABLE IF EXISTS `supplier`;
CREATE TABLE `supplier` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '供应商ID',
  `supplier_name` varchar(100) NOT NULL COMMENT '供应商名称',
  `contact_person` varchar(50) DEFAULT NULL COMMENT '联系人',
  `phone` varchar(20) DEFAULT NULL COMMENT '联系电话',
  `address` varchar(200) DEFAULT NULL COMMENT '地址',
  `status` tinyint(4) NOT NULL DEFAULT 1 COMMENT '状态：1-合作中，0-终止',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_status` (`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='供应商表';

-- ----------------------------
-- 5. asset 资产主表 ★核心
-- 说明：一物一码，状态驱动全生命周期
-- ----------------------------
DROP TABLE IF EXISTS `asset`;
CREATE TABLE `asset` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '资产ID',
  `asset_code` varchar(50) NOT NULL COMMENT '资产编码（唯一）',
  `asset_name` varchar(100) NOT NULL COMMENT '资产名称',
  `category_id` int(11) NOT NULL COMMENT '分类ID',
  `brand` varchar(50) DEFAULT NULL COMMENT '品牌',
  `model` varchar(100) DEFAULT NULL COMMENT '型号',
  `sn_code` varchar(100) DEFAULT NULL COMMENT '序列号',
  `rfid_tag` varchar(50) DEFAULT NULL COMMENT 'RFID标签号（前瞻预留）',
  `barcode` varchar(50) DEFAULT NULL COMMENT '条形码',
  `purchase_date` date DEFAULT NULL COMMENT '采购日期',
  `purchase_price` decimal(10,2) DEFAULT '0.00' COMMENT '采购价格',
  `current_value` decimal(10,2) DEFAULT '0.00' COMMENT '当前净值（折旧后）',
  `supplier_id` int(11) DEFAULT NULL COMMENT '供应商ID',
  `warranty_expiry` date DEFAULT NULL COMMENT '质保到期日',
  `status` tinyint(4) NOT NULL DEFAULT 1 COMMENT '状态：1-在库，2-部门在用，3-维修中，4-报废，5-调拨中',
  `department_id` int(11) DEFAULT NULL COMMENT '当前所属部门ID',
  `location` varchar(100) DEFAULT NULL COMMENT '存放位置',
  `depreciable_months` int(11) DEFAULT 36 COMMENT '折旧总月数',
  `depreciated_months` int(11) DEFAULT 0 COMMENT '已折旧月数',
  `depreciable_start_date` date DEFAULT NULL COMMENT '折旧开始日期',
  `remark` varchar(500) DEFAULT NULL COMMENT '备注',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP,
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_asset_code` (`asset_code`),
  UNIQUE KEY `uk_rfid` (`rfid_tag`),
  KEY `idx_category` (`category_id`),
  KEY `idx_status` (`status`),
  KEY `idx_dept` (`department_id`),
  KEY `idx_supplier` (`supplier_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='资产主表';

-- ----------------------------
-- 6. asset_purchase 采购单主表
-- ----------------------------
DROP TABLE IF EXISTS `asset_purchase`;
CREATE TABLE `asset_purchase` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '采购单ID',
  `purchase_no` varchar(50) NOT NULL COMMENT '采购单号',
  `supplier_id` int(11) DEFAULT NULL COMMENT '供应商ID',
  `purchase_date` date DEFAULT NULL COMMENT '采购日期',
  `total_amount` decimal(12,2) DEFAULT '0.00' COMMENT '采购总金额',
  `invoice_no` varchar(50) DEFAULT NULL COMMENT '发票号',
  `status` tinyint(4) NOT NULL DEFAULT 1 COMMENT '状态：1-待入库，2-部分入库，3-已入库',
  `remark` varchar(500) DEFAULT NULL,
  `create_by` int(11) DEFAULT NULL COMMENT '创建人（用户ID）',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP,
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_purchase_no` (`purchase_no`),
  KEY `idx_supplier` (`supplier_id`),
  KEY `idx_status` (`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='采购单主表';

-- ----------------------------
-- 7. asset_purchase_item 采购明细表
-- ----------------------------
DROP TABLE IF EXISTS `asset_purchase_item`;
CREATE TABLE `asset_purchase_item` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '明细ID',
  `purchase_id` int(11) NOT NULL COMMENT '采购单ID',
  `category_id` int(11) DEFAULT NULL COMMENT '资产分类ID',
  `asset_name` varchar(100) NOT NULL COMMENT '资产名称',
  `brand` varchar(50) DEFAULT NULL COMMENT '品牌',
  `model` varchar(100) DEFAULT NULL COMMENT '型号',
  `quantity` int(11) NOT NULL DEFAULT 1 COMMENT '数量',
  `unit_price` decimal(10,2) DEFAULT '0.00' COMMENT '单价',
  `total_price` decimal(12,2) DEFAULT '0.00' COMMENT '小计',
  `received_qty` int(11) NOT NULL DEFAULT 0 COMMENT '已入库数量',
  `warranty_months` int(11) DEFAULT 12 COMMENT '质保月数',
  `status` tinyint(4) NOT NULL DEFAULT 1 COMMENT '状态：1-待入库，2-已入库',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_purchase_id` (`purchase_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='采购明细表';

-- ----------------------------
-- 8. asset_use_record 领用/归还/调拨记录表
-- 说明：统一记录资产在部门间的流转，调拨审批简化内嵌
-- ----------------------------
DROP TABLE IF EXISTS `asset_use_record`;
CREATE TABLE `asset_use_record` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '记录ID',
  `asset_id` int(11) NOT NULL COMMENT '资产ID',
  `operation_type` tinyint(4) NOT NULL COMMENT '操作类型：1-领用，2-归还，3-调拨',
  `from_dept_id` int(11) DEFAULT NULL COMMENT '原部门ID（在库时为NULL）',
  `to_dept_id` int(11) NOT NULL COMMENT '目标部门ID',
  `use_date` date NOT NULL COMMENT '操作日期',
  `expected_return_date` date DEFAULT NULL COMMENT '预计归还日期',
  `actual_return_date` date DEFAULT NULL COMMENT '实际归还日期',
  `return_status` tinyint(4) DEFAULT 0 COMMENT '归还状态：0-未归还，1-正常归还，2-逾期归还，3-损坏归还',
  `approval_status` tinyint(4) DEFAULT 0 COMMENT '审批状态（调拨时启用）：0-无需审批，1-审批中，2-已通过，3-驳回',
  `purpose` varchar(200) DEFAULT NULL COMMENT '用途/原因',
  `operator_id` int(11) DEFAULT NULL COMMENT '操作人（用户ID）',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_asset_id` (`asset_id`),
  KEY `idx_operation_type` (`operation_type`),
  KEY `idx_to_dept` (`to_dept_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='领用归还调拨记录表';

-- ----------------------------
-- 9. asset_repair 维修记录表
-- ----------------------------
DROP TABLE IF EXISTS `asset_repair`;
CREATE TABLE `asset_repair` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '记录ID',
  `asset_id` int(11) NOT NULL COMMENT '资产ID',
  `repair_no` varchar(50) DEFAULT NULL COMMENT '维修单号',
  `fault_desc` varchar(500) NOT NULL COMMENT '故障描述',
  `fault_type` tinyint(4) DEFAULT 1 COMMENT '故障类型：1-硬件故障，2-软件故障，3-人为损坏，4-其他',
  `report_dept_id` int(11) DEFAULT NULL COMMENT '报修部门ID',
  `repair_status` tinyint(4) NOT NULL DEFAULT 1 COMMENT '维修状态：1-待维修，2-维修中，3-已完成，4-无法修复',
  `repair_method` tinyint(4) DEFAULT NULL COMMENT '维修方式：1-自行维修，2-厂商保修，3-第三方维修',
  `repair_cost` decimal(10,2) DEFAULT '0.00' COMMENT '维修费用',
  `repair_result` varchar(500) DEFAULT NULL COMMENT '维修结果',
  `start_date` date DEFAULT NULL COMMENT '开始日期',
  `finish_date` date DEFAULT NULL COMMENT '完成日期',
  `operator_id` int(11) DEFAULT NULL COMMENT '登记人（用户ID）',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP,
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_repair_no` (`repair_no`),
  KEY `idx_asset_id` (`asset_id`),
  KEY `idx_repair_status` (`repair_status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='维修记录表';

-- ----------------------------
-- 10. asset_scrap 报废记录表
-- ----------------------------
DROP TABLE IF EXISTS `asset_scrap`;
CREATE TABLE `asset_scrap` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '记录ID',
  `asset_id` int(11) NOT NULL COMMENT '资产ID',
  `scrap_no` varchar(50) DEFAULT NULL COMMENT '报废单号',
  `scrap_reason` varchar(500) NOT NULL COMMENT '报废原因',
  `scrap_type` tinyint(4) DEFAULT 1 COMMENT '报废类型：1-达到年限，2-技术淘汰，3-无法修复，4-其他',
  `original_value` decimal(10,2) DEFAULT '0.00' COMMENT '资产原值',
  `scrap_value` decimal(10,2) DEFAULT '0.00' COMMENT '残值',
  `status` tinyint(4) NOT NULL DEFAULT 1 COMMENT '状态：1-待审批，2-已通过，3-已执行，4-驳回',
  `executor_id` int(11) DEFAULT NULL COMMENT '执行人（用户ID）',
  `execute_date` date DEFAULT NULL COMMENT '执行日期',
  `dispose_method` tinyint(4) DEFAULT NULL COMMENT '处置方式：1-回收，2-捐赠，3-出售，4-环保处理',
  `create_by` int(11) DEFAULT NULL COMMENT '申请人（用户ID）',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP,
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_scrap_no` (`scrap_no`),
  KEY `idx_asset_id` (`asset_id`),
  KEY `idx_status` (`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='报废记录表';

-- ----------------------------
-- 11. asset_inventory 盘点任务表
-- ----------------------------
DROP TABLE IF EXISTS `asset_inventory`;
CREATE TABLE `asset_inventory` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '任务ID',
  `inventory_no` varchar(50) DEFAULT NULL COMMENT '盘点单号',
  `inventory_name` varchar(100) NOT NULL COMMENT '盘点任务名称',
  `inventory_type` tinyint(4) NOT NULL DEFAULT 1 COMMENT '盘点类型：1-全面盘点，2-按部门，3-按分类',
  `scope_ids` varchar(200) DEFAULT NULL COMMENT '盘点范围ID（逗号分隔，如部门ID列表）',
  `plan_date` date DEFAULT NULL COMMENT '计划日期',
  `start_date` date DEFAULT NULL COMMENT '实际开始日期',
  `end_date` date DEFAULT NULL COMMENT '实际结束日期',
  `status` tinyint(4) NOT NULL DEFAULT 1 COMMENT '状态：1-待盘点，2-盘点中，3-已完成',
  `result_status` tinyint(4) DEFAULT 0 COMMENT '结果：0-未出结果，1-正常，2-存在异常',
  `inventory_method` tinyint(4) NOT NULL DEFAULT 1 COMMENT '盘点方式：1-人工扫码，2-RFID批量',
  `operator_id` int(11) DEFAULT NULL COMMENT '负责人（用户ID）',
  `remark` varchar(200) DEFAULT NULL,
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_inventory_no` (`inventory_no`),
  KEY `idx_status` (`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='盘点任务表';

-- ----------------------------
-- 12. asset_inventory_detail 盘点明细表
-- ----------------------------
DROP TABLE IF EXISTS `asset_inventory_detail`;
CREATE TABLE `asset_inventory_detail` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '明细ID',
  `inventory_id` int(11) NOT NULL COMMENT '盘点任务ID',
  `asset_id` int(11) NOT NULL COMMENT '资产ID',
  `book_status` tinyint(4) DEFAULT NULL COMMENT '账面状态（盘点前快照）',
  `book_dept_id` int(11) DEFAULT NULL COMMENT '账面部门ID',
  `book_location` varchar(100) DEFAULT NULL COMMENT '账面位置',
  `actual_status` tinyint(4) DEFAULT NULL COMMENT '实际状态：1-正常，2-盘亏，3-盘盈，4-损坏，5-位置变更',
  `actual_dept_id` int(11) DEFAULT NULL COMMENT '实际部门ID',
  `actual_location` varchar(100) DEFAULT NULL COMMENT '实际位置',
  `rfid_scanned` tinyint(4) NOT NULL DEFAULT 0 COMMENT '是否RFID扫描：0-否，1-是',
  `checker_id` int(11) DEFAULT NULL COMMENT '盘点人（用户ID）',
  `remark` varchar(200) DEFAULT NULL COMMENT '异常说明',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_inventory_id` (`inventory_id`),
  KEY `idx_asset_id` (`asset_id`),
  KEY `idx_actual_status` (`actual_status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='盘点明细表';

-- ----------------------------
-- 13. asset_depreciation 折旧记录表
-- 说明：按月记录折旧明细，支撑财务对账
-- ----------------------------
DROP TABLE IF EXISTS `asset_depreciation`;
CREATE TABLE `asset_depreciation` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '记录ID',
  `asset_id` int(11) NOT NULL COMMENT '资产ID',
  `depreciation_date` date NOT NULL COMMENT '折旧所属月份',
  `original_value` decimal(10,2) DEFAULT '0.00' COMMENT '资产原值',
  `depreciation_amount` decimal(10,2) DEFAULT '0.00' COMMENT '本月折旧额',
  `accumulated_depreciation` decimal(10,2) DEFAULT '0.00' COMMENT '累计折旧',
  `net_value` decimal(10,2) DEFAULT '0.00' COMMENT '折旧后净值',
  `remaining_months` int(11) DEFAULT NULL COMMENT '剩余折旧月数',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_asset_id` (`asset_id`),
  KEY `idx_depreciation_date` (`depreciation_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='资产折旧记录表';

-- ----------------------------
-- 14. asset_rfid_tag RFID标签表
-- 说明：物联网概念，记录标签与资产绑定关系
-- ----------------------------
DROP TABLE IF EXISTS `asset_rfid_tag`;
CREATE TABLE `asset_rfid_tag` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '标签ID',
  `tag_code` varchar(50) NOT NULL COMMENT 'RFID标签唯一编码（EPC）',
  `asset_id` int(11) DEFAULT NULL COMMENT '绑定资产ID（未绑定为NULL）',
  `tag_status` tinyint(4) NOT NULL DEFAULT 1 COMMENT '标签状态：1-正常，2-损坏，3-未绑定',
  `bind_time` datetime DEFAULT NULL COMMENT '绑定时间',
  `last_scan_time` datetime DEFAULT NULL COMMENT '最后扫描时间',
  `last_scan_location` varchar(100) DEFAULT NULL COMMENT '最后扫描位置',
  `scan_count` int(11) NOT NULL DEFAULT 0 COMMENT '累计扫描次数',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP,
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_tag_code` (`tag_code`),
  KEY `idx_asset_id` (`asset_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='RFID标签表';

-- ============================================================
-- 初始化数据
-- ============================================================

-- 部门
INSERT INTO `department` (`id`, `parent_id`, `dept_name`, `dept_code`, `sort_order`) VALUES
(1, 0, '集团总部', 'GROUP', 0),
(2, 1, '行政部', 'XZ', 1),
(3, 1, '财务部', 'CW', 2),
(4, 1, '技术部', 'JS', 3),
(5, 1, '人事部', 'RS', 4),
(6, 1, 'IT运维部', 'IT', 5);

-- 用户（密码：123456，MD5: e10adc3949ba59abbe56e057f20f883e）
INSERT INTO `user` (`id`, `username`, `password`, `real_name`, `dept_id`, `role`) VALUES
(1, 'admin', 'e10adc3949ba59abbe56e057f20f883e', '系统管理员', 1, 'admin'),
(2, 'asset', 'e10adc3949ba59abbe56e057f20f883e', '资产管理员', 6, 'asset');

-- 资产分类
INSERT INTO `asset_category` (`id`, `parent_id`, `category_name`, `category_code`, `category_level`, `depreciable_life`, `sort_order`) VALUES
(1, 0, '电子设备', 'DZ', 1, 36, 1),
(2, 0, '办公家具', 'BG', 1, 60, 2),
(3, 1, '计算机设备', 'JSJ', 2, 36, 1),
(4, 1, '网络设备', 'WL', 2, 36, 2),
(5, 2, '桌椅', 'ZY', 2, 60, 1),
(6, 3, '笔记本电脑', 'NB', 3, 36, 1),
(7, 3, '台式电脑', 'PC', 3, 36, 2);

-- 供应商
INSERT INTO `supplier` (`id`, `supplier_name`, `contact_person`, `phone`, `status`) VALUES
(1, '联想科技有限公司', '张经理', '13800138000', 1),
(2, '华为终端有限公司', '李经理', '13900139000', 1);

SET FOREIGN_KEY_CHECKS = 1;