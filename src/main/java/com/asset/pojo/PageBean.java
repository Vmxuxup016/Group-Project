package com.asset.pojo;

public class PageBean {

    //当前页码（从1开始）
    private int currentPage;

    //每页显示的记录数
    private int pageSize;

    //总记录数
    private int totalCount;

    //总页数（根据 totalCount 和 pageSize 自动计算）
    private int totalPage;

    //无参构造
    public PageBean() {}
    public PageBean(int currentPage, int pageSize, int totalCount) {
        this.currentPage = currentPage;
        this.pageSize = pageSize;
        this.totalCount = totalCount;
        // 总页数 = 向上取整(总记录数 / 每页大小)
        this.totalPage = (int) Math.ceil((double) totalCount / pageSize);
    }

    public int getCurrentPage() { return currentPage; }
    public void setCurrentPage(int currentPage) { this.currentPage = currentPage; }
    public int getPageSize() { return pageSize; }
    public void setPageSize(int pageSize) { this.pageSize = pageSize; }
    public int getTotalCount() { return totalCount; }

    public void setTotalCount(int totalCount) {
        this.totalCount = totalCount;
        // 总页数 = 向上取整(总记录数 / 每页大小)
        this.totalPage = (int) Math.ceil((double) totalCount / pageSize);
    }

    public int getTotalPage() { return totalPage; }
    public void setTotalPage(int totalPage) { this.totalPage = totalPage; }

    public int getOffset() {
        // offset = (当前页 - 1) x 每页大小
        return (currentPage - 1) * pageSize;
    }
}
