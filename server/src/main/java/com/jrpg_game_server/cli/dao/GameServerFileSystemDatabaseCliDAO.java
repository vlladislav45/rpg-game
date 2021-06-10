package com.jrpg_game_server.cli.dao;

import com.jrpg_game_server.cli.config.Config;

public class GameServerFileSystemDatabaseCliDAO extends AbstractFileSystemDatabaseCliDAO {

    public GameServerFileSystemDatabaseCliDAO() {
        super(Config.gameServer());
    }
}
