package com.asset.dao;

import com.asset.JdbcTemplateFactory;
import com.asset.pojo.AssetPurchaseItem;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;

import java.util.List;

//采购明细数据访问层
public class AssetPurchaseItemDao {

    private JdbcTemplate jdbc = JdbcTemplateFactory.getJdbcTemplate();

    public List<AssetPurchaseItem> findByPurchaseId(Integer purchaseId) {
        String sql = "SELECT * FROM asset_purchase_item WHERE purchase_id = ?";
        return jdbc.query(sql, new BeanPropertyRowMapper<>(AssetPurchaseItem.class), purchaseId);
    }

    public AssetPurchaseItem findById(Integer id) {
        String sql = "SELECT * FROM asset_purchase_item WHERE id = ?";
        List<AssetPurchaseItem> list = jdbc.query(sql, new BeanPropertyRowMapper<>(AssetPurchaseItem.class), id);
        return list.isEmpty() ? null : list.get(0);
    }

    public int save(AssetPurchaseItem item) {
        String sql = "INSERT INTO asset_purchase_item (purchase_id, category_id, asset_name, brand, model, " +
                     "quantity, unit_price, total_price, received_qty, warranty_months, status) " +
                     "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        return jdbc.update(sql, item.getPurchaseId(), item.getCategoryId(), item.getAssetName(),
                item.getBrand(), item.getModel(), item.getQuantity(), item.getUnitPrice(),
                item.getTotalPrice(), item.getReceivedQty(), item.getWarrantyMonths(), item.getStatus());
    }

    public int updateReceivedQty(Integer id, Integer receivedQty, Integer status) {
        String sql = "UPDATE asset_purchase_item SET received_qty=?, status=? WHERE id=?";
        return jdbc.update(sql, receivedQty, status, id);
    }

    public int deleteByPurchaseId(Integer purchaseId) {
        String sql = "DELETE FROM asset_purchase_item WHERE purchase_id = ?";
        return jdbc.update(sql, purchaseId);
    }
}
