package com.jrpg_game_server.cli.services.base;

import com.jrpg_game_server.cli.entities.User;
import com.jrpg_game_server.cli.entities.Character;

import java.util.List;
import java.util.Map;

public interface UserService {
    List<Map<String,Object>> getUsers();

    boolean checkLogin(String username, String password);

    void register(User user, Character character);

    User getLoggedUser();
}
