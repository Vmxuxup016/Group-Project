package com.asset.pojo;

public class AssetInventory {

    //任务ID（主键，自增）
    private Integer id;

    //盘点单号（唯一）
    private String inventoryNo;

    //盘点任务名称
    private String inventoryName;

    //盘点类型：1-全面盘点，2-按部门，3-按分类
    private Integer inventoryType;

    //盘点范围ID（逗号分隔，如按部门时为部门ID列表）
    private String scopeIds;

    //计划日期
    private String planDate;

    //实际开始日期
    private String startDate;

    //实际结束日期
    private String endDate;

    //状态：1-待盘点，2-盘点中，3-已完成
    private Integer status;

    //结果：0-未出结果，1-正常，2-存在异常
    private Integer resultStatus;

    //盘点方式：1-人工扫码，2-RFID批量
    private Integer inventoryMethod;

    //负责人（用户ID，关联 user 表）
    private Integer operatorId;

    //备注
    private String remark;

    //创建时间
    private String createTime;

    // ============ 关联字段（非数据库字段，仅用于前端展示） ============

    //负责人姓名（关联查询 user 表）
    private String operatorName;

    public Integer getId() { return id; }
    public void setId(Integer id) { this.id = id; }
    public String getInventoryNo() { return inventoryNo; }
    public void setInventoryNo(String inventoryNo) { this.inventoryNo = inventoryNo; }
    public String getInventoryName() { return inventoryName; }
    public void setInventoryName(String inventoryName) { this.inventoryName = inventoryName; }
    public Integer getInventoryType() { return inventoryType; }
    public void setInventoryType(Integer inventoryType) { this.inventoryType = inventoryType; }
    public String getScopeIds() { return scopeIds; }
    public void setScopeIds(String scopeIds) { this.scopeIds = scopeIds; }
    public String getPlanDate() { return planDate; }
    public void setPlanDate(String planDate) { this.planDate = planDate; }
    public String getStartDate() { return startDate; }
    public void setStartDate(String startDate) { this.startDate = startDate; }
    public String getEndDate() { return endDate; }
    public void setEndDate(String endDate) { this.endDate = endDate; }
    public Integer getStatus() { return status; }
    public void setStatus(Integer status) { this.status = status; }
    public Integer getResultStatus() { return resultStatus; }
    public void setResultStatus(Integer resultStatus) { this.resultStatus = resultStatus; }
    public Integer getInventoryMethod() { return inventoryMethod; }
    public void setInventoryMethod(Integer inventoryMethod) { this.inventoryMethod = inventoryMethod; }
    public Integer getOperatorId() { return operatorId; }
    public void setOperatorId(Integer operatorId) { this.operatorId = operatorId; }
    public String getRemark() { return remark; }
    public void setRemark(String remark) { this.remark = remark; }
    public String getCreateTime() { return createTime; }
    public void setCreateTime(String createTime) { this.createTime = createTime; }
    public String getOperatorName() { return operatorName; }
    public void setOperatorName(String operatorName) { this.operatorName = operatorName; }
}
