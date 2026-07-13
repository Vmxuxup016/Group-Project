package com.asset.pojo;

import java.math.BigDecimal;

public class AssetPurchaseItem {

    //明细ID（主键，自增）
    private Integer id;

    //采购单ID（关联 asset_purchase 表）
    private Integer purchaseId;

    //资产分类ID（关联 asset_category 表）
    private Integer categoryId;

    //资产名称
    private String assetName;

    //品牌
    private String brand;

    //型号
    private String model;

    //数量
    private Integer quantity;

    //单价
    private BigDecimal unitPrice;

    //小计（数量 x 单价）
    private BigDecimal totalPrice;

    //已入库数量（支持分批次入库）
    private Integer receivedQty;

    //质保月数（默认12个月）
    private Integer warrantyMonths;

    //状态：1-待入库，2-已入库
    private Integer status;

    //创建时间
    private String createTime;

    public Integer getId() { return id; }
    public void setId(Integer id) { this.id = id; }
    public Integer getPurchaseId() { return purchaseId; }
    public void setPurchaseId(Integer purchaseId) { this.purchaseId = purchaseId; }
    public Integer getCategoryId() { return categoryId; }
    public void setCategoryId(Integer categoryId) { this.categoryId = categoryId; }
    public String getAssetName() { return assetName; }
    public void setAssetName(String assetName) { this.assetName = assetName; }
    public String getBrand() { return brand; }
    public void setBrand(String brand) { this.brand = brand; }
    public String getModel() { return model; }
    public void setModel(String model) { this.model = model; }
    public Integer getQuantity() { return quantity; }
    public void setQuantity(Integer quantity) { this.quantity = quantity; }
    public BigDecimal getUnitPrice() { return unitPrice; }
    public void setUnitPrice(BigDecimal unitPrice) { this.unitPrice = unitPrice; }
    public BigDecimal getTotalPrice() { return totalPrice; }
    public void setTotalPrice(BigDecimal totalPrice) { this.totalPrice = totalPrice; }
    public Integer getReceivedQty() { return receivedQty; }
    public void setReceivedQty(Integer receivedQty) { this.receivedQty = receivedQty; }
    public Integer getWarrantyMonths() { return warrantyMonths; }
    public void setWarrantyMonths(Integer warrantyMonths) { this.warrantyMonths = warrantyMonths; }
    public Integer getStatus() { return status; }
    public void setStatus(Integer status) { this.status = status; }
    public String getCreateTime() { return createTime; }
    public void setCreateTime(String createTime) { this.createTime = createTime; }
}
