package com.asset.pojo;

public class Supplier {

    //供应商ID（主键，自增)
    private Integer id;

    //供应商名称
    private String supplierName;

    //联系人
    private String contactPerson;

    //联系电话
    private String phone;

    //地址
    private String address;

    //状态：1-合作中，0-终止
    private Integer status;

    //创建时间
    private String createTime;

    public Integer getId() { return id; }
    public void setId(Integer id) { this.id = id; }
    public String getSupplierName() { return supplierName; }
    public void setSupplierName(String supplierName) { this.supplierName = supplierName; }
    public String getContactPerson() { return contactPerson; }
    public void setContactPerson(String contactPerson) { this.contactPerson = contactPerson; }
    public String getPhone() { return phone; }
    public void setPhone(String phone) { this.phone = phone; }
    public String getAddress() { return address; }
    public void setAddress(String address) { this.address = address; }
    public Integer getStatus() { return status; }
    public void setStatus(Integer status) { this.status = status; }
    public String getCreateTime() { return createTime; }
    public void setCreateTime(String createTime) { this.createTime = createTime; }
}
