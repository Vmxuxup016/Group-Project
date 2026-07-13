package com.asset;

import com.alibaba.druid.pool.DruidDataSource;
import org.springframework.jdbc.core.JdbcTemplate;

import java.io.InputStream;
import java.util.Properties;

public class JdbcTemplateFactory {
    private static DruidDataSource dataSource;
    private static JdbcTemplate jdbcTemplate;
    static {
        try {
            // 1. 加载数据库配置文件
            Properties props = new Properties();
            InputStream is = JdbcTemplateFactory.class.getClassLoader().getResourceAsStream("db.properties");
            props.load(is);

            // 2. 创建 Druid 数据源并配置基础连接信息
            dataSource = new DruidDataSource();
            dataSource.setDriverClassName(props.getProperty("driverClassName"));  // 数据库驱动类名
            dataSource.setUrl(props.getProperty("url"));                          // 数据库连接URL
            dataSource.setUsername(props.getProperty("username"));                // 数据库用户名
            dataSource.setPassword(props.getProperty("password"));                // 数据库密码

            // 3. 连接池参数配置
            dataSource.setInitialSize(Integer.parseInt(props.getProperty("initialSize", "5")));   // 初始化连接数
            dataSource.setMinIdle(Integer.parseInt(props.getProperty("minIdle", "5")));           // 最小空闲连接数
            dataSource.setMaxActive(Integer.parseInt(props.getProperty("maxActive", "20")));      // 最大活跃连接数
            dataSource.setMaxWait(Long.parseLong(props.getProperty("maxWait", "60000")));         // 获取连接最大等待时间(ms)

            // 4. 连接有效性检测配置
            dataSource.setValidationQuery("SELECT 1");  // 用于检测连接是否有效的SQL
            dataSource.setTestWhileIdle(true);           // 空闲时检测连接有效性，自动剔除无效连接

            // 5. Druid 监控配置（SQL监控 + 慢SQL记录）
            try {
                dataSource.setFilters("stat,wall");  // stat: SQL监控统计  wall: SQL防火墙
                dataSource.setConnectionProperties("druid.stat.slowSqlMillis=2000");  // 慢SQL阈值：超过2秒记录
            } catch (Exception e) {
                // stat/wall 过滤器初始化失败不影响核心功能，仅监控不可用
            }

            // 6. 基于配置好的数据源创建 JdbcTemplate
            jdbcTemplate = new JdbcTemplate(dataSource);
        } catch (Exception e) {
            // 连接池初始化失败，直接抛出运行时异常终止启动
            throw new RuntimeException("数据库连接池初始化失败", e);
        }
    }
    public static JdbcTemplate getJdbcTemplate() {
        return jdbcTemplate;
    }
}
