package com.asset.dao;

import com.asset.JdbcTemplateFactory;
import com.asset.pojo.Department;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;

import java.util.List;

//部门数据访问层
public class DepartmentDao {

    private JdbcTemplate jdbc = JdbcTemplateFactory.getJdbcTemplate();

    public List<Department> findAll() {
        String sql = "SELECT * FROM department ORDER BY sort_order, id";
        return jdbc.query(sql, new BeanPropertyRowMapper<>(Department.class));
    }

    public Department findById(Integer id) {
        String sql = "SELECT * FROM department WHERE id = ?";
        List<Department> list = jdbc.query(sql, new BeanPropertyRowMapper<>(Department.class), id);
        return list.isEmpty() ? null : list.get(0);
    }

    public int save(Department dept) {
        String sql = "INSERT INTO department (parent_id, dept_name, dept_code, sort_order) VALUES (?, ?, ?, ?)";
        return jdbc.update(sql, dept.getParentId(), dept.getDeptName(), dept.getDeptCode(), dept.getSortOrder());
    }

    public int update(Department dept) {
        String sql = "UPDATE department SET parent_id=?, dept_name=?, dept_code=?, sort_order=? WHERE id=?";
        return jdbc.update(sql, dept.getParentId(), dept.getDeptName(), dept.getDeptCode(), dept.getSortOrder(), dept.getId());
    }

    public int delete(Integer id) {
        String sql = "DELETE FROM department WHERE id=?";
        return jdbc.update(sql, id);
    }

    public int countByParentId(Integer parentId) {
        String sql = "SELECT COUNT(*) FROM department WHERE parent_id = ?";
        Integer count = jdbc.queryForObject(sql, Integer.class, parentId);
        return count != null ? count : 0;
    }
}
