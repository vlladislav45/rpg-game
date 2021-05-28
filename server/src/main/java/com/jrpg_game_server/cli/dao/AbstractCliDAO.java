package com.jrpg_game_server.cli.dao;

import com.jrpg_game_server.cli.config.ServerConfig;
import com.jrpg_game_server.cli.filters.SQLFilter;
import com.jrpg_game_server.cli.database.JdbcFactory;
import org.apache.log4j.Logger;

import java.io.File;
import java.sql.*;
import java.util.*;

public class AbstractCliDAO {
    public static final Logger logger = Logger.getLogger(AbstractCliDAO.class);

    private static final String CREATE_DATABASE = "CREATE DATABASE ";

    private final JdbcFactory connectionFactory;

    private final String database;

    public AbstractCliDAO(ServerConfig server) {
        this.database = server.getDatabaseName();

        this.connectionFactory = JdbcFactory.builder()
                .withDatabaseName(server.getDatabaseName())
                .withUrl(server.getDatabaseURL())
                .withUser(server.getDatabaseUser())
                .withPassword(server.getDatabasePassword())
                .build();
    }

    public String getDatabase() {
        return database;
    }

    public Connection getConnection() {
        return connectionFactory.getConnection();
    }

    public void createDatabase() throws SQLException {
        try (var con = connectionFactory.getPlainConnection(); //
             var st = con.createStatement()) {
            st.executeUpdate(CREATE_DATABASE + database);
        }
    }

    /**
     * ##################! Work with SQL files !##################
     */
    public void executeSQLScript(File file) {
        String line = "";
        try (var con = getConnection(); //
             var stmt = con.createStatement(); //
             var scn = new Scanner(file)) {
            var sb = new StringBuilder();
            while (scn.hasNextLine()) {
                line = scn.nextLine();
                if (line.startsWith("--")) {
                    continue;
                }

                if (line.contains("--")) {
                    line = line.split("--")[0];
                }

                line = line.trim();
                if (!line.isEmpty()) {
                    sb.append(line).append(System.getProperty("line.separator"));
                }

                if (line.endsWith(";")) {
                    stmt.execute(sb.toString());
                    sb = new StringBuilder();
                }
            }
        } catch (Exception ex) {
            System.err.println("There has been an error executing file " + file.getName() + "!");
            ex.printStackTrace();
        }
    }

    public void executeDirectoryOfSQLScripts(File dir, boolean skipErrors) {
        final var files = dir.listFiles(new SQLFilter());
        if (files != null) {
            Arrays.sort(files);
            for (var file : files) {
                if (skipErrors) {
                    try {
                        executeSQLScript(file);
                    } catch (Throwable t) {
                    }
                } else {
                    executeSQLScript(file);
                }
            }
        }
    }
}
