package com.asset.service;

import com.asset.dao.AssetScrapDao;
import com.asset.pojo.AssetScrap;
import com.asset.util.CodeGenerator;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.List;

public class ScrapService {

    private AssetScrapDao scrapDao = new AssetScrapDao();

    public List<AssetScrap> findAll() {
        return scrapDao.findAll();
    }

    public AssetScrap findById(Integer id) {
        return scrapDao.findById(id);
    }

    public void save(AssetScrap scrap) {
        scrap.setScrapNo(CodeGenerator.generateScrapNo());
        if (scrap.getStatus() == null) {
            scrap.setStatus(1);
        }
        if (scrap.getOriginalValue() == null) {
            scrap.setOriginalValue(BigDecimal.ZERO);
        }
        scrapDao.save(scrap);
    }

    public void approve(Integer id, boolean pass) {
        scrapDao.updateStatus(id, pass ? 2 : 4);
    }

    public void execute(Integer id, Integer executorId, BigDecimal scrapValue) {
        String today = LocalDate.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd"));
        scrapDao.executeScrap(id, executorId, today, 1, scrapValue != null ? scrapValue : BigDecimal.ZERO);
    }
}
