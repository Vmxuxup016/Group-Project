package com.asset.dao;

import com.asset.pojo.AssetRfidTag;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;

import java.util.List;

//RFID标签数据访问层
public class AssetRfidTagDao {

    private JdbcTemplate jdbc = JdbcTemplateFactory.getJdbcTemplate();

    public List<AssetRfidTag> findAll() {
        String sql = "SELECT t.*, a.asset_code AS assetCode, a.asset_name AS assetName " +
                     "FROM asset_rfid_tag t LEFT JOIN asset a ON t.asset_id = a.id ORDER BY t.id DESC";
        return jdbc.query(sql, new BeanPropertyRowMapper<>(AssetRfidTag.class));
    }

    public AssetRfidTag findById(Integer id) {
        String sql = "SELECT t.*, a.asset_code AS assetCode, a.asset_name AS assetName " +
                     "FROM asset_rfid_tag t LEFT JOIN asset a ON t.asset_id = a.id WHERE t.id = ?";
        List<AssetRfidTag> list = jdbc.query(sql, new BeanPropertyRowMapper<>(AssetRfidTag.class), id);
        return list.isEmpty() ? null : list.get(0);
    }

    public AssetRfidTag findByTagCode(String tagCode) {
        String sql = "SELECT t.*, a.asset_code AS assetCode, a.asset_name AS assetName " +
                     "FROM asset_rfid_tag t LEFT JOIN asset a ON t.asset_id = a.id WHERE t.tag_code = ?";
        List<AssetRfidTag> list = jdbc.query(sql, new BeanPropertyRowMapper<>(AssetRfidTag.class), tagCode);
        return list.isEmpty() ? null : list.get(0);
    }

    public int save(AssetRfidTag tag) {
        String sql = "INSERT INTO asset_rfid_tag (tag_code, asset_id, tag_status, bind_time) VALUES (?, ?, ?, ?)";
        return jdbc.update(sql, tag.getTagCode(), tag.getAssetId(), tag.getTagStatus(), tag.getBindTime());
    }

    public int bind(Integer id, Integer assetId) {
        String sql = "UPDATE asset_rfid_tag SET asset_id=?, tag_status=1, bind_time=NOW() WHERE id=?";
        return jdbc.update(sql, assetId, id);
    }

    public int unbind(Integer id) {
        String sql = "UPDATE asset_rfid_tag SET asset_id=NULL, tag_status=3, bind_time=NULL WHERE id=?";
        return jdbc.update(sql, id);
    }

    public int updateScanInfo(Integer id, String location) {
        String sql = "UPDATE asset_rfid_tag SET last_scan_time=NOW(), last_scan_location=?, scan_count=scan_count+1 WHERE id=?";
        return jdbc.update(sql, location, id);
    }

    public int updateStatus(Integer id, Integer status) {
        String sql = "UPDATE asset_rfid_tag SET tag_status=? WHERE id=?";
        return jdbc.update(sql, status, id);
    }

    public int delete(Integer id) {
        String sql = "DELETE FROM asset_rfid_tag WHERE id=?";
        return jdbc.update(sql, id);
    }

    public List<AssetRfidTag> findUnbound() {
        String sql = "SELECT * FROM asset_rfid_tag WHERE tag_status = 3";
        return jdbc.query(sql, new BeanPropertyRowMapper<>(AssetRfidTag.class));
    }
}
