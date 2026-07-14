package com.asset.pojo;

public class AssetCategory {

    //分类ID（主键，自增）
    private Integer id;

    //父分类ID（0为一级分类，表示顶级节点）
    private Integer parentId;

    //分类名称
    private String categoryName;

    //分类编码
    private String categoryCode;

    //层级：1-一级，2-二级，3-三级
    private Integer categoryLevel;

    //默认折旧年限（月）
    private Integer depreciableLife;

    //排序（数值越小越靠前）
    private Integer sortOrder;

    //创建时间
    private String createTime;

    public Integer getId() { return id; }
    public void setId(Integer id) { this.id = id; }
    public Integer getParentId() { return parentId; }
    public void setParentId(Integer parentId) { this.parentId = parentId; }
    public String getCategoryName() { return categoryName; }
    public void setCategoryName(String categoryName) { this.categoryName = categoryName; }
    public String getCategoryCode() { return categoryCode; }
    public void setCategoryCode(String categoryCode) { this.categoryCode = categoryCode; }
    public Integer getCategoryLevel() { return categoryLevel; }
    public void setCategoryLevel(Integer categoryLevel) { this.categoryLevel = categoryLevel; }
    public Integer getDepreciableLife() { return depreciableLife; }
    public void setDepreciableLife(Integer depreciableLife) { this.depreciableLife = depreciableLife; }
    public Integer getSortOrder() { return sortOrder; }
    public void setSortOrder(Integer sortOrder) { this.sortOrder = sortOrder; }
    public String getCreateTime() { return createTime; }
    public void setCreateTime(String createTime) { this.createTime = createTime; }
}
