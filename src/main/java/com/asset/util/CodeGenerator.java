package com.asset.util;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.concurrent.atomic.AtomicInteger;

public class CodeGenerator {

    private static final AtomicInteger assetSeq = new AtomicInteger(1);
    private static final AtomicInteger purchaseSeq = new AtomicInteger(1);
    private static final AtomicInteger repairSeq = new AtomicInteger(1);
    private static final AtomicInteger scrapSeq = new AtomicInteger(1);
    private static final AtomicInteger inventorySeq = new AtomicInteger(1);

    private static final DateTimeFormatter DF = DateTimeFormatter.ofPattern("yyyyMMdd");

    private static volatile boolean initialized = false;

    public static synchronized void ensureInitialized() {
        if (initialized) return;
        try {
            com.asset.dao.AssetDao assetDao = new com.asset.dao.AssetDao();
            String todayPrefix = "ZC-" + LocalDate.now().format(DF);
            Integer max = assetDao.getMaxAssetCodeSeq(todayPrefix);
            if (max != null && max > 0) {
                assetSeq.set(max + 1);
            } else {
                assetSeq.set(1);
            }
            initialized = true;
        } catch (Exception e) {
            // 数据库不可用时保持默认值
        }
    }

    public static String generateAssetCode() {
        ensureInitialized();
        return String.format("ZC-%s-%04d", LocalDate.now().format(DF), assetSeq.getAndIncrement());
    }

    public static String generatePurchaseNo() {
        return String.format("CG-%s-%04d", LocalDate.now().format(DF), purchaseSeq.getAndIncrement());
    }

    public static String generateRepairNo() {
        return String.format("WX-%s-%04d", LocalDate.now().format(DF), repairSeq.getAndIncrement());
    }

    public static String generateScrapNo() {
        return String.format("BF-%s-%04d", LocalDate.now().format(DF), scrapSeq.getAndIncrement());
    }

    public static String generateInventoryNo() {
        return String.format("PD-%s-%04d", LocalDate.now().format(DF), inventorySeq.getAndIncrement());
    }

    public static void initAssetSeq(int maxSeq) {
        assetSeq.set(maxSeq + 1);
    }

    public static void initPurchaseSeq(int maxSeq) {
        purchaseSeq.set(maxSeq + 1);
    }

    public static void initRepairSeq(int maxSeq) {
        repairSeq.set(maxSeq + 1);
    }

    public static void initScrapSeq(int maxSeq) {
        scrapSeq.set(maxSeq + 1);
    }

    public static void initInventorySeq(int maxSeq) {
        inventorySeq.set(maxSeq + 1);
    }
}
