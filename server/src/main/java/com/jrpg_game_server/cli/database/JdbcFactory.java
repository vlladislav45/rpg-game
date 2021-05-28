package com.jrpg_game_server.cli.database;

import org.apache.log4j.Logger;

import java.sql.*;
import java.util.*;

public class JdbcFactory {
    private static final Logger logger = Logger.getLogger(JdbcFactory.class);

    private final String url;

    private final String databaseName;

    private final Properties properties = new Properties();

    private JdbcFactory(Builder builder) {
        this.url = builder.url;
        this.databaseName = builder.databaseName;
        this.properties.setProperty("user", builder.user);
        this.properties.setProperty("password", builder.password);
    }

    public Connection getPlainConnection() {
        try {
            return DriverManager.getConnection(url, properties);
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return null;
    }

    public Connection getConnection() {
        try {
            final var con = DriverManager.getConnection(url + "/" + databaseName, properties);
            con.setCatalog(databaseName);
            return con;
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return null;
    }

    public static Builder builder() {
        return new Builder();
    }

    public static final class Builder {
        private String url;
        private String user;
        private String password;
        private String databaseName;

        private Builder() {
        }

        public Builder withUrl(String url) {
            this.url = url;
            return this;
        }

        public Builder withUser(String user) {
            this.user = user;
            return this;
        }

        public Builder withPassword(String password) {
            this.password = password;
            return this;
        }

        public Builder withDatabaseName(String databaseName) {
            this.databaseName = databaseName;
            return this;
        }

        public JdbcFactory build() {
            return new JdbcFactory(this);
        }
    }
}
