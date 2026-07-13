package com.asset.pojo;

import java.math.BigDecimal;

public class AssetRepair {

    //记录ID（主键，自增）
    private Integer id;

    //资产ID（关联 asset 表）
    private Integer assetId;

    //维修单号（唯一）
    private String repairNo;

    //故障描述
    private String faultDesc;

    //故障类型：1-硬件故障，2-软件故障，3-人为损坏，4-其他
    private Integer faultType;

    //报修部门ID（关联 department 表）
    private Integer reportDeptId;

    //维修状态：1-待维修，2-维修中，3-已完成，4-无法修复
    private Integer repairStatus;

    //维修方式：1-自行维修，2-厂商保修，3-第三方维修
    private Integer repairMethod;

    //维修费用
    private BigDecimal repairCost;

    //维修结果（记录维修完成后的详细说明）
    private String repairResult;

    //开始日期
    private String startDate;

    //完成日期
    private String finishDate;

    //登记人（用户ID，关联 user 表）
    private Integer operatorId;

    //创建时间
    private String createTime;

    //更新时间（每次修改自动更新）
    private String updateTime;

    // ============ 关联字段（非数据库字段，仅用于前端展示） ============

    //资产编码（关联查询 asset 表）
    private String assetCode;

    //资产名称（关联查询 asset 表）
    private String assetName;

    //部门名称（关联查询 department 表）
    private String deptName;

    public Integer getId() { return id; }
    public void setId(Integer id) { this.id = id; }
    public Integer getAssetId() { return assetId; }
    public void setAssetId(Integer assetId) { this.assetId = assetId; }
    public String getRepairNo() { return repairNo; }
    public void setRepairNo(String repairNo) { this.repairNo = repairNo; }
    public String getFaultDesc() { return faultDesc; }
    public void setFaultDesc(String faultDesc) { this.faultDesc = faultDesc; }
    public Integer getFaultType() { return faultType; }
    public void setFaultType(Integer faultType) { this.faultType = faultType; }
    public Integer getReportDeptId() { return reportDeptId; }
    public void setReportDeptId(Integer reportDeptId) { this.reportDeptId = reportDeptId; }
    public Integer getRepairStatus() { return repairStatus; }
    public void setRepairStatus(Integer repairStatus) { this.repairStatus = repairStatus; }
    public Integer getRepairMethod() { return repairMethod; }
    public void setRepairMethod(Integer repairMethod) { this.repairMethod = repairMethod; }
    public BigDecimal getRepairCost() { return repairCost; }
    public void setRepairCost(BigDecimal repairCost) { this.repairCost = repairCost; }
    public String getRepairResult() { return repairResult; }
    public void setRepairResult(String repairResult) { this.repairResult = repairResult; }
    public String getStartDate() { return startDate; }
    public void setStartDate(String startDate) { this.startDate = startDate; }
    public String getFinishDate() { return finishDate; }
    public void setFinishDate(String finishDate) { this.finishDate = finishDate; }
    public Integer getOperatorId() { return operatorId; }
    public void setOperatorId(Integer operatorId) { this.operatorId = operatorId; }
    public String getCreateTime() { return createTime; }
    public void setCreateTime(String createTime) { this.createTime = createTime; }
    public String getUpdateTime() { return updateTime; }
    public void setUpdateTime(String updateTime) { this.updateTime = updateTime; }
    public String getAssetCode() { return assetCode; }
    public void setAssetCode(String assetCode) { this.assetCode = assetCode; }
    public String getAssetName() { return assetName; }
    public void setAssetName(String assetName) { this.assetName = assetName; }
    public String getDeptName() { return deptName; }
    public void setDeptName(String deptName) { this.deptName = deptName; }
}
