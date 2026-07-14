package com.asset.pojo;

import java.math.BigDecimal;

public class Asset {

    //资产ID（主键，自增）
    private Integer id;

    //资产编码（唯一，一物一码）
    private String assetCode;

    //资产名称
    private String assetName;

    //分类ID（关联 asset_category 表）
    private Integer categoryId;

    //品牌
    private String brand;

    //型号
    private String model;

    //序列号
    private String snCode;

    //RFID标签号（前瞻预留，关联 asset_rfid_tag 表）
    private String rfidTag;

    //条形码
    private String barcode;

    //采购日期
    private String purchaseDate;

    //采购价格
    private BigDecimal purchasePrice;

    //当前净值（折旧后价值）
    private BigDecimal currentValue;

    //供应商ID（关联 supplier 表）
    private Integer supplierId;

    //质保到期日
    private String warrantyExpiry;

    //资产状态：1-在库，2-部门在用，3-维修中，4-报废，5-调拨中
    private Integer status;

    //当前所属部门ID（关联 department 表）
    private Integer departmentId;

    //存放位置
    private String location;

    //折旧总月数（默认36个月）
    private Integer depreciableMonths;

    //已折旧月数
    private Integer depreciatedMonths;

    //折旧开始日期
    private String depreciableStartDate;

    //备注
    private String remark;

    //创建时间
    private String createTime;

    //更新时间（每次修改自动更新）
    private String updateTime;

    // ============ 关联字段（非数据库字段，仅用于前端展示） ============

    //分类名称（关联查询 asset_category 表）
    private String categoryName;

    //供应商名称（关联查询 supplier 表）
    private String supplierName;

    //部门名称（关联查询 department 表）
    private String deptName;

    //状态名称（状态码的中文描述）
    private String statusName;

    public Integer getId() { return id; }
    public void setId(Integer id) { this.id = id; }
    public String getAssetCode() { return assetCode; }
    public void setAssetCode(String assetCode) { this.assetCode = assetCode; }
    public String getAssetName() { return assetName; }
    public void setAssetName(String assetName) { this.assetName = assetName; }
    public Integer getCategoryId() { return categoryId; }
    public void setCategoryId(Integer categoryId) { this.categoryId = categoryId; }
    public String getBrand() { return brand; }
    public void setBrand(String brand) { this.brand = brand; }
    public String getModel() { return model; }
    public void setModel(String model) { this.model = model; }
    public String getSnCode() { return snCode; }
    public void setSnCode(String snCode) { this.snCode = snCode; }
    public String getRfidTag() { return rfidTag; }
    public void setRfidTag(String rfidTag) { this.rfidTag = rfidTag; }
    public String getBarcode() { return barcode; }
    public void setBarcode(String barcode) { this.barcode = barcode; }
    public String getPurchaseDate() { return purchaseDate; }
    public void setPurchaseDate(String purchaseDate) { this.purchaseDate = purchaseDate; }
    public BigDecimal getPurchasePrice() { return purchasePrice; }
    public void setPurchasePrice(BigDecimal purchasePrice) { this.purchasePrice = purchasePrice; }
    public BigDecimal getCurrentValue() { return currentValue; }
    public void setCurrentValue(BigDecimal currentValue) { this.currentValue = currentValue; }
    public Integer getSupplierId() { return supplierId; }
    public void setSupplierId(Integer supplierId) { this.supplierId = supplierId; }
    public String getWarrantyExpiry() { return warrantyExpiry; }
    public void setWarrantyExpiry(String warrantyExpiry) { this.warrantyExpiry = warrantyExpiry; }
    public Integer getStatus() { return status; }
    public void setStatus(Integer status) { this.status = status; }
    public Integer getDepartmentId() { return departmentId; }
    public void setDepartmentId(Integer departmentId) { this.departmentId = departmentId; }
    public String getLocation() { return location; }
    public void setLocation(String location) { this.location = location; }
    public Integer getDepreciableMonths() { return depreciableMonths; }
    public void setDepreciableMonths(Integer depreciableMonths) { this.depreciableMonths = depreciableMonths; }
    public Integer getDepreciatedMonths() { return depreciatedMonths; }
    public void setDepreciatedMonths(Integer depreciatedMonths) { this.depreciatedMonths = depreciatedMonths; }
    public String getDepreciableStartDate() { return depreciableStartDate; }
    public void setDepreciableStartDate(String depreciableStartDate) { this.depreciableStartDate = depreciableStartDate; }
    public String getRemark() { return remark; }
    public void setRemark(String remark) { this.remark = remark; }
    public String getCreateTime() { return createTime; }
    public void setCreateTime(String createTime) { this.createTime = createTime; }
    public String getUpdateTime() { return updateTime; }
    public void setUpdateTime(String updateTime) { this.updateTime = updateTime; }
    public String getCategoryName() { return categoryName; }
    public void setCategoryName(String categoryName) { this.categoryName = categoryName; }
    public String getSupplierName() { return supplierName; }
    public void setSupplierName(String supplierName) { this.supplierName = supplierName; }
    public String getDeptName() { return deptName; }
    public void setDeptName(String deptName) { this.deptName = deptName; }
    public String getStatusName() { return statusName; }
    public void setStatusName(String statusName) { this.statusName = statusName; }
}
