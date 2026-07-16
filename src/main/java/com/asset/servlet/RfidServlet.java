package com.asset.servlet;

import com.asset.dao.AssetDao;
import com.asset.pojo.Asset;
import com.asset.pojo.AssetRfidTag;
import com.asset.service.RfidService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/rfid/*")
public class RfidServlet extends HttpServlet {

    private RfidService rfidService = new RfidService();
    private AssetDao assetDao = new AssetDao();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String path = req.getPathInfo();
        if (path == null) path = "/list";

        switch (path) {
            case "/list":
                req.setAttribute("rfidList", rfidService.findAll());
                req.setAttribute("pageTitle", "RFID管理");
                req.getRequestDispatcher("/views/rfid/list.jsp").forward(req, resp);
                break;

            case "/add":
                req.setAttribute("pageTitle", "RFID管理");
                req.getRequestDispatcher("/views/rfid/add.jsp").forward(req, resp);
                break;

            case "/detail":
                Integer detailId = parseInt(req.getParameter("id"));
                if (detailId != null) {
                    AssetRfidTag tag = rfidService.findById(detailId);
                    req.setAttribute("tag", tag);
                    // 获取所有可绑定的资产（未被绑定且非报废的资产）
                    List<Asset> unboundAssets = assetDao.findList(null, null, null, null, 0, 99999);
                    req.setAttribute("assetList", unboundAssets);
                }
                req.setAttribute("pageTitle", "RFID管理");
                req.getRequestDispatcher("/views/rfid/detail.jsp").forward(req, resp);
                break;

            case "/bind":
                Integer tagId = parseInt(req.getParameter("id"));
                Integer assetId = parseInt(req.getParameter("assetId"));
                if (tagId != null && assetId != null) {
                    rfidService.bind(tagId, assetId);
                    // 同步更新 asset 表的 rfid_tag 字段
                    AssetRfidTag tag = rfidService.findById(tagId);
                    if (tag != null) {
                        Asset asset = assetDao.findById(assetId);
                        if (asset != null) {
                            asset.setRfidTag(tag.getTagCode());
                            assetDao.update(asset);
                        }
                    }
                }
                resp.sendRedirect(req.getContextPath() + "/rfid/detail?id=" + tagId);
                break;

            case "/unbind":
                Integer unbindId = parseInt(req.getParameter("id"));
                if (unbindId != null) {
                    // 解绑前清除 asset 表的 rfid_tag
                    AssetRfidTag unbindTag = rfidService.findById(unbindId);
                    if (unbindTag != null && unbindTag.getAssetId() != null) {
                        Asset unbindAsset = assetDao.findById(unbindTag.getAssetId());
                        if (unbindAsset != null) {
                            unbindAsset.setRfidTag(null);
                            assetDao.update(unbindAsset);
                        }
                    }
                    rfidService.unbind(unbindId);
                }
                resp.sendRedirect(req.getContextPath() + "/rfid/detail?id=" + unbindId);
                break;

            case "/delete":
                Integer deleteId = parseInt(req.getParameter("id"));
                if (deleteId != null) {
                    // 删除前先解绑关联资产
                    AssetRfidTag deleteTag = rfidService.findById(deleteId);
                    if (deleteTag != null && deleteTag.getAssetId() != null) {
                        Asset deleteAsset = assetDao.findById(deleteTag.getAssetId());
                        if (deleteAsset != null) {
                            deleteAsset.setRfidTag(null);
                            assetDao.update(deleteAsset);
                        }
                    }
                    rfidService.delete(deleteId);
                }
                resp.sendRedirect(req.getContextPath() + "/rfid/list");
                break;

            case "/scan":
                // GET 兜底：手动修复 Tomcat 默认 ISO-8859-1 解码导致的中文乱码
                Integer scanId = parseInt(req.getParameter("id"));
                if (scanId != null) {
                    String location = req.getParameter("location");
                    if (location != null) {
                        try { location = new String(location.getBytes("ISO-8859-1"), "UTF-8"); }
                        catch (Exception ignored) {}
                    } else {
                        location = "盘点扫描";
                    }
                    rfidService.updateScanInfo(scanId, location);
                }
                resp.sendRedirect(req.getContextPath() + "/rfid/detail?id=" + scanId);
                break;

            case "/batchScan":
                rfidService.batchScan();
                resp.sendRedirect(req.getContextPath() + "/rfid/list");
                break;

            default:
                resp.sendRedirect(req.getContextPath() + "/rfid/list");
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        req.setCharacterEncoding("UTF-8");
        String path = req.getPathInfo();

        if ("/save".equals(path)) {
            AssetRfidTag tag = new AssetRfidTag();
            tag.setTagCode(req.getParameter("tagCode"));
            rfidService.save(tag);
            resp.sendRedirect(req.getContextPath() + "/rfid/list");
        } else if ("/scan".equals(path)) {
            Integer scanId = parseInt(req.getParameter("id"));
            if (scanId != null) {
                String location = req.getParameter("location");
                if (location == null || location.isEmpty()) location = "盘点扫描";
                rfidService.updateScanInfo(scanId, location);
                resp.sendRedirect(req.getContextPath() + "/rfid/detail?id=" + scanId);
            } else {
                resp.sendRedirect(req.getContextPath() + "/rfid/list");
            }
        } else if ("/updateStatus".equals(path)) {
            Integer id = parseInt(req.getParameter("id"));
            Integer status = parseInt(req.getParameter("status"));
            if (id != null && status != null) {
                rfidService.updateStatus(id, status);
            }
            resp.sendRedirect(req.getContextPath() + "/rfid/detail?id=" + id);
        } else {
            resp.sendRedirect(req.getContextPath() + "/rfid/list");
        }
    }

    private Integer parseInt(String str) { return parseInt(str, null); }
    private Integer parseInt(String str, Integer def) {
        if (str == null || str.isEmpty()) return def;
        try { return Integer.parseInt(str); } catch (Exception e) { return def; }
    }
}
