package com.asset.dao;

import com.asset.pojo.AssetRepair;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;

import java.util.List;

//维修记录数据访问层
public class AssetRepairDao {

    private JdbcTemplate jdbc = JdbcTemplateFactory.getJdbcTemplate();

    public List<AssetRepair> findAll() {
        String sql = "SELECT r.*, a.asset_code AS assetCode, a.asset_name AS assetName, d.dept_name AS deptName " +
                     "FROM asset_repair r " +
                     "LEFT JOIN asset a ON r.asset_id = a.id " +
                     "LEFT JOIN department d ON r.report_dept_id = d.id ORDER BY r.id DESC";
        return jdbc.query(sql, new BeanPropertyRowMapper<>(AssetRepair.class));
    }

    public AssetRepair findById(Integer id) {
        String sql = "SELECT r.*, a.asset_code AS assetCode, a.asset_name AS assetName, d.dept_name AS deptName " +
                     "FROM asset_repair r " +
                     "LEFT JOIN asset a ON r.asset_id = a.id " +
                     "LEFT JOIN department d ON r.report_dept_id = d.id WHERE r.id = ?";
        List<AssetRepair> list = jdbc.query(sql, new BeanPropertyRowMapper<>(AssetRepair.class), id);
        return list.isEmpty() ? null : list.get(0);
    }

    public int save(AssetRepair repair) {
        String sql = "INSERT INTO asset_repair (asset_id, repair_no, fault_desc, fault_type, report_dept_id, " +
                     "repair_status, repair_method, repair_cost, repair_result, start_date, finish_date, operator_id) " +
                     "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        return jdbc.update(sql, repair.getAssetId(), repair.getRepairNo(), repair.getFaultDesc(),
                repair.getFaultType(), repair.getReportDeptId(), repair.getRepairStatus(),
                repair.getRepairMethod(), repair.getRepairCost(), repair.getRepairResult(),
                repair.getStartDate(), repair.getFinishDate(), repair.getOperatorId());
    }

    public int update(AssetRepair repair) {
        String sql = "UPDATE asset_repair SET fault_desc=?, fault_type=?, repair_status=?, repair_method=?, " +
                     "repair_cost=?, repair_result=?, finish_date=? WHERE id=?";
        return jdbc.update(sql, repair.getFaultDesc(), repair.getFaultType(), repair.getRepairStatus(),
                repair.getRepairMethod(), repair.getRepairCost(), repair.getRepairResult(),
                repair.getFinishDate(), repair.getId());
    }

    public int updateStatus(Integer id, Integer status) {
        String sql = "UPDATE asset_repair SET repair_status=? WHERE id=?";
        return jdbc.update(sql, status, id);
    }
}
