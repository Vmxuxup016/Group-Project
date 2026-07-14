package com.asset.pojo;

public class User {

    //用户ID（主键，自增）
    private Integer id;

    // 登录账号（唯一）
    private String username;

    // 密码（MD5加密存储）
    private String password;

    //真实姓名
    private String realName;

    //所属部门ID
    private Integer deptId;

    //角色：admin-管理员，asset-资产管理员，user-普通用户
    private String role;

    // 联系电话
    private String phone;

    //状态：1-正常，0-禁用
    private Integer status;

    //创建时间
    private String createTime;

    // ============ 关联字段（非数据库字段，仅用于前端展示） ============

    // 部门名称
    private String deptName;

    public Integer getId() { return id; }
    public void setId(Integer id) { this.id = id; }
    public String getUsername() { return username; }
    public void setUsername(String username) { this.username = username; }
    public String getPassword() { return password; }
    public void setPassword(String password) { this.password = password; }
    public String getRealName() { return realName; }
    public void setRealName(String realName) { this.realName = realName; }
    public Integer getDeptId() { return deptId; }
    public void setDeptId(Integer deptId) { this.deptId = deptId; }
    public String getRole() { return role; }
    public void setRole(String role) { this.role = role; }
    public String getPhone() { return phone; }
    public void setPhone(String phone) { this.phone = phone; }
    public Integer getStatus() { return status; }
    public void setStatus(Integer status) { this.status = status; }
    public String getCreateTime() { return createTime; }
    public void setCreateTime(String createTime) { this.createTime = createTime; }
    public String getDeptName() { return deptName; }
    public void setDeptName(String deptName) { this.deptName = deptName; }

    @Override
    public String toString() {
        return "User{id=" + id + ", username='" + username + "', realName='" + realName + "', role='" + role + "'}";
    }
}
