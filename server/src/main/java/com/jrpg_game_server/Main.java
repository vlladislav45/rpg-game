package com.jrpg_game_server;

import com.jrpg_game_server.database.JdbConnector;

import java.sql.SQLException;

public class Main {
    public static void main(String[] args) throws SQLException {
        System.out.println("This server is alive");

        JdbConnector jdbConnector = new JdbConnector(
          "jdbc:postgresql://localhost:5432/rpg_game??useSSL=false&createDatabaseIfNotExist=true&serverTimezone=UTC&useLegacyDatetimeCode=false",
                "postgres",
                "postgres"
        );
    }
}
