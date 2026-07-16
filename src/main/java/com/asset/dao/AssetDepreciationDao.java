package com.asset.dao;

import com.asset.pojo.AssetDepreciation;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;

import java.util.List;

//折旧记录数据访问层
public class AssetDepreciationDao {

    private JdbcTemplate jdbc = JdbcTemplateFactory.getJdbcTemplate();

    public List<AssetDepreciation> findAll() {
        String sql = "SELECT d.*, a.asset_code AS assetCode, a.asset_name AS assetName " +
                     "FROM asset_depreciation d LEFT JOIN asset a ON d.asset_id = a.id ORDER BY d.id DESC";
        return jdbc.query(sql, new BeanPropertyRowMapper<>(AssetDepreciation.class));
    }

    public List<AssetDepreciation> findByAssetId(Integer assetId) {
        String sql = "SELECT * FROM asset_depreciation WHERE asset_id = ? ORDER BY depreciation_date";
        return jdbc.query(sql, new BeanPropertyRowMapper<>(AssetDepreciation.class), assetId);
    }

    public int save(AssetDepreciation depreciation) {
        String sql = "INSERT INTO asset_depreciation (asset_id, depreciation_date, original_value, " +
                     "depreciation_amount, accumulated_depreciation, net_value, remaining_months) " +
                     "VALUES (?, ?, ?, ?, ?, ?, ?)";
        return jdbc.update(sql, depreciation.getAssetId(), depreciation.getDepreciationDate(),
                depreciation.getOriginalValue(), depreciation.getDepreciationAmount(),
                depreciation.getAccumulatedDepreciation(), depreciation.getNetValue(),
                depreciation.getRemainingMonths());
    }

    // 按月份筛选折旧记录
    public List<AssetDepreciation> findByMonth(String month) {
        String sql = "SELECT d.*, a.asset_code AS assetCode, a.asset_name AS assetName " +
                     "FROM asset_depreciation d LEFT JOIN asset a ON d.asset_id = a.id " +
                     "WHERE DATE_FORMAT(d.depreciation_date, '%Y-%m') = ? " +
                     "ORDER BY d.id DESC";
        return jdbc.query(sql, new BeanPropertyRowMapper<>(AssetDepreciation.class), month);
    }

    // 获取所有有折旧记录的月份列表
    public List<String> findAvailableMonths() {
        String sql = "SELECT DISTINCT DATE_FORMAT(depreciation_date, '%Y-%m') AS month " +
                     "FROM asset_depreciation ORDER BY month DESC";
        return jdbc.queryForList(sql, String.class);
    }

    // 检查指定资产在指定月份是否已计提折旧
    public boolean existsByAssetIdAndMonth(Integer assetId, String month) {
        String sql = "SELECT COUNT(*) FROM asset_depreciation " +
                     "WHERE asset_id = ? AND DATE_FORMAT(depreciation_date, '%Y-%m') = ?";
        Integer count = jdbc.queryForObject(sql, Integer.class, assetId, month);
        return count != null && count > 0;
    }
}
