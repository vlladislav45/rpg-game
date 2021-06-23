package com.jrpg_game_server.cli.config;

import org.aeonbits.owner.Mutable;

/**
 * Server configuration.
 */
public interface ServerConfig extends Mutable {
    @Key("Host")
    String getHost();

    @Key("Port")
    Integer getPort();

    @Key("MaxConnections")
    Integer getMaxOnlineUsers();
}
