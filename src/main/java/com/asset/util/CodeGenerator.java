package com.asset.util;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.concurrent.atomic.AtomicInteger;

//编码生成器
public class CodeGenerator {

    private static final AtomicInteger assetSeq = new AtomicInteger(1);
    private static final AtomicInteger purchaseSeq = new AtomicInteger(1);
    private static final AtomicInteger repairSeq = new AtomicInteger(1);
    private static final AtomicInteger scrapSeq = new AtomicInteger(1);
    private static final AtomicInteger inventorySeq = new AtomicInteger(1);

    private static final DateTimeFormatter DF = DateTimeFormatter.ofPattern("yyyyMMdd");

    //生成资产编码：ZC-yyyyMMdd-序号
    public static String generateAssetCode() {
        return String.format("ZC-%s-%04d", LocalDate.now().format(DF), assetSeq.getAndIncrement());
    }

    //生成采购单号：CG-yyyyMMdd-序号
    public static String generatePurchaseNo() {
        return String.format("CG-%s-%04d", LocalDate.now().format(DF), purchaseSeq.getAndIncrement());
    }

    //生成维修单号：WX-yyyyMMdd-序号
    public static String generateRepairNo() {
        return String.format("WX-%s-%04d", LocalDate.now().format(DF), repairSeq.getAndIncrement());
    }

    //生成报废单号：BF-yyyyMMdd-序号
    public static String generateScrapNo() {
        return String.format("BF-%s-%04d", LocalDate.now().format(DF), scrapSeq.getAndIncrement());
    }

    //生成盘点单号：PD-yyyyMMdd-序号
    public static String generateInventoryNo() {
        return String.format("PD-%s-%04d", LocalDate.now().format(DF), inventorySeq.getAndIncrement());
    }

    //初始化编号计数器（根据数据库已有最大值设置）
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
