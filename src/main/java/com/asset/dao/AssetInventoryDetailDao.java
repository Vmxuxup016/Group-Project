package com.asset.dao;

import com.asset.JdbcTemplateFactory;
import com.asset.pojo.AssetInventoryDetail;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;

import java.util.List;

//盘点明细数据访问层
public class AssetInventoryDetailDao {

    private JdbcTemplate jdbc = JdbcTemplateFactory.getJdbcTemplate();

    public List<AssetInventoryDetail> findByInventoryId(Integer inventoryId) {
        String sql = "SELECT d.*, a.asset_code AS assetCode, a.asset_name AS assetName " +
                     "FROM asset_inventory_detail d " +
                     "LEFT JOIN asset a ON d.asset_id = a.id WHERE d.inventory_id = ?";
        return jdbc.query(sql, new BeanPropertyRowMapper<>(AssetInventoryDetail.class), inventoryId);
    }

    public int save(AssetInventoryDetail detail) {
        String sql = "INSERT INTO asset_inventory_detail (inventory_id, asset_id, book_status, book_dept_id, " +
                     "book_location, actual_status, actual_dept_id, actual_location, rfid_scanned, checker_id, remark) " +
                     "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        return jdbc.update(sql, detail.getInventoryId(), detail.getAssetId(), detail.getBookStatus(),
                detail.getBookDeptId(), detail.getBookLocation(), detail.getActualStatus(),
                detail.getActualDeptId(), detail.getActualLocation(), detail.getRfidScanned(),
                detail.getCheckerId(), detail.getRemark());
    }

    public int deleteByInventoryId(Integer inventoryId) {
        String sql = "DELETE FROM asset_inventory_detail WHERE inventory_id = ?";
        return jdbc.update(sql, inventoryId);
    }
}
