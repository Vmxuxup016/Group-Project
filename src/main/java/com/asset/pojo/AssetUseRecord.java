package com.asset.pojo;

public class AssetUseRecord {

    //记录ID（主键，自增）
    private Integer id;

    //资产ID（关联 asset 表）
    private Integer assetId;

    //操作类型：1-领用，2-归还，3-调拨
    private Integer operationType;

    //原部门ID（领用时为NULL表示在库出库）
    private Integer fromDeptId;

    //目标部门ID
    private Integer toDeptId;

    //操作日期
    private String useDate;

    //预计归还日期（仅领用操作填写）
    private String expectedReturnDate;

    //实际归还日期
    private String actualReturnDate;

    //归还状态：0-未归还，1-正常归还，2-逾期归还，3-损坏归还
    private Integer returnStatus;

    //审批状态（调拨时启用）：0-无需审批，1-审批中，2-已通过，3-驳回
    private Integer approvalStatus;

    //用途/原因
    private String purpose;

    //操作人（用户ID，关联 user 表）
    private Integer operatorId;

    //创建时间
    private String createTime;

    // ============ 关联字段（非数据库字段，仅用于前端展示） ============

    //资产编码（关联查询 asset 表）
    private String assetCode;

    //资产名称（关联查询 asset 表）
    private String assetName;

    //原部门名称（关联查询 department 表）
    private String fromDeptName;

    //目标部门名称（关联查询 department 表）
    private String toDeptName;

    //操作人姓名（关联查询 user 表）
    private String operatorName;

    public Integer getId() { return id; }
    public void setId(Integer id) { this.id = id; }
    public Integer getAssetId() { return assetId; }
    public void setAssetId(Integer assetId) { this.assetId = assetId; }
    public Integer getOperationType() { return operationType; }
    public void setOperationType(Integer operationType) { this.operationType = operationType; }
    public Integer getFromDeptId() { return fromDeptId; }
    public void setFromDeptId(Integer fromDeptId) { this.fromDeptId = fromDeptId; }
    public Integer getToDeptId() { return toDeptId; }
    public void setToDeptId(Integer toDeptId) { this.toDeptId = toDeptId; }
    public String getUseDate() { return useDate; }
    public void setUseDate(String useDate) { this.useDate = useDate; }
    public String getExpectedReturnDate() { return expectedReturnDate; }
    public void setExpectedReturnDate(String expectedReturnDate) { this.expectedReturnDate = expectedReturnDate; }
    public String getActualReturnDate() { return actualReturnDate; }
    public void setActualReturnDate(String actualReturnDate) { this.actualReturnDate = actualReturnDate; }
    public Integer getReturnStatus() { return returnStatus; }
    public void setReturnStatus(Integer returnStatus) { this.returnStatus = returnStatus; }
    public Integer getApprovalStatus() { return approvalStatus; }
    public void setApprovalStatus(Integer approvalStatus) { this.approvalStatus = approvalStatus; }
    public String getPurpose() { return purpose; }
    public void setPurpose(String purpose) { this.purpose = purpose; }
    public Integer getOperatorId() { return operatorId; }
    public void setOperatorId(Integer operatorId) { this.operatorId = operatorId; }
    public String getCreateTime() { return createTime; }
    public void setCreateTime(String createTime) { this.createTime = createTime; }
    public String getAssetCode() { return assetCode; }
    public void setAssetCode(String assetCode) { this.assetCode = assetCode; }
    public String getAssetName() { return assetName; }
    public void setAssetName(String assetName) { this.assetName = assetName; }
    public String getFromDeptName() { return fromDeptName; }
    public void setFromDeptName(String fromDeptName) { this.fromDeptName = fromDeptName; }
    public String getToDeptName() { return toDeptName; }
    public void setToDeptName(String toDeptName) { this.toDeptName = toDeptName; }
    public String getOperatorName() { return operatorName; }
    public void setOperatorName(String operatorName) { this.operatorName = operatorName; }
}
