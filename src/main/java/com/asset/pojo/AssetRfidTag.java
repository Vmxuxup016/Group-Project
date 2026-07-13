package com.asset.pojo;

public class AssetRfidTag {

    //标签ID（主键，自增）
    private Integer id;

    //RFID标签唯一编码（EPC：电子产品代码）
    private String tagCode;

    //绑定资产ID（关联 asset 表，未绑定时为NULL）
    private Integer assetId;

    //标签状态：1-正常，2-损坏，3-未绑定
    private Integer tagStatus;

    //绑定时间（标签与资产绑定的时间）
    private String bindTime;

    //最后扫描时间
    private String lastScanTime;

    //最后扫描位置
    private String lastScanLocation;

    //累计扫描次数
    private Integer scanCount;

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
    public String getTagCode() { return tagCode; }
    public void setTagCode(String tagCode) { this.tagCode = tagCode; }
    public Integer getAssetId() { return assetId; }
    public void setAssetId(Integer assetId) { this.assetId = assetId; }
    public Integer getTagStatus() { return tagStatus; }
    public void setTagStatus(Integer tagStatus) { this.tagStatus = tagStatus; }
    public String getBindTime() { return bindTime; }
    public void setBindTime(String bindTime) { this.bindTime = bindTime; }
    public String getLastScanTime() { return lastScanTime; }
    public void setLastScanTime(String lastScanTime) { this.lastScanTime = lastScanTime; }
    public String getLastScanLocation() { return lastScanLocation; }
    public void setLastScanLocation(String lastScanLocation) { this.lastScanLocation = lastScanLocation; }
    public Integer getScanCount() { return scanCount; }
    public void setScanCount(Integer scanCount) { this.scanCount = scanCount; }
    public String getCreateTime() { return createTime; }
    public void setCreateTime(String createTime) { this.createTime = createTime; }
    public String getUpdateTime() { return updateTime; }
    public void setUpdateTime(String updateTime) { this.updateTime = updateTime; }
    public String getAssetCode() { return assetCode; }
    public void setAssetCode(String assetCode) { this.assetCode = assetCode; }
    public String getAssetName() { return assetName; }
    public void setAssetName(String assetName) { this.assetName = assetName; }
}
