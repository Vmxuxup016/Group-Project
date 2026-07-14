package com.asset.service;

import com.asset.dao.AssetDao;
import com.asset.dao.AssetDepreciationDao;
import com.asset.pojo.Asset;
import com.asset.pojo.AssetDepreciation;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class DepreciationService {

    private AssetDepreciationDao depreciationDao = new AssetDepreciationDao();
    private AssetDao assetDao = new AssetDao();

    public List<AssetDepreciation> findAll() {
        return depreciationDao.findAll();
    }

    public Map<String, Object> getDashboardData() {
        Map<String, Object> data = new HashMap<>();
        List<AssetDepreciation> list = depreciationDao.findAll();
        BigDecimal totalOriginal = BigDecimal.ZERO;
        BigDecimal totalAccumulated = BigDecimal.ZERO;
        BigDecimal totalNet = BigDecimal.ZERO;
        for (AssetDepreciation d : list) {
            if (d.getOriginalValue() != null) totalOriginal = totalOriginal.add(d.getOriginalValue());
            if (d.getAccumulatedDepreciation() != null) totalAccumulated = totalAccumulated.add(d.getAccumulatedDepreciation());
            if (d.getNetValue() != null) totalNet = totalNet.add(d.getNetValue());
        }
        data.put("totalOriginal", totalOriginal);
        data.put("totalAccumulated", totalAccumulated);
        data.put("totalNet", totalNet);
        return data;
    }

    public void calculateMonthly() {
        String month = LocalDate.now().format(DateTimeFormatter.ofPattern("yyyy-MM"));
        String today = LocalDate.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd"));

        List<Asset> assets = assetDao.findList(null, null, null, null, 0, 99999);
        for (Asset asset : assets) {
            if (asset.getStatus() != null && asset.getStatus() == 4) continue;
            if (asset.getDepreciableMonths() == null || asset.getDepreciableMonths() <= 0) continue;
            if (asset.getDepreciatedMonths() != null && asset.getDepreciatedMonths() >= asset.getDepreciableMonths()) continue;

            int depreciatedMonths = (asset.getDepreciatedMonths() != null ? asset.getDepreciatedMonths() : 0) + 1;
            int remainingMonths = asset.getDepreciableMonths() - depreciatedMonths;
            BigDecimal monthlyAmount = asset.getPurchasePrice().divide(
                    BigDecimal.valueOf(asset.getDepreciableMonths()), 2, RoundingMode.HALF_UP);
            BigDecimal accumulated = (asset.getCurrentValue() != null ? asset.getPurchasePrice().subtract(asset.getCurrentValue()) : BigDecimal.ZERO).add(monthlyAmount);
            BigDecimal netValue = asset.getPurchasePrice().subtract(accumulated);
            if (netValue.compareTo(BigDecimal.ZERO) < 0) {
                netValue = BigDecimal.ZERO;
                remainingMonths = 0;
            }

            AssetDepreciation dep = new AssetDepreciation();
            dep.setAssetId(asset.getId());
            dep.setDepreciationDate(today);
            dep.setOriginalValue(asset.getPurchasePrice());
            dep.setDepreciationAmount(monthlyAmount);
            dep.setAccumulatedDepreciation(accumulated);
            dep.setNetValue(netValue);
            dep.setRemainingMonths(remainingMonths);
            depreciationDao.save(dep);

            asset.setDepreciatedMonths(depreciatedMonths);
            asset.setCurrentValue(netValue);
            assetDao.update(asset);
        }
    }
}
