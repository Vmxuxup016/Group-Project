package com.asset.dao;

import com.asset.JdbcTemplateFactory;
import com.asset.pojo.AssetUseRecord;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;

import java.util.List;

//领用归还调拨记录数据访问层
public class AssetUseRecordDao {

    private JdbcTemplate jdbc = JdbcTemplateFactory.getJdbcTemplate();

    public List<AssetUseRecord> findAll() {
        String sql = "SELECT r.*, a.asset_code AS assetCode, a.asset_name AS assetName, " +
                     "d1.dept_name AS fromDeptName, d2.dept_name AS toDeptName, u.real_name AS operatorName " +
                     "FROM asset_use_record r " +
                     "LEFT JOIN asset a ON r.asset_id = a.id " +
                     "LEFT JOIN department d1 ON r.from_dept_id = d1.id " +
                     "LEFT JOIN department d2 ON r.to_dept_id = d2.id " +
                     "LEFT JOIN user u ON r.operator_id = u.id ORDER BY r.id DESC";
        return jdbc.query(sql, new BeanPropertyRowMapper<>(AssetUseRecord.class));
    }

    public AssetUseRecord findById(Integer id) {
        String sql = "SELECT r.*, a.asset_code AS assetCode, a.asset_name AS assetName, " +
                     "d1.dept_name AS fromDeptName, d2.dept_name AS toDeptName, u.real_name AS operatorName " +
                     "FROM asset_use_record r " +
                     "LEFT JOIN asset a ON r.asset_id = a.id " +
                     "LEFT JOIN department d1 ON r.from_dept_id = d1.id " +
                     "LEFT JOIN department d2 ON r.to_dept_id = d2.id " +
                     "LEFT JOIN user u ON r.operator_id = u.id WHERE r.id = ?";
        List<AssetUseRecord> list = jdbc.query(sql, new BeanPropertyRowMapper<>(AssetUseRecord.class), id);
        return list.isEmpty() ? null : list.get(0);
    }

    public List<AssetUseRecord> findByOperationType(Integer operationType) {
        String sql = "SELECT r.*, a.asset_code AS assetCode, a.asset_name AS assetName, " +
                     "d1.dept_name AS fromDeptName, d2.dept_name AS toDeptName, u.real_name AS operatorName " +
                     "FROM asset_use_record r " +
                     "LEFT JOIN asset a ON r.asset_id = a.id " +
                     "LEFT JOIN department d1 ON r.from_dept_id = d1.id " +
                     "LEFT JOIN department d2 ON r.to_dept_id = d2.id " +
                     "LEFT JOIN user u ON r.operator_id = u.id " +
                     "WHERE r.operation_type = ? ORDER BY r.id DESC";
        return jdbc.query(sql, new BeanPropertyRowMapper<>(AssetUseRecord.class), operationType);
    }

    public int save(AssetUseRecord record) {
        String sql = "INSERT INTO asset_use_record (asset_id, operation_type, from_dept_id, to_dept_id, " +
                     "use_date, expected_return_date, actual_return_date, return_status, approval_status, " +
                     "purpose, operator_id) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        return jdbc.update(sql, record.getAssetId(), record.getOperationType(), record.getFromDeptId(),
                record.getToDeptId(), record.getUseDate(), record.getExpectedReturnDate(),
                record.getActualReturnDate(), record.getReturnStatus(), record.getApprovalStatus(),
                record.getPurpose(), record.getOperatorId());
    }

    public int updateReturn(Integer id, Integer returnStatus, String actualReturnDate) {
        String sql = "UPDATE asset_use_record SET return_status=?, actual_return_date=? WHERE id=?";
        return jdbc.update(sql, returnStatus, actualReturnDate, id);
    }

    public int updateApproval(Integer id, Integer approvalStatus) {
        String sql = "UPDATE asset_use_record SET approval_status=? WHERE id=?";
        return jdbc.update(sql, approvalStatus, id);
    }
}
