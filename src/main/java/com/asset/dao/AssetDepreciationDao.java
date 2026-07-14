package com.asset.dao;

import com.asset.JdbcTemplateFactory;
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
}
