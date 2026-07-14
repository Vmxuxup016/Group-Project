package com.asset.dao;

import com.asset.JdbcTemplateFactory;
import com.asset.pojo.AssetInventory;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;

import java.util.List;

//盘点任务数据访问层
public class AssetInventoryDao {

    private JdbcTemplate jdbc = JdbcTemplateFactory.getJdbcTemplate();

    public List<AssetInventory> findAll() {
        String sql = "SELECT i.*, u.real_name AS operatorName FROM asset_inventory i " +
                     "LEFT JOIN user u ON i.operator_id = u.id ORDER BY i.id DESC";
        return jdbc.query(sql, new BeanPropertyRowMapper<>(AssetInventory.class));
    }

    public AssetInventory findById(Integer id) {
        String sql = "SELECT i.*, u.real_name AS operatorName FROM asset_inventory i " +
                     "LEFT JOIN user u ON i.operator_id = u.id WHERE i.id = ?";
        List<AssetInventory> list = jdbc.query(sql, new BeanPropertyRowMapper<>(AssetInventory.class), id);
        return list.isEmpty() ? null : list.get(0);
    }

    public int save(AssetInventory inventory) {
        String sql = "INSERT INTO asset_inventory (inventory_no, inventory_name, inventory_type, scope_ids, " +
                     "plan_date, start_date, end_date, status, result_status, inventory_method, operator_id, remark) " +
                     "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        return jdbc.update(sql, inventory.getInventoryNo(), inventory.getInventoryName(),
                inventory.getInventoryType(), inventory.getScopeIds(), inventory.getPlanDate(),
                inventory.getStartDate(), inventory.getEndDate(), inventory.getStatus(),
                inventory.getResultStatus(), inventory.getInventoryMethod(), inventory.getOperatorId(),
                inventory.getRemark());
    }

    public int updateStatus(Integer id, Integer status) {
        String sql = "UPDATE asset_inventory SET status=? WHERE id=?";
        return jdbc.update(sql, status, id);
    }

    public int complete(Integer id, Integer resultStatus) {
        String sql = "UPDATE asset_inventory SET status=3, result_status=?, end_date=CURDATE() WHERE id=?";
        return jdbc.update(sql, resultStatus, id);
    }
}
