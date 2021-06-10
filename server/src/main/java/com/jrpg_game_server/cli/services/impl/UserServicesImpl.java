package com.jrpg_game_server.cli.services.impl;

import com.jrpg_game_server.cli.dao.UserDAO;
import com.jrpg_game_server.cli.entities.User;
import com.jrpg_game_server.cli.services.UserServices;

import java.util.List;
import java.util.Map;

public class UserServicesImpl implements UserServices {
    private final UserDAO userDao;
    private User loggedUser;

    public UserServicesImpl(UserDAO userDao) {
        this.userDao = userDao;
    }

    @Override
    public List<Map<String,Object>> getUsers() {
        return userDao.getAllUsers();
    }

    @Override
    public boolean checkLogin(String username, String password){
        User user = userDao.getByParams(username, password);
        if(user != null) {
            this.loggedUser = user;
            return true;
        }else {
            return false;
        }

    }

    @Override
    public User getLoggedUser() {
        return loggedUser;
    }
}
