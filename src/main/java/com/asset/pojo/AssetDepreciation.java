package com.asset.pojo;

import java.math.BigDecimal;

public class AssetDepreciation {

    //记录ID（主键，自增）
    private Integer id;

    //资产ID（关联 asset 表）
    private Integer assetId;

    //折旧所属月份
    private String depreciationDate;

    //资产原值
    private BigDecimal originalValue;

    //本月折旧额
    private BigDecimal depreciationAmount;

    //累计折旧（截至本月的折旧总额）
    private BigDecimal accumulatedDepreciation;

    //折旧后净值（原值 - 累计折旧）
    private BigDecimal netValue;

    //剩余折旧月数
    private Integer remainingMonths;

    //创建时间
    private String createTime;

    // ============ 关联字段（非数据库字段，仅用于前端展示） ============

    //资产编码（关联查询 asset 表）
    private String assetCode;

    //资产名称（关联查询 asset 表）
    private String assetName;

    public Integer getId() { return id; }
    public void setId(Integer id) { this.id = id; }
    public Integer getAssetId() { return assetId; }
    public void setAssetId(Integer assetId) { this.assetId = assetId; }
    public String getDepreciationDate() { return depreciationDate; }
    public void setDepreciationDate(String depreciationDate) { this.depreciationDate = depreciationDate; }
    public BigDecimal getOriginalValue() { return originalValue; }
    public void setOriginalValue(BigDecimal originalValue) { this.originalValue = originalValue; }
    public BigDecimal getDepreciationAmount() { return depreciationAmount; }
    public void setDepreciationAmount(BigDecimal depreciationAmount) { this.depreciationAmount = depreciationAmount; }
    public BigDecimal getAccumulatedDepreciation() { return accumulatedDepreciation; }
    public void setAccumulatedDepreciation(BigDecimal accumulatedDepreciation) { this.accumulatedDepreciation = accumulatedDepreciation; }
    public BigDecimal getNetValue() { return netValue; }
    public void setNetValue(BigDecimal netValue) { this.netValue = netValue; }
    public Integer getRemainingMonths() { return remainingMonths; }
    public void setRemainingMonths(Integer remainingMonths) { this.remainingMonths = remainingMonths; }
    public String getCreateTime() { return createTime; }
    public void setCreateTime(String createTime) { this.createTime = createTime; }
    public String getAssetCode() { return assetCode; }
    public void setAssetCode(String assetCode) { this.assetCode = assetCode; }
    public String getAssetName() { return assetName; }
    public void setAssetName(String assetName) { this.assetName = assetName; }
}
