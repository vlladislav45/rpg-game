package com.jrpg_game_server.cli.config;

import org.aeonbits.owner.ConfigFactory;

public enum Config {
    INSTANCE;

    private final GameServerConfig gameServer;

    Config() {
        gameServer = ConfigFactory.create(GameServerConfig.class);
    }

    public static GameServerConfig gameServer() {
        return INSTANCE.gameServer;
    }
}
