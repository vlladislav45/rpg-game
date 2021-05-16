package com.jrpg_game_server.cli.config;

import org.aeonbits.owner.Config;

@Config.Sources({
        "file:./config/game-server.properties",
        "classpath:config/game-server.properties"
})
public interface GameServerConfig extends ServerConfig { }
