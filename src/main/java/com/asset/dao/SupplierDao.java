package com.asset.dao;

import com.asset.JdbcTemplateFactory;
import com.asset.pojo.Supplier;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;

import java.util.List;

//供应商数据访问层
public class SupplierDao {

    private JdbcTemplate jdbc = JdbcTemplateFactory.getJdbcTemplate();

    public List<Supplier> findAll() {
        String sql = "SELECT * FROM supplier ORDER BY id";
        return jdbc.query(sql, new BeanPropertyRowMapper<>(Supplier.class));
    }

    public List<Supplier> findActive() {
        String sql = "SELECT * FROM supplier WHERE status = 1 ORDER BY id";
        return jdbc.query(sql, new BeanPropertyRowMapper<>(Supplier.class));
    }

    public Supplier findById(Integer id) {
        String sql = "SELECT * FROM supplier WHERE id = ?";
        List<Supplier> list = jdbc.query(sql, new BeanPropertyRowMapper<>(Supplier.class), id);
        return list.isEmpty() ? null : list.get(0);
    }

    public int save(Supplier supplier) {
        String sql = "INSERT INTO supplier (supplier_name, contact_person, phone, address, status) VALUES (?, ?, ?, ?, ?)";
        return jdbc.update(sql, supplier.getSupplierName(), supplier.getContactPerson(),
                supplier.getPhone(), supplier.getAddress(), supplier.getStatus());
    }

    public int update(Supplier supplier) {
        String sql = "UPDATE supplier SET supplier_name=?, contact_person=?, phone=?, address=?, status=? WHERE id=?";
        return jdbc.update(sql, supplier.getSupplierName(), supplier.getContactPerson(),
                supplier.getPhone(), supplier.getAddress(), supplier.getStatus(), supplier.getId());
    }

    public int delete(Integer id) {
        String sql = "DELETE FROM supplier WHERE id=?";
        return jdbc.update(sql, id);
    }
}
