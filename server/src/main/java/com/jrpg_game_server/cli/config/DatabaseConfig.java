package com.jrpg_game_server.cli.config;

import static org.aeonbits.owner.Config.DisableableFeature.PARAMETER_FORMATTING;
import static org.aeonbits.owner.Config.Sources;

import org.aeonbits.owner.Config;
import org.aeonbits.owner.Mutable;

@Sources({
        "file:./config/database.properties",
        "classpath:config/database.properties"
})
public interface DatabaseConfig extends Mutable {
    @org.aeonbits.owner.Config.Key("DatabaseURL")
    String getDatabaseURL();

    @org.aeonbits.owner.Config.Key("DatabaseName")
    String getDatabaseName();

    @org.aeonbits.owner.Config.Key("DatabaseUser")
    String getDatabaseUser();

    @org.aeonbits.owner.Config.Key("DatabasePassword")
    @org.aeonbits.owner.Config.DisableFeature(PARAMETER_FORMATTING)
    String getDatabasePassword();

    @org.aeonbits.owner.Config.Key("DatabaseConnectionPool")
    String getDatabaseConnectionPool();

    @org.aeonbits.owner.Config.Key("DatabaseMaximumPoolSize")
    int getDatabaseMaximumPoolSize();

    @Config.Key("DatabaseMaximumIdleTime")
    int getDatabaseMaximumIdleTime();
}
