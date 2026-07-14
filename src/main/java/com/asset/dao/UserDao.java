package com.asset.dao;

import com.asset.JdbcTemplateFactory;
import com.asset.pojo.User;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;

import java.util.List;

//用户数据访问层
public class UserDao {

    private JdbcTemplate jdbc = JdbcTemplateFactory.getJdbcTemplate();

    //根据用户名查询用户
    public User findByUsername(String username) {
        String sql = "SELECT u.*, d.dept_name AS deptName FROM user u " +
                     "LEFT JOIN department d ON u.dept_id = d.id WHERE u.username = ?";
        List<User> list = jdbc.query(sql, new BeanPropertyRowMapper<>(User.class), username);
        return list.isEmpty() ? null : list.get(0);
    }

    //根据ID查询用户
    public User findById(Integer id) {
        String sql = "SELECT u.*, d.dept_name AS deptName FROM user u " +
                     "LEFT JOIN department d ON u.dept_id = d.id WHERE u.id = ?";
        List<User> list = jdbc.query(sql, new BeanPropertyRowMapper<>(User.class), id);
        return list.isEmpty() ? null : list.get(0);
    }

    //查询所有用户
    public List<User> findAll() {
        String sql = "SELECT u.*, d.dept_name AS deptName FROM user u " +
                     "LEFT JOIN department d ON u.dept_id = d.id ORDER BY u.id";
        return jdbc.query(sql, new BeanPropertyRowMapper<>(User.class));
    }

    //新增用户
    public int save(User user) {
        String sql = "INSERT INTO user (username, password, real_name, dept_id, role, phone, status) " +
                     "VALUES (?, ?, ?, ?, ?, ?, ?)";
        return jdbc.update(sql, user.getUsername(), user.getPassword(), user.getRealName(),
                user.getDeptId(), user.getRole(), user.getPhone(), user.getStatus());
    }

    //更新用户
    public int update(User user) {
        String sql = "UPDATE user SET real_name=?, dept_id=?, role=?, phone=?, status=? WHERE id=?";
        return jdbc.update(sql, user.getRealName(), user.getDeptId(), user.getRole(),
                user.getPhone(), user.getStatus(), user.getId());
    }

    //修改密码
    public int updatePassword(Integer id, String password) {
        String sql = "UPDATE user SET password=? WHERE id=?";
        return jdbc.update(sql, password, id);
    }

    //删除用户
    public int delete(Integer id) {
        String sql = "DELETE FROM user WHERE id=?";
        return jdbc.update(sql, id);
    }

    //检查用户名是否存在
    public boolean existsByUsername(String username) {
        String sql = "SELECT COUNT(*) FROM user WHERE username = ?";
        Integer count = jdbc.queryForObject(sql, Integer.class, username);
        return count != null && count > 0;
    }
}
