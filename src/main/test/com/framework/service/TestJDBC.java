package com.framework.service;

import org.junit.Test;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;

/**
 * @auther: 翁筱寒
 * @date: 2020/5/18 09:12
 * @desc: //TODO
 */
public class TestJDBC {
    // MySQL 8.0 以下版本 - JDBC 驱动名及数据库 URL
    static final String JDBC_DRIVER = "com.mysql.jdbc.Driver";
    static final String DB_URL = "jdbc:mysql://localhost:3306/duxiaoyue";


    // 数据库的用户名与密码，需要根据自己的设置
    static final String USER = "root";
    static final String PASS = "root";

    @Test
    public void test() throws Exception {
        // 注册 JDBC 驱动
        Class.forName(JDBC_DRIVER);

        // 打开链接
        System.out.println("连接数据库...");
        Connection conn = DriverManager.getConnection(DB_URL,USER,PASS);
        // 执行查询
        System.out.println(" 实例化Statement对象...");
        Statement stmt = conn.createStatement();
        String sql;
       for (int x=0;x<4000000;x++){
           sql = "INSERT  INTO user_info (user_name,pass_word) VALUES ()";
           stmt.execute(sql);
       }


    }
}
