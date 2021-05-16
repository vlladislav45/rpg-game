package com.jrpg_game_server.cli.config;


import static org.aeonbits.owner.Config.DisableableFeature.PARAMETER_FORMATTING;

import org.aeonbits.owner.Config;
import org.aeonbits.owner.Mutable;

/**
 * Server configuration.
 */
public interface ServerConfig extends Mutable {
    @Config.Key("DatabaseURL")
    String getDatabaseURL();

    @Config.Key("DatabaseName")
    String getDatabaseName();

    @Config.Key("DatabaseUser")
    String getDatabaseUser();

    @Config.Key("DatabasePassword")
    @Config.DisableFeature(PARAMETER_FORMATTING)
    String getDatabasePassword();

    @Config.Key("DatabaseConnectionPool")
    String getDatabaseConnectionPool();

    @Config.Key("DatabaseMaximumPoolSize")
    int getDatabaseMaximumPoolSize();

    @Config.Key("DatabaseMaximumIdleTime")
    int getDatabaseMaximumIdleTime();
}
