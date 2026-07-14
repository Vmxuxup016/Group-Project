package com.asset.dao;

import com.asset.JdbcTemplateFactory;
import com.asset.pojo.AssetCategory;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;

import java.util.List;

//资产分类数据访问层
public class AssetCategoryDao {

    private JdbcTemplate jdbc = JdbcTemplateFactory.getJdbcTemplate();

    public List<AssetCategory> findAll() {
        String sql = "SELECT * FROM asset_category ORDER BY category_level, sort_order, id";
        return jdbc.query(sql, new BeanPropertyRowMapper<>(AssetCategory.class));
    }

    public AssetCategory findById(Integer id) {
        String sql = "SELECT * FROM asset_category WHERE id = ?";
        List<AssetCategory> list = jdbc.query(sql, new BeanPropertyRowMapper<>(AssetCategory.class), id);
        return list.isEmpty() ? null : list.get(0);
    }

    public int save(AssetCategory cat) {
        String sql = "INSERT INTO asset_category (parent_id, category_name, category_code, category_level, depreciable_life, sort_order) " +
                     "VALUES (?, ?, ?, ?, ?, ?)";
        return jdbc.update(sql, cat.getParentId(), cat.getCategoryName(), cat.getCategoryCode(),
                cat.getCategoryLevel(), cat.getDepreciableLife(), cat.getSortOrder());
    }

    public int update(AssetCategory cat) {
        String sql = "UPDATE asset_category SET parent_id=?, category_name=?, category_code=?, category_level=?, depreciable_life=?, sort_order=? WHERE id=?";
        return jdbc.update(sql, cat.getParentId(), cat.getCategoryName(), cat.getCategoryCode(),
                cat.getCategoryLevel(), cat.getDepreciableLife(), cat.getSortOrder(), cat.getId());
    }

    public int delete(Integer id) {
        String sql = "DELETE FROM asset_category WHERE id=?";
        return jdbc.update(sql, id);
    }

    public int countByParentId(Integer parentId) {
        String sql = "SELECT COUNT(*) FROM asset_category WHERE parent_id = ?";
        Integer count = jdbc.queryForObject(sql, Integer.class, parentId);
        return count != null ? count : 0;
    }

    public int countByParentIds(List<Integer> parentIds) {
        if (parentIds == null || parentIds.isEmpty()) return 0;
        StringBuilder sb = new StringBuilder("SELECT COUNT(*) FROM asset_category WHERE parent_id IN (");
        for (int i = 0; i < parentIds.size(); i++) {
            sb.append(i > 0 ? ",?" : "?");
        }
        sb.append(")");
        Integer count = jdbc.queryForObject(sb.toString(), Integer.class, parentIds.toArray());
        return count != null ? count : 0;
    }
}
