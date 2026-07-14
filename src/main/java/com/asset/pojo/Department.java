package com.asset.pojo;

public class Department {

    //部门ID（主键，自增）
    private Integer id;

    //上级部门ID（0为根节点，表示顶级部门）
    private Integer parentId;

    //部门名称
    private String deptName;

    //部门编码（唯一）
    private String deptCode;

    //排序（数值越小越靠前）
    private Integer sortOrder;

    //创建时间
    private String createTime;

    public Integer getId() { return id; }
    public void setId(Integer id) { this.id = id; }
    public Integer getParentId() { return parentId; }
    public void setParentId(Integer parentId) { this.parentId = parentId; }
    public String getDeptName() { return deptName; }
    public void setDeptName(String deptName) { this.deptName = deptName; }
    public String getDeptCode() { return deptCode; }
    public void setDeptCode(String deptCode) { this.deptCode = deptCode; }
    public Integer getSortOrder() { return sortOrder; }
    public void setSortOrder(Integer sortOrder) { this.sortOrder = sortOrder; }
    public String getCreateTime() { return createTime; }
    public void setCreateTime(String createTime) { this.createTime = createTime; }
}
