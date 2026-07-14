package com.asset.dao;

import com.asset.JdbcTemplateFactory;
import com.asset.pojo.AssetPurchase;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;

import java.util.List;

//采购单数据访问层
public class AssetPurchaseDao {

    private JdbcTemplate jdbc = JdbcTemplateFactory.getJdbcTemplate();

    public List<AssetPurchase> findAll() {
        String sql = "SELECT p.*, s.supplier_name AS supplierName FROM asset_purchase p " +
                     "LEFT JOIN supplier s ON p.supplier_id = s.id ORDER BY p.id DESC";
        return jdbc.query(sql, new BeanPropertyRowMapper<>(AssetPurchase.class));
    }

    public AssetPurchase findById(Integer id) {
        String sql = "SELECT p.*, s.supplier_name AS supplierName FROM asset_purchase p " +
                     "LEFT JOIN supplier s ON p.supplier_id = s.id WHERE p.id = ?";
        List<AssetPurchase> list = jdbc.query(sql, new BeanPropertyRowMapper<>(AssetPurchase.class), id);
        return list.isEmpty() ? null : list.get(0);
    }

    public int save(AssetPurchase purchase) {
        String sql = "INSERT INTO asset_purchase (purchase_no, supplier_id, purchase_date, total_amount, invoice_no, status, remark, create_by) " +
                     "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
        return jdbc.update(sql, purchase.getPurchaseNo(), purchase.getSupplierId(), purchase.getPurchaseDate(),
                purchase.getTotalAmount(), purchase.getInvoiceNo(), purchase.getStatus(), purchase.getRemark(), purchase.getCreateBy());
    }

    public int update(AssetPurchase purchase) {
        String sql = "UPDATE asset_purchase SET supplier_id=?, purchase_date=?, total_amount=?, invoice_no=?, status=?, remark=? WHERE id=?";
        return jdbc.update(sql, purchase.getSupplierId(), purchase.getPurchaseDate(), purchase.getTotalAmount(),
                purchase.getInvoiceNo(), purchase.getStatus(), purchase.getRemark(), purchase.getId());
    }

    public int updateStatus(Integer id, Integer status) {
        String sql = "UPDATE asset_purchase SET status=? WHERE id=?";
        return jdbc.update(sql, status, id);
    }

    public int delete(Integer id) {
        String sql = "DELETE FROM asset_purchase WHERE id=?";
        return jdbc.update(sql, id);
    }
}
