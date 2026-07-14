package com.asset.service;

import com.asset.dao.AssetRepairDao;
import com.asset.pojo.AssetRepair;
import com.asset.util.CodeGenerator;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class RepairService {

    private AssetRepairDao repairDao = new AssetRepairDao();

    public List<AssetRepair> findAll() {
        return repairDao.findAll();
    }

    public AssetRepair findById(Integer id) {
        return repairDao.findById(id);
    }

    public void save(AssetRepair repair) {
        repair.setRepairNo(CodeGenerator.generateRepairNo());
        if (repair.getRepairStatus() == null) {
            repair.setRepairStatus(1);
        }
        repairDao.save(repair);
    }

    public void update(AssetRepair repair) {
        repairDao.update(repair);
    }

    public Map<String, Object> getStats() {
        Map<String, Object> stats = new HashMap<>();
        List<AssetRepair> all = repairDao.findAll();
        int wait = 0, inProgress = 0, done = 0, unfixable = 0;
        for (AssetRepair r : all) {
            if (r.getRepairStatus() != null) {
                switch (r.getRepairStatus()) {
                    case 1: wait++; break;
                    case 2: inProgress++; break;
                    case 3: done++; break;
                    case 4: unfixable++; break;
                }
            }
        }
        stats.put("waitRepair", wait);
        stats.put("inRepair", inProgress);
        stats.put("doneRepair", done);
        stats.put("unfixable", unfixable);
        return stats;
    }
}

