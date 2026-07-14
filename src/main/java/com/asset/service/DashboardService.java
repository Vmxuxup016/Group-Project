package com.asset.service;

import com.asset.dao.AssetDao;
import com.asset.dao.AssetCategoryDao;
import com.asset.dao.AssetRepairDao;
import com.asset.dao.AssetScrapDao;

import java.math.BigDecimal;
import java.util.*;

public class DashboardService {

    private AssetDao assetDao = new AssetDao();

    public Map<String, Object> getDashboardData() {
        Map<String, Object> data = new HashMap<>();
        int totalAsset = assetDao.count(null, null, null, null) ;
        int inUseAsset = assetDao.countByStatus(2);
        int repairingAsset = assetDao.countByStatus(3);
        int scrapAsset = assetDao.countByStatus(4);
        int stockCount = assetDao.countByStatus(1);
        int transferCount = assetDao.countByStatus(5);

        data.put("totalAsset", totalAsset);
        data.put("inUseAsset", inUseAsset);
        data.put("repairingAsset", repairingAsset);
        data.put("scrapAsset", scrapAsset);
        data.put("stockCount", stockCount);

        if (totalAsset > 0) {
            data.put("stockPercent", String.format("%.1f", stockCount * 100.0 / totalAsset));
            data.put("inUsePercent", String.format("%.1f", inUseAsset * 100.0 / totalAsset));
            data.put("repairPercent", String.format("%.1f", repairingAsset * 100.0 / totalAsset));
            data.put("scrapPercent", String.format("%.1f", scrapAsset * 100.0 / totalAsset));
        } else {
            data.put("stockPercent", "0");
            data.put("inUsePercent", "0");
            data.put("repairPercent", "0");
            data.put("scrapPercent", "0");
        }

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

        return data;
    }
}