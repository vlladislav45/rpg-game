package com.jrpg_game_server.cli.config;

import org.aeonbits.owner.ConfigFactory;

public enum Config {
    INSTANCE;

    private final GameServerConfig gameServer;
    private final DatabaseConfig databaseConfig;

    Config() {
        gameServer = ConfigFactory.create(GameServerConfig.class);
        databaseConfig = ConfigFactory.create(DatabaseConfig.class);
    }

    public static GameServerConfig gameServer() {
        return INSTANCE.gameServer;
    }

    public static DatabaseConfig databaseConfig() {
        return INSTANCE.databaseConfig;
    }
}
