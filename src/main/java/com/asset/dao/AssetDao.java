package com.asset.dao;

import com.asset.pojo.Asset;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;

import java.util.ArrayList;
import java.util.List;

//资产数据访问层
public class AssetDao {

    private JdbcTemplate jdbc = JdbcTemplateFactory.getJdbcTemplate();

    //查询资产列表(带关联)
    public List<Asset> findList(String keyword, Integer status, Integer categoryId, Integer deptId,
                                 int offset, int pageSize) {
        StringBuilder sql = new StringBuilder(
            "SELECT a.*, c.category_name AS categoryName, s.supplier_name AS supplierName, " +
            "d.dept_name AS deptName FROM asset a " +
            "LEFT JOIN asset_category c ON a.category_id = c.id " +
            "LEFT JOIN supplier s ON a.supplier_id = s.id " +
            "LEFT JOIN department d ON a.department_id = d.id WHERE 1=1 ");
        List<Object> params = new ArrayList<>();

        if (keyword != null && !keyword.isEmpty()) {
            sql.append("AND (a.asset_code LIKE ? OR a.asset_name LIKE ? OR a.sn_code LIKE ?) ");
            String kw = "%" + keyword + "%";
            params.add(kw); params.add(kw); params.add(kw);
        }
        if (status != null) {
            sql.append("AND a.status = ? ");
            params.add(status);
        }
        if (categoryId != null) {
            sql.append("AND a.category_id = ? ");
            params.add(categoryId);
        }
        if (deptId != null) {
            sql.append("AND a.department_id = ? ");
            params.add(deptId);
        }

        sql.append("ORDER BY a.id DESC LIMIT ?, ?");
        params.add(offset);
        params.add(pageSize);

        return jdbc.query(sql.toString(), new BeanPropertyRowMapper<>(Asset.class), params.toArray());
    }

    //查询总数
    public int count(String keyword, Integer status, Integer categoryId, Integer deptId) {
        StringBuilder sql = new StringBuilder("SELECT COUNT(*) FROM asset a WHERE 1=1 ");
        List<Object> params = new ArrayList<>();

        if (keyword != null && !keyword.isEmpty()) {
            sql.append("AND (a.asset_code LIKE ? OR a.asset_name LIKE ? OR a.sn_code LIKE ?) ");
            String kw = "%" + keyword + "%";
            params.add(kw); params.add(kw); params.add(kw);
        }
        if (status != null) {
            sql.append("AND a.status = ? ");
            params.add(status);
        }
        if (categoryId != null) {
            sql.append("AND a.category_id = ? ");
            params.add(categoryId);
        }
        if (deptId != null) {
            sql.append("AND a.department_id = ? ");
            params.add(deptId);
        }

        Integer count = jdbc.queryForObject(sql.toString(), Integer.class, params.toArray());
        return count != null ? count : 0;
    }

    //根据ID查询
    public Asset findById(Integer id) {
        String sql = "SELECT a.*, c.category_name AS categoryName, s.supplier_name AS supplierName, " +
                     "d.dept_name AS deptName FROM asset a " +
                     "LEFT JOIN asset_category c ON a.category_id = c.id " +
                     "LEFT JOIN supplier s ON a.supplier_id = s.id " +
                     "LEFT JOIN department d ON a.department_id = d.id WHERE a.id = ?";
        List<Asset> list = jdbc.query(sql, new BeanPropertyRowMapper<>(Asset.class), id);
        return list.isEmpty() ? null : list.get(0);
    }

    //新增资产
    public int save(Asset asset) {
        String sql = "INSERT INTO asset (asset_code, asset_name, category_id, brand, model, sn_code, rfid_tag, " +
                     "barcode, purchase_date, purchase_price, current_value, supplier_id, warranty_expiry, " +
                     "status, department_id, location, depreciable_months, depreciated_months, depreciable_start_date, remark) " +
                     "VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
        return jdbc.update(sql, asset.getAssetCode(), asset.getAssetName(), asset.getCategoryId(),
                asset.getBrand(), asset.getModel(), asset.getSnCode(), asset.getRfidTag(),
                asset.getBarcode(), asset.getPurchaseDate(), asset.getPurchasePrice(), asset.getCurrentValue(),
                asset.getSupplierId(), asset.getWarrantyExpiry(), asset.getStatus(), asset.getDepartmentId(),
                asset.getLocation(), asset.getDepreciableMonths(), asset.getDepreciatedMonths(),
                asset.getDepreciableStartDate(), asset.getRemark());
    }

    //更新资产
    public int update(Asset asset) {
        String sql = "UPDATE asset SET asset_name=?, category_id=?, brand=?, model=?, sn_code=?, rfid_tag=?, " +
                     "barcode=?, purchase_date=?, purchase_price=?, current_value=?, supplier_id=?, warranty_expiry=?, " +
                     "status=?, department_id=?, location=?, depreciable_months=?, depreciated_months=?, " +
                     "depreciable_start_date=?, remark=? WHERE id=?";
        return jdbc.update(sql, asset.getAssetName(), asset.getCategoryId(), asset.getBrand(), asset.getModel(),
                asset.getSnCode(), asset.getRfidTag(), asset.getBarcode(), asset.getPurchaseDate(),
                asset.getPurchasePrice(), asset.getCurrentValue(), asset.getSupplierId(), asset.getWarrantyExpiry(),
                asset.getStatus(), asset.getDepartmentId(), asset.getLocation(), asset.getDepreciableMonths(),
                asset.getDepreciatedMonths(), asset.getDepreciableStartDate(), asset.getRemark(), asset.getId());
    }

    //删除资产
    public int delete(Integer id) {
        String sql = "DELETE FROM asset WHERE id=?";
        return jdbc.update(sql, id);
    }

    //根据分类统计数量
    public int countByStatus(Integer status) {
        String sql = "SELECT COUNT(*) FROM asset WHERE status = ?";
        Integer count = jdbc.queryForObject(sql, Integer.class, status);
        return count != null ? count : 0;
    }

    //按分类统计
    public List<Object[]> countGroupByCategory() {
        String sql = "SELECT c.category_name, COUNT(*), IFNULL(SUM(a.purchase_price),0), IFNULL(SUM(a.current_value),0) " +
                     "FROM asset a LEFT JOIN asset_category c ON a.category_id = c.id " +
                     "WHERE c.category_level = 1 GROUP BY c.id, c.category_name";
        return jdbc.query(sql, (rs, i) -> new Object[]{
                rs.getString(1), rs.getInt(2), rs.getBigDecimal(3), rs.getBigDecimal(4)
        });
    }

    //获取最大编号序号
    public Integer getMaxAssetCodeSeq(String prefix) {
        String sql = "SELECT MAX(CAST(SUBSTRING_INDEX(asset_code, '-', -1) AS UNSIGNED)) FROM asset WHERE asset_code LIKE ?";
        try {
            Integer max = jdbc.queryForObject(sql, Integer.class, prefix + "%");
            return max != null ? max : 0;
        } catch (Exception e) {
            return 0;
        }
    }

    //根据部门统计
    public int countByDeptId(Integer deptId) {
        String sql = "SELECT COUNT(*) FROM asset WHERE department_id = ?";
        Integer count = jdbc.queryForObject(sql, Integer.class, deptId);
        return count != null ? count : 0;
    }

    //根据分类ID统计资产数量
    public int countByCategoryId(Integer categoryId) {
        String sql = "SELECT COUNT(*) FROM asset WHERE category_id = ?";
        Integer count = jdbc.queryForObject(sql, Integer.class, categoryId);
        return count != null ? count : 0;
    }
}
