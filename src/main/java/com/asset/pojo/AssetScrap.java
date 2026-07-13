package com.asset.pojo;

import java.math.BigDecimal;

public class AssetScrap {

    //记录ID（主键，自增）
    private Integer id;

    //资产ID（关联 asset 表）
    private Integer assetId;

    //报废单号（唯一）
    private String scrapNo;

    //报废原因
    private String scrapReason;

    //报废类型：1-达到年限，2-技术淘汰，3-无法修复，4-其他
    private Integer scrapType;

    //资产原值
    private BigDecimal originalValue;

    //残值（报废后可回收的剩余价值）
    private BigDecimal scrapValue;

    //状态：1-待审批，2-已通过，3-已执行，4-驳回
    private Integer status;

    //执行人（用户ID，关联 user 表）
    private Integer executorId;

    //执行日期
    private String executeDate;

    //处置方式：1-回收，2-捐赠，3-出售，4-环保处理
    private Integer disposeMethod;

    //申请人（用户ID，关联 user 表）
    private Integer createBy;

    //创建时间
    private String createTime;

    //更新时间（每次修改自动更新）
    private String updateTime;

    // ============ 关联字段（非数据库字段，仅用于前端展示） ============

    //资产编码（关联查询 asset 表）
    private String assetCode;

    //资产名称（关联查询 asset 表）
    private String assetName;

    public Integer getId() { return id; }
    public void setId(Integer id) { this.id = id; }
    public Integer getAssetId() { return assetId; }
    public void setAssetId(Integer assetId) { this.assetId = assetId; }
    public String getScrapNo() { return scrapNo; }
    public void setScrapNo(String scrapNo) { this.scrapNo = scrapNo; }
    public String getScrapReason() { return scrapReason; }
    public void setScrapReason(String scrapReason) { this.scrapReason = scrapReason; }
    public Integer getScrapType() { return scrapType; }
    public void setScrapType(Integer scrapType) { this.scrapType = scrapType; }
    public BigDecimal getOriginalValue() { return originalValue; }
    public void setOriginalValue(BigDecimal originalValue) { this.originalValue = originalValue; }
    public BigDecimal getScrapValue() { return scrapValue; }
    public void setScrapValue(BigDecimal scrapValue) { this.scrapValue = scrapValue; }
    public Integer getStatus() { return status; }
    public void setStatus(Integer status) { this.status = status; }
    public Integer getExecutorId() { return executorId; }
    public void setExecutorId(Integer executorId) { this.executorId = executorId; }
    public String getExecuteDate() { return executeDate; }
    public void setExecuteDate(String executeDate) { this.executeDate = executeDate; }
    public Integer getDisposeMethod() { return disposeMethod; }
    public void setDisposeMethod(Integer disposeMethod) { this.disposeMethod = disposeMethod; }
    public Integer getCreateBy() { return createBy; }
    public void setCreateBy(Integer createBy) { this.createBy = createBy; }
    public String getCreateTime() { return createTime; }
    public void setCreateTime(String createTime) { this.createTime = createTime; }
    public String getUpdateTime() { return updateTime; }
    public void setUpdateTime(String updateTime) { this.updateTime = updateTime; }
    public String getAssetCode() { return assetCode; }
    public void setAssetCode(String assetCode) { this.assetCode = assetCode; }
    public String getAssetName() { return assetName; }
    public void setAssetName(String assetName) { this.assetName = assetName; }
}
