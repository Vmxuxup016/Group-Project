package com.asset.pojo;

public class AssetInventoryDetail {

    //明细ID（主键，自增）
    private Integer id;

    //盘点任务ID（关联 asset_inventory 表）
    private Integer inventoryId;

    //资产ID（关联 asset 表）
    private Integer assetId;

    //账面状态（盘点前的资产状态快照）
    private Integer bookStatus;

    //账面部门ID（盘点前的所属部门快照）
    private Integer bookDeptId;

    //账面位置（盘点前的存放位置快照）
    private String bookLocation;

    //实际状态：1-正常，2-盘亏，3-盘盈，4-损坏，5-位置变更
    private Integer actualStatus;

    //实际部门ID
    private Integer actualDeptId;

    //实际位置
    private String actualLocation;

    //是否RFID扫描：0-否，1-是
    private Integer rfidScanned;

    //盘点人（用户ID，关联 user 表）
    private Integer checkerId;

    //异常说明（盘点结果异常时的备注）
    private String remark;

    //创建时间
    private String createTime;

    // ============ 关联字段（非数据库字段，仅用于前端展示） ============

    //资产编码（关联查询 asset 表）
    private String assetCode;

    //资产名称（关联查询 asset 表）
    private String assetName;

    public Integer getId() { return id; }
    public void setId(Integer id) { this.id = id; }
    public Integer getInventoryId() { return inventoryId; }
    public void setInventoryId(Integer inventoryId) { this.inventoryId = inventoryId; }
    public Integer getAssetId() { return assetId; }
    public void setAssetId(Integer assetId) { this.assetId = assetId; }
    public Integer getBookStatus() { return bookStatus; }
    public void setBookStatus(Integer bookStatus) { this.bookStatus = bookStatus; }
    public Integer getBookDeptId() { return bookDeptId; }
    public void setBookDeptId(Integer bookDeptId) { this.bookDeptId = bookDeptId; }
    public String getBookLocation() { return bookLocation; }
    public void setBookLocation(String bookLocation) { this.bookLocation = bookLocation; }
    public Integer getActualStatus() { return actualStatus; }
    public void setActualStatus(Integer actualStatus) { this.actualStatus = actualStatus; }
    public Integer getActualDeptId() { return actualDeptId; }
    public void setActualDeptId(Integer actualDeptId) { this.actualDeptId = actualDeptId; }
    public String getActualLocation() { return actualLocation; }
    public void setActualLocation(String actualLocation) { this.actualLocation = actualLocation; }
    public Integer getRfidScanned() { return rfidScanned; }
    public void setRfidScanned(Integer rfidScanned) { this.rfidScanned = rfidScanned; }
    public Integer getCheckerId() { return checkerId; }
    public void setCheckerId(Integer checkerId) { this.checkerId = checkerId; }
    public String getRemark() { return remark; }
    public void setRemark(String remark) { this.remark = remark; }
    public String getCreateTime() { return createTime; }
    public void setCreateTime(String createTime) { this.createTime = createTime; }
    public String getAssetCode() { return assetCode; }
    public void setAssetCode(String assetCode) { this.assetCode = assetCode; }
    public String getAssetName() { return assetName; }
    public void setAssetName(String assetName) { this.assetName = assetName; }
}
