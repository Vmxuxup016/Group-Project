package com.asset.service;

import com.asset.dao.*;
import com.asset.pojo.*;
import com.asset.util.CodeGenerator;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class PurchaseService {

    private AssetPurchaseDao purchaseDao = new AssetPurchaseDao();
    private AssetPurchaseItemDao itemDao = new AssetPurchaseItemDao();
    private SupplierDao supplierDao = new SupplierDao();
    private AssetDao assetDao = new AssetDao();
    private AssetCategoryDao categoryDao = new AssetCategoryDao();

    public List<AssetPurchase> findAll() {
        return purchaseDao.findAll();
    }

    public AssetPurchase findById(Integer id) {
        return purchaseDao.findById(id);
    }

    public List<AssetPurchaseItem> findItemsByPurchaseId(Integer purchaseId) {
        return itemDao.findByPurchaseId(purchaseId);
    }

    public void save(AssetPurchase purchase, List<AssetPurchaseItem> items) {
        purchase.setPurchaseNo(CodeGenerator.generatePurchaseNo());
        if (purchase.getStatus() == null) {
            purchase.setStatus(1);
        }
        BigDecimal total = BigDecimal.ZERO;
        for (AssetPurchaseItem item : items) {
            BigDecimal subtotal = item.getUnitPrice().multiply(BigDecimal.valueOf(item.getQuantity()));
            item.setTotalPrice(subtotal);
            total = total.add(subtotal);
            item.setReceivedQty(0);
            item.setStatus(1);
        }
        purchase.setTotalAmount(total);
        purchaseDao.save(purchase);
        int purchaseId = purchaseDao.getLastInsertId();
        for (AssetPurchaseItem item : items) {
            item.setPurchaseId(purchaseId);
            itemDao.save(item);
        }
    }

    public void inbound(Integer purchaseId, Map<Integer, Integer> receiveMap) {
        AssetPurchase purchase = purchaseDao.findById(purchaseId);
        List<AssetPurchaseItem> items = itemDao.findByPurchaseId(purchaseId);
        boolean allReceived = true;
        boolean anyReceived = false;
        for (AssetPurchaseItem item : items) {
            int newReceiveQty = receiveMap.getOrDefault(item.getId(), 0);
            int delta = newReceiveQty - item.getReceivedQty();
            if (delta > 0) {
                AssetCategory category = categoryDao.findById(item.getCategoryId());
                int depreciableMonths = category != null && category.getDepreciableLife() != null
                        ? category.getDepreciableLife() : 36;
                for (int i = 0; i < delta; i++) {
                    Asset asset = new Asset();
                    asset.setAssetCode(CodeGenerator.generateAssetCode());
                    asset.setAssetName(item.getAssetName());
                    asset.setCategoryId(item.getCategoryId());
                    asset.setBrand(item.getBrand());
                    asset.setModel(item.getModel());
                    asset.setPurchaseDate(purchase.getPurchaseDate());
                    asset.setPurchasePrice(item.getUnitPrice());
                    asset.setCurrentValue(item.getUnitPrice());
                    asset.setSupplierId(purchase.getSupplierId());
                    asset.setStatus(1);
                    asset.setDepreciableMonths(depreciableMonths);
                    asset.setDepreciatedMonths(0);
                    asset.setDepreciableStartDate(purchase.getPurchaseDate());
                    if (item.getWarrantyMonths() != null && purchase.getPurchaseDate() != null) {
                        LocalDate wd = LocalDate.parse(purchase.getPurchaseDate(), DateTimeFormatter.ISO_LOCAL_DATE)
                                .plusMonths(item.getWarrantyMonths());
                        asset.setWarrantyExpiry(wd.format(DateTimeFormatter.ISO_LOCAL_DATE));
                    }
                    assetDao.save(asset);
                }
            }
            itemDao.updateReceivedQty(item.getId(), newReceiveQty,
                    newReceiveQty >= item.getQuantity() ? 2 : 1);
            if (newReceiveQty >= item.getQuantity()) {
                anyReceived = true;
            } else {
                allReceived = false;
            }
            if (newReceiveQty > 0) anyReceived = true;
        }
        if (allReceived) {
            purchaseDao.updateStatus(purchaseId, 3);
        } else if (anyReceived) {
            purchaseDao.updateStatus(purchaseId, 2);
        }
    }

    public Map<String, Object> getFormData() {
        Map<String, Object> data = new HashMap<>();
        data.put("supplierList", supplierDao.findActive());
        data.put("categoryList", categoryDao.findAll());
        return data;
    }
}
