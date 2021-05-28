package com.jrpg_game_server.cli.dao;

import com.jrpg_game_server.cli.config.Config;
import com.jrpg_game_server.cli.entities.User;

public class UserDAO extends AbstractDatabaseCliDAO implements BaseDAO {
    private static final String TABLE_NAME = "users";

    public UserDAO() {
        super(Config.gameServer());
    }

    @Override
    public void add(Object object) {
        User user = (User) object;

        String query =
                "INSERT INTO "
                        + TABLE_NAME +
                        "(username, password) VALUES(?,?)";

        int roleId = 1;

        executeQuery(query, user.getUsername(), user.getPassword());
    }

    @Override
    public Object getById(int id) {
        return null;
    }

    @Override
    public void removeById(int id) {

    }

    @Override
    public void update(Object element) {

    }

    @Override
    public int count() {
        return 0;
    }
}
