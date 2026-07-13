package com.asset.pojo;

import java.util.ArrayList;
import java.util.List;

/**
 * 分页工具类
 * 支持 JSP 视图中的分页组件渲染
 */
public class PageBean<T> {

    private int pageNum;        // 当前页码
    private int pageSize;       // 每页大小
    private int total;          // 总记录数
    private int pages;          // 总页数
    private int prePage;        // 上一页
    private int nextPage;       // 下一页
    private boolean hasPreviousPage;  // 是否有上一页
    private boolean hasNextPage;      // 是否有下一页
    private List<Integer> navigatepageNums; // 导航页码列表
    private List<T> list;       // 当前页数据

    public PageBean() {}

    public PageBean(int pageNum, int pageSize, int total) {
        this.pageNum = pageNum > 0 ? pageNum : 1;
        this.pageSize = pageSize > 0 ? pageSize : 10;
        this.total = total;
        this.pages = (int) Math.ceil((double) total / this.pageSize);
        if (this.pages < 1) this.pages = 1;
        this.prePage = this.pageNum > 1 ? this.pageNum - 1 : 1;
        this.nextPage = this.pageNum < this.pages ? this.pageNum + 1 : this.pages;
        this.hasPreviousPage = this.pageNum > 1;
        this.hasNextPage = this.pageNum < this.pages;
        this.navigatepageNums = buildNavigateNums();
        this.list = new ArrayList<>();
    }

    private List<Integer> buildNavigateNums() {
        List<Integer> nums = new ArrayList<>();
        int start = Math.max(1, pageNum - 2);
        int end = Math.min(pages, pageNum + 2);
        for (int i = start; i <= end; i++) {
            nums.add(i);
        }
        return nums;
    }

    public int getOffset() {
        return (pageNum - 1) * pageSize;
    }

    // Getters & Setters
    public int getPageNum() { return pageNum; }
    public void setPageNum(int pageNum) { this.pageNum = pageNum; }
    public int getPageSize() { return pageSize; }
    public void setPageSize(int pageSize) { this.pageSize = pageSize; }
    public int getTotal() { return total; }
    public void setTotal(int total) {
        this.total = total;
        this.pages = (int) Math.ceil((double) total / this.pageSize);
        if (this.pages < 1) this.pages = 1;
        this.prePage = this.pageNum > 1 ? this.pageNum - 1 : 1;
        this.nextPage = this.pageNum < this.pages ? this.pageNum + 1 : this.pages;
        this.hasPreviousPage = this.pageNum > 1;
        this.hasNextPage = this.pageNum < this.pages;
        this.navigatepageNums = buildNavigateNums();
    }
    public int getPages() { return pages; }
    public void setPages(int pages) { this.pages = pages; }
    public int getPrePage() { return prePage; }
    public void setPrePage(int prePage) { this.prePage = prePage; }
    public int getNextPage() { return nextPage; }
    public void setNextPage(int nextPage) { this.nextPage = nextPage; }
    public boolean getHasPreviousPage() { return hasPreviousPage; }
    public void setHasPreviousPage(boolean hasPreviousPage) { this.hasPreviousPage = hasPreviousPage; }
    public boolean getHasNextPage() { return hasNextPage; }
    public void setHasNextPage(boolean hasNextPage) { this.hasNextPage = hasNextPage; }
    public List<Integer> getNavigatepageNums() { return navigatepageNums; }
    public void setNavigatepageNums(List<Integer> navigatepageNums) { this.navigatepageNums = navigatepageNums; }
    public List<T> getList() { return list; }
    public void setList(List<T> list) { this.list = list; }
}
