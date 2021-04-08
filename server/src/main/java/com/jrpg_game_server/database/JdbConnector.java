package com.jrpg_game_server.database;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Properties;

public class JdbConnector {
    private Connection connection;

    public JdbConnector(String dbUrl, String user, String pwd) throws SQLException {
        Properties properties = new Properties();
        properties.setProperty("user", user);
        properties.setProperty("password", pwd);
        properties.setProperty("ssl","false");

        connection = DriverManager.getConnection(dbUrl, properties);
    }

}
