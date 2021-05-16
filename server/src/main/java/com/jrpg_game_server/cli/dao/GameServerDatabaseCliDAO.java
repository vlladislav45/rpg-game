package com.jrpg_game_server.cli.dao;

import com.jrpg_game_server.cli.config.Config;

public class GameServerDatabaseCliDAO extends AbstractDatabaseCliDAO {

    public GameServerDatabaseCliDAO() {
        super(Config.gameServer());
    }
}
