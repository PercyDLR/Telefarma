package com.example.telefarma.daos;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public abstract class BaseDao {

    public Connection getConnection() throws SQLException {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }

        final String user = "percy";
        final String pass = "percy";
        final String url = "jdbc:mysql://localhost:3306/telefarma";

        return DriverManager.getConnection(url, user, pass);
    }

}
