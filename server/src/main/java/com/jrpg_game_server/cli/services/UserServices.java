package com.jrpg_game_server.cli.services;

import com.jrpg_game_server.cli.entities.User;

import java.util.List;
import java.util.Map;

public interface UserServices {
    List<Map<String,Object>> getUsers();

    boolean checkLogin(String username, String password);

    User getLoggedUser();
}
