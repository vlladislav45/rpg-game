package com.jrpg_game_server;

import com.corundumstudio.socketio.*;
import com.jrpg_game_server.cli.dao.CharacterDAO;
import com.jrpg_game_server.cli.dao.UserDAO;
import com.jrpg_game_server.cli.entities.Character;
import com.jrpg_game_server.cli.entities.User;
import com.jrpg_game_server.cli.entities.UserRole;
import com.jrpg_game_server.cli.network.SocketServerManager;
import org.junit.jupiter.api.Assertions;
import org.junit.jupiter.api.Test;

import java.util.HashSet;
import java.util.Set;
import java.util.UUID;

public class SocketTest {

    @Test
    void config() {
        SocketServerManager socketServerManager = SocketServerManager.setup();
        final SocketIOServer server = socketServerManager.getSocketServer();

        try {
            server.start();
        } catch (Exception e) {
            System.out.println(e);
        }
    }

    @Test
    void createUser() {
        // arrange
        CharacterDAO characterDAO = new CharacterDAO();
        UserDAO userDAO = new UserDAO(characterDAO);
        Set<Character> characters = new HashSet();
        characters.add(new Character("bro", 200, 300));
        User user = new User("bb", "bb", new UserRole("user"), characters, false);

        // act
        userDAO.add(user);

        //assert
        Assertions.assertEquals(user, userDAO.getByParams("bb", "bb"));
    }

    @Test
    void updateUser() {
        // arrange
        CharacterDAO characterDAO = new CharacterDAO();
        UserDAO userDAO = new UserDAO(characterDAO);
        User user = userDAO.getByParams("bb", "bb");

        user.setUsername("Ivan");
        // act
        userDAO.update(user);

        //assert
        Assertions.assertEquals(user, userDAO.getByParams("Ivan", user.getPassword()));
    }
}
