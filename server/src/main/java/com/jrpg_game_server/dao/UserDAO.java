package com.jrpg_game_server.dao;

import com.jrpg_game_server.cli.config.Config;

public class UserDAO extends AbstractDAO {
    UserDAO() {
        super(Config.gameServer());
    }
}
