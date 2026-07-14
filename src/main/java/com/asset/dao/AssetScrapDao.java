package com.asset.dao;

import com.asset.JdbcTemplateFactory;
import com.asset.pojo.AssetScrap;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;

import java.math.BigDecimal;
import java.util.List;

//报废记录数据访问层
public class AssetScrapDao {

    private JdbcTemplate jdbc = JdbcTemplateFactory.getJdbcTemplate();

    public List<AssetScrap> findAll() {
        String sql = "SELECT s.*, a.asset_code AS assetCode, a.asset_name AS assetName " +
                     "FROM asset_scrap s LEFT JOIN asset a ON s.asset_id = a.id ORDER BY s.id DESC";
        return jdbc.query(sql, new BeanPropertyRowMapper<>(AssetScrap.class));
    }

    public AssetScrap findById(Integer id) {
        String sql = "SELECT s.*, a.asset_code AS assetCode, a.asset_name AS assetName " +
                     "FROM asset_scrap s LEFT JOIN asset a ON s.asset_id = a.id WHERE s.id = ?";
        List<AssetScrap> list = jdbc.query(sql, new BeanPropertyRowMapper<>(AssetScrap.class), id);
        return list.isEmpty() ? null : list.get(0);
    }

    public int save(AssetScrap scrap) {
        String sql = "INSERT INTO asset_scrap (asset_id, scrap_no, scrap_reason, scrap_type, original_value, " +
                     "scrap_value, status, executor_id, execute_date, dispose_method, create_by) " +
                     "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        return jdbc.update(sql, scrap.getAssetId(), scrap.getScrapNo(), scrap.getScrapReason(),
                scrap.getScrapType(), scrap.getOriginalValue(), scrap.getScrapValue(),
                scrap.getStatus(), scrap.getExecutorId(), scrap.getExecuteDate(),
                scrap.getDisposeMethod(), scrap.getCreateBy());
    }

    public int updateStatus(Integer id, Integer status) {
        String sql = "UPDATE asset_scrap SET status=? WHERE id=?";
        return jdbc.update(sql, status, id);
    }

    public int executeScrap(Integer id, Integer executorId, String executeDate, Integer disposeMethod, BigDecimal scrapValue) {
        String sql = "UPDATE asset_scrap SET status=3, executor_id=?, execute_date=?, dispose_method=?, scrap_value=? WHERE id=?";
        return jdbc.update(sql, executorId, executeDate, disposeMethod, scrapValue, id);
    }
}
