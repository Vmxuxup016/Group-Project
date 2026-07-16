package com.asset.service;

import com.asset.dao.AssetDao;
import org.springframework.jdbc.core.JdbcTemplate;
import com.asset.dao.JdbcTemplateFactory;

import java.sql.Timestamp;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.*;

public class DashboardService {

    private AssetDao assetDao = new AssetDao();
    private JdbcTemplate jdbc = JdbcTemplateFactory.getJdbcTemplate();

    public Map<String, Object> getDashboardData(String period) {
        Map<String, Object> data = new HashMap<>();
        int totalAsset = assetDao.count(null, null, null, null);
        int inUseAsset = assetDao.countByStatus(2);
        int repairingAsset = assetDao.countByStatus(3);
        int scrapAsset = assetDao.countByStatus(4);
        int stockCount = assetDao.countByStatus(1);

        // 顶部统计卡片
        data.put("totalAsset", totalAsset);
        data.put("inUseAsset", inUseAsset);
        data.put("repairingAsset", repairingAsset);
        data.put("scrapAsset", scrapAsset);

        // 状态分布进度条（JSP使用 inUseCount/repairCount/scrapCount）
        data.put("stockCount", stockCount);
        data.put("inUseCount", inUseAsset);
        data.put("repairCount", repairingAsset);
        data.put("scrapCount", scrapAsset);

        // 百分比计算
        if (totalAsset > 0) {
            data.put("stockPercent", String.format("%.1f", stockCount * 100.0 / totalAsset));
            data.put("inUsePercent", String.format("%.1f", inUseAsset * 100.0 / totalAsset));
            data.put("repairPercent", String.format("%.1f", repairingAsset * 100.0 / totalAsset));
            data.put("scrapPercent", String.format("%.1f", scrapAsset * 100.0 / totalAsset));
            // 在用资产占比（给统计卡片用）
            data.put("inUsePercentStr", String.format("%.1f", inUseAsset * 100.0 / totalAsset));
        } else {
            data.put("stockPercent", "0");
            data.put("inUsePercent", "0");
            data.put("repairPercent", "0");
            data.put("scrapPercent", "0");
            data.put("inUsePercentStr", "0");
        }

        // 资产总数趋势（较上月/上季/上年变化）
        int prevTotal = countPrevPeriodAssets(period);
        int totalDiff = totalAsset - prevTotal;
        data.put("totalDiff", totalDiff);
        data.put("totalDiffAbs", Math.abs(totalDiff));
        data.put("totalDiffTrend", totalDiff >= 0 ? "up" : "down");
        String periodLabel = "month".equals(period) ? "上月" : ("quarter".equals(period) ? "上季" : "上年");
        data.put("periodLabel", periodLabel);

        // 维修中资产趋势
        int prevRepairing = countPrevPeriodRepairing(period);
        int repairDiff = repairingAsset - prevRepairing;
        data.put("repairDiff", repairDiff);
        data.put("repairDiffAbs", Math.abs(repairDiff));
        data.put("repairDiffTrend", repairDiff >= 0 ? "up" : "down");
        String weekOrPeriod = "month".equals(period) ? "上月" : periodLabel;
        data.put("weekOrPeriod", weekOrPeriod);

        // 待审批报废数量
        int pendingScrapCount = countPendingScrap();
        data.put("pendingScrapCount", pendingScrapCount);

        // 按分类统计
        List<Object[]> categoryStatsRaw = assetDao.countGroupByCategory();
        List<Map<String, Object>> categoryStats = new ArrayList<>();
        for (Object[] row : categoryStatsRaw) {
            Map<String, Object> stat = new HashMap<>();
            stat.put("categoryName", row[0]);
            stat.put("count", row[1]);
            stat.put("originalValue", row[2]);
            stat.put("netValue", row[3]);
            stat.put("percent", totalAsset > 0 ? String.format("%.1f", ((Integer)row[1]) * 100.0 / totalAsset) : "0");
            categoryStats.add(stat);
        }
        data.put("categoryStats", categoryStats);

        // 最近动态
        data.put("recentLogs", getRecentLogs());

        return data;
    }

    /**
     * 获取上期资产总数
     */
    private int countPrevPeriodAssets(String period) {
        String dateCondition = getPrevPeriodCondition(period);
        // 统计上期末的资产总数（未报废状态：1,2,3,5）
        String sql = "SELECT COUNT(*) FROM asset WHERE status IN (1,2,3,5) " + dateCondition;
        try {
            Integer count = jdbc.queryForObject(sql, Integer.class);
            return count != null ? count : 0;
        } catch (Exception e) {
            return 0;
        }
    }

    /**
     * 获取上期维修中资产数
     */
    private int countPrevPeriodRepairing(String period) {
        String dateCondition = getPrevPeriodCondition(period);
        String sql = "SELECT COUNT(*) FROM asset WHERE status = 3 " + dateCondition;
        try {
            Integer count = jdbc.queryForObject(sql, Integer.class);
            return count != null ? count : 0;
        } catch (Exception e) {
            return 0;
        }
    }

    /**
     * 根据period生成上一周期的日期过滤条件
     */
    private String getPrevPeriodCondition(String period) {
        LocalDate today = LocalDate.now();
        DateTimeFormatter fmt = DateTimeFormatter.ofPattern("yyyy-MM-dd");
        String cutoff = "";
        switch (period) {
            case "quarter":
                cutoff = today.minusMonths(3).format(fmt);
                break;
            case "year":
                cutoff = today.minusYears(1).format(fmt);
                break;
            default: // month
                cutoff = today.minusMonths(1).format(fmt);
                break;
        }
        return "AND create_time < '" + cutoff + "'";
    }

    /**
     * 查询待审批报废数量
     */
    private int countPendingScrap() {
        String sql = "SELECT COUNT(*) FROM asset_scrap WHERE status = 1";
        try {
            Integer count = jdbc.queryForObject(sql, Integer.class);
            return count != null ? count : 0;
        } catch (Exception e) {
            return 0;
        }
    }

    /**
     * 获取最近动态（资产/维修/领用/报废四项，各取最新一条）
     * 分别查询四张表，在Java中合并按时间排序
     */
    private List<Map<String, Object>> getRecentLogs() {
        List<Map<String, Object>> logs = new ArrayList<>();
        Date now = new Date();

        // 1. 新增资产（最新1条）
        try {
            String sql = "SELECT a.id, a.create_time, a.asset_name, "
                + "d.dept_name "
                + "FROM asset a "
                + "LEFT JOIN department d ON a.department_id = d.id "
                + "ORDER BY a.create_time DESC LIMIT 1";
            List<Map<String, Object>> rows = jdbc.queryForList(sql);
            for (Map<String, Object> row : rows) {
                Map<String, Object> log = new HashMap<>();
                log.put("action", "新增资产");
                log.put("iconBg", "bg-blue-100");
                log.put("icon", "fa-plus-circle");
                log.put("iconColor", "text-blue-600");
                log.put("target", getStr(row, "asset_name"));
                log.put("timeAgo", formatTimeAgo(getTimestamp(row, "create_time"), now));
                String assetDept = getStr(row, "dept_name");
                log.put("deptName", "-".equals(assetDept) ? "在库" : assetDept);
                log.put("createTime", getTimestamp(row, "create_time"));
                logs.add(log);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        // 2. 维修（最新1条）
        try {
            String sql = "SELECT r.id, r.create_time, r.repair_status, "
                + "a.asset_name, d.dept_name "
                + "FROM asset_repair r "
                + "LEFT JOIN asset a ON r.asset_id = a.id "
                + "LEFT JOIN department d ON r.report_dept_id = d.id "
                + "ORDER BY r.create_time DESC LIMIT 1";
            List<Map<String, Object>> rows = jdbc.queryForList(sql);
            for (Map<String, Object> row : rows) {
                Map<String, Object> log = new HashMap<>();
                Integer repairStatus = getInt(row, "repair_status");
                if (repairStatus != null && repairStatus == 3) {
                    log.put("action", "维修完成");
                    log.put("iconBg", "bg-amber-100");
                    log.put("icon", "fa-tools");
                    log.put("iconColor", "text-amber-600");
                } else {
                    log.put("action", "报修");
                    log.put("iconBg", "bg-orange-100");
                    log.put("icon", "fa-wrench");
                    log.put("iconColor", "text-orange-600");
                }
                log.put("target", getStr(row, "asset_name"));
                log.put("timeAgo", formatTimeAgo(getTimestamp(row, "create_time"), now));
                log.put("deptName", getStr(row, "dept_name"));
                log.put("createTime", getTimestamp(row, "create_time"));
                logs.add(log);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        // 3. 领用/归还/调拨（最新1条）
        try {
            String sql = "SELECT r.id, r.create_time, r.operation_type, "
                + "a.asset_name, d.dept_name "
                + "FROM asset_use_record r "
                + "LEFT JOIN asset a ON r.asset_id = a.id "
                + "LEFT JOIN department d ON r.to_dept_id = d.id "
                + "ORDER BY r.create_time DESC LIMIT 1";
            List<Map<String, Object>> rows = jdbc.queryForList(sql);
            for (Map<String, Object> row : rows) {
                Map<String, Object> log = new HashMap<>();
                Integer opType = getInt(row, "operation_type");
                if (opType != null && opType == 1) {
                    log.put("action", "领用");
                    log.put("iconBg", "bg-emerald-100");
                    log.put("icon", "fa-hand-holding");
                    log.put("iconColor", "text-emerald-600");
                } else if (opType != null && opType == 2) {
                    log.put("action", "归还");
                    log.put("iconBg", "bg-cyan-100");
                    log.put("icon", "fa-rotate-left");
                    log.put("iconColor", "text-cyan-600");
                } else {
                    log.put("action", "调拨");
                    log.put("iconBg", "bg-purple-100");
                    log.put("icon", "fa-exchange-alt");
                    log.put("iconColor", "text-purple-600");
                }
                log.put("target", getStr(row, "asset_name"));
                log.put("timeAgo", formatTimeAgo(getTimestamp(row, "create_time"), now));
                log.put("deptName", getStr(row, "dept_name"));
                log.put("createTime", getTimestamp(row, "create_time"));
                logs.add(log);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        // 4. 报废（最新1条）
        try {
            String sql = "SELECT s.id, s.create_time, s.status, "
                + "a.asset_name, d.dept_name "
                + "FROM asset_scrap s "
                + "LEFT JOIN asset a ON s.asset_id = a.id "
                + "LEFT JOIN department d ON a.department_id = d.id "
                + "ORDER BY s.create_time DESC LIMIT 1";
            List<Map<String, Object>> rows = jdbc.queryForList(sql);
            for (Map<String, Object> row : rows) {
                Map<String, Object> log = new HashMap<>();
                Integer scrapStatus = getInt(row, "status");
                if (scrapStatus != null && scrapStatus == 3) {
                    log.put("action", "已报废");
                    log.put("iconBg", "bg-rose-100");
                    log.put("icon", "fa-trash-alt");
                    log.put("iconColor", "text-rose-600");
                } else {
                    log.put("action", "报废审批");
                    log.put("iconBg", "bg-red-100");
                    log.put("icon", "fa-file-circle-check");
                    log.put("iconColor", "text-red-600");
                }
                log.put("target", getStr(row, "asset_name"));
                log.put("timeAgo", formatTimeAgo(getTimestamp(row, "create_time"), now));
                String scrapDept = getStr(row, "dept_name");
                log.put("deptName", "-".equals(scrapDept) ? "已报废" : scrapDept);
                log.put("createTime", getTimestamp(row, "create_time"));
                logs.add(log);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        // 按时间倒序排列
        logs.sort((a, b) -> {
            Timestamp ta = (Timestamp) a.get("createTime");
            Timestamp tb = (Timestamp) b.get("createTime");
            if (ta == null && tb == null) return 0;
            if (ta == null) return 1;
            if (tb == null) return -1;
            return tb.compareTo(ta);
        });
        // 移除排序用的临时字段
        for (Map<String, Object> log : logs) {
            log.remove("createTime");
        }

        return logs;
    }

    /** 安全地从Map获取整数值 */
    private Integer getInt(Map<String, Object> map, String key) {
        Object val = map.get(key);
        if (val instanceof Integer) return (Integer) val;
        if (val instanceof Long) return ((Long) val).intValue();
        if (val instanceof Number) return ((Number) val).intValue();
        return null;
    }

    /** 安全地从Map获取字符串值 */
    private String getStr(Map<String, Object> map, String key) {
        Object val = map.get(key);
        return val != null ? val.toString() : "-";
    }

    /** 安全地从Map获取Timestamp值（兼容MySQL Connector/J 8.x返回的LocalDateTime） */
    private Timestamp getTimestamp(Map<String, Object> map, String key) {
        Object val = map.get(key);
        if (val instanceof Timestamp) return (Timestamp) val;
        if (val instanceof java.sql.Date) return new Timestamp(((java.sql.Date) val).getTime());
        if (val instanceof java.util.Date) return new Timestamp(((java.util.Date) val).getTime());
        if (val instanceof LocalDateTime) return Timestamp.valueOf((LocalDateTime) val);
        if (val instanceof LocalDate) return Timestamp.valueOf(((LocalDate) val).atStartOfDay());
        if (val instanceof String) {
            try { return Timestamp.valueOf((String) val); } catch (Exception ignored) {}
        }
        return null;
    }

    /**
     * 格式化时间为"XX分钟前"、"XX小时前"、"XX天前"
     */
    private String formatTimeAgo(Timestamp createTime, Date now) {
        if (createTime == null) return "-";
        long diffMs = now.getTime() - createTime.getTime();
        long diffMinutes = diffMs / (1000 * 60);
        if (diffMinutes < 1) return "刚刚";
        if (diffMinutes < 60) return diffMinutes + "分钟前";
        long diffHours = diffMinutes / 60;
        if (diffHours < 24) return diffHours + "小时前";
        long diffDays = diffHours / 24;
        return diffDays + "天前";
    }
}
