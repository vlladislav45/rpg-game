package com.jrpg_game_server.cli.services;

import com.jrpg_game_server.cli.dao.CharacterDAO;
import com.jrpg_game_server.cli.dao.UserDAO;
import com.jrpg_game_server.cli.entities.User;
import com.jrpg_game_server.cli.entities.Character;
import com.jrpg_game_server.cli.services.base.UserService;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.UUID;

public class UserServiceImpl implements UserService {
    private final UserDAO userDao;
    private final CharacterDAO characterDAO;
    private User loggedUser;

    public UserServiceImpl(UserDAO userDao, CharacterDAO characterDAO) {
        this.userDao = userDao;
        this.characterDAO = characterDAO;
    }

    @Override
    public List<User> getAllUsers() {
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

    @Override
    public User getUserBy(UUID id) {
        return this.userDao.getById(id);
    }

    @Override
    public void updateOnlineStatus(User user, boolean status) {
        this.userDao.updateOnlineStatus(user, status);
    }
}
