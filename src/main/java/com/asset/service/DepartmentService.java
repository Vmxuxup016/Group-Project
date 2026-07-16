package com.asset.service;

import com.asset.dao.DepartmentDao;
import com.asset.pojo.Department;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class DepartmentService {

    private DepartmentDao deptDao = new DepartmentDao();

    public List<Department> findAll() {
        return deptDao.findAll();
    }

    public Department findById(Integer id) {
        return deptDao.findById(id);
    }

    public void save(Department dept) {
        deptDao.save(dept);
    }

    public String validate(Department dept) {
        if (dept.getDeptName() == null || dept.getDeptName().trim().isEmpty()) {
            return "部门名称不能为空";
        }
        if (!dept.getDeptName().trim().matches("^[\\u4e00-\\u9fa5]+$")) {
            return "部门名称必须全部为汉字，不能包含字母、数字或特殊字符";
        }
        Department existing = deptDao.findByDeptName(dept.getDeptName().trim());
        if (existing != null) {
            return "部门名称「" + dept.getDeptName().trim() + "」已存在，请勿重复添加";
        }
        if (dept.getDeptCode() == null || dept.getDeptCode().trim().isEmpty()) {
            return "部门编码不能为空";
        }
        return null;
    }

    public void update(Department dept) {
        deptDao.update(dept);
    }

    public boolean delete(Integer id) {
        int childCount = deptDao.countByParentId(id);
        if (childCount > 0) {
            return false;
        }
        deptDao.delete(id);
        return true;
    }

    public List<Map<String, Object>> buildDeptTreeList() {
        List<Department> allDepts = deptDao.findAll();
        List<Map<String, Object>> treeList = new ArrayList<>();
        buildTreeRecursive(allDepts, 0, 0, treeList);
        return treeList;
    }

    private void buildTreeRecursive(List<Department> allDepts, Integer parentId, int depth, List<Map<String, Object>> treeList) {
        for (Department dept : allDepts) {
            if (dept.getParentId() != null && dept.getParentId().equals(parentId)) {
                Map<String, Object> item = new HashMap<>();
                item.put("dept", dept);
                item.put("depth", depth);

                StringBuilder path = new StringBuilder();
                for (int i = 0; i < depth; i++) path.append("— ");
                path.append(dept.getDeptName());
                item.put("displayName", path.toString());

                treeList.add(item);
                buildTreeRecursive(allDepts, dept.getId(), depth + 1, treeList);
            }
        }
    }
}
