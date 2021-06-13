package com.jrpg_game_server.cli.services.impl;

import com.jrpg_game_server.cli.dao.CharacterDAO;
import com.jrpg_game_server.cli.dao.UserDAO;
import com.jrpg_game_server.cli.entities.User;
import com.jrpg_game_server.cli.entities.Character;
import com.jrpg_game_server.cli.services.UserServices;

import java.util.List;
import java.util.Map;

public class UserServicesImpl implements UserServices {
    private final UserDAO userDao;
    private final CharacterDAO characterDAO;
    private User loggedUser;

    public UserServicesImpl(UserDAO userDao, CharacterDAO characterDAO) {
        this.userDao = userDao;
        this.characterDAO = characterDAO;
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
    public void register(User user, Character character) {
        this.userDao.add(user);
        this.characterDAO.add(character);
        this.characterDAO.linkCharacterToUser(character, user);
    }

    @Override
    public User getLoggedUser() {
        return loggedUser;
    }
}
