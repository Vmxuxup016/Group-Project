package com.asset.pojo;

import java.math.BigDecimal;

public class AssetPurchase {

    //采购单ID（主键，自增）
    private Integer id;

    //采购单号（唯一）
    private String purchaseNo;

    //供应商ID（关联 supplier 表）
    private Integer supplierId;

    //采购日期
    private String purchaseDate;

    //采购总金额
    private BigDecimal totalAmount;

    //发票号
    private String invoiceNo;

    //状态：1-待入库，2-部分入库，3-已入库
    private Integer status;

    //备注
    private String remark;

    //创建人（用户ID，关联 user 表）
    private Integer createBy;

    //创建时间
    private String createTime;

    //更新时间（每次修改自动更新）
    private String updateTime;

    // ============ 关联字段（非数据库字段，仅用于前端展示） ============

    //供应商名称（关联查询 supplier 表）
    private String supplierName;

    public Integer getId() { return id; }
    public void setId(Integer id) { this.id = id; }
    public String getPurchaseNo() { return purchaseNo; }
    public void setPurchaseNo(String purchaseNo) { this.purchaseNo = purchaseNo; }
    public Integer getSupplierId() { return supplierId; }
    public void setSupplierId(Integer supplierId) { this.supplierId = supplierId; }
    public String getPurchaseDate() { return purchaseDate; }
    public void setPurchaseDate(String purchaseDate) { this.purchaseDate = purchaseDate; }
    public BigDecimal getTotalAmount() { return totalAmount; }
    public void setTotalAmount(BigDecimal totalAmount) { this.totalAmount = totalAmount; }
    public String getInvoiceNo() { return invoiceNo; }
    public void setInvoiceNo(String invoiceNo) { this.invoiceNo = invoiceNo; }
    public Integer getStatus() { return status; }
    public void setStatus(Integer status) { this.status = status; }
    public String getRemark() { return remark; }
    public void setRemark(String remark) { this.remark = remark; }
    public Integer getCreateBy() { return createBy; }
    public void setCreateBy(Integer createBy) { this.createBy = createBy; }
    public String getCreateTime() { return createTime; }
    public void setCreateTime(String createTime) { this.createTime = createTime; }
    public String getUpdateTime() { return updateTime; }
    public void setUpdateTime(String updateTime) { this.updateTime = updateTime; }
    public String getSupplierName() { return supplierName; }
    public void setSupplierName(String supplierName) { this.supplierName = supplierName; }
}
