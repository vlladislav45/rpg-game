package com.jrpg_game_server.cli.dao;

import com.jrpg_game_server.cli.config.Config;
import com.jrpg_game_server.cli.entities.Character;
import com.jrpg_game_server.cli.entities.User;
import com.jrpg_game_server.cli.entities.UserRole;

import java.util.*;

public class UserDAO extends AbstractDatabaseCliDAO implements BaseDAO<User> {
    private static final String USER_TABLE_NAME = "users";
    private static final String USER_ROLE_TABLE_NAME = "user_roles";

    private final CharacterDAO characterDAO;

    public UserDAO(CharacterDAO characterDAO) {
        super(Config.databaseConfig());
        this.characterDAO = characterDAO;
    }

    @Override
    public void add(User user) {
        String query =
                "INSERT INTO "
                        + USER_TABLE_NAME +
                        "(username, password, time_created, role_id) VALUES(?,?,?,?)";

        int roleId = getRoleId(user.getUserRole());

        executeQuery(query, user.getUsername(), user.getPassword(), user.getTimestamp(), roleId);
    }

    @Override
    public User getById(UUID id) {
        String query = "SELECT * FROM " + USER_TABLE_NAME + " WHERE id = '" + id + "'";
        Map<String,Object> result = executeQueryWithSingleResult(query);

        // Get role of the user
        int roleId = (int) result.get("role_id");
        UserRole userRole = this.getRoleById(roleId);

        // Get characters of the user
        Set<Character> characterSet = characterDAO.getCharactersByUserId(id);

        User user = User.map(result);
        user.setUserRole(userRole);
        user.setCharacters(characterSet);

        return user;
    }

    @Override
    public void removeById(int id) {
        String query = "DELETE FROM " + USER_TABLE_NAME + " WHERE id=?";

        executeQuery(query, id);
    }

    @Override
    public void update(User user) {
        String query = "UPDATE " + USER_TABLE_NAME +
                " SET password=? " +
                " WHERE username=?";

        executeQuery(query, user.getPassword(), user.getUsername());
    }

    public void updateOnlineStatus(User user,boolean onlineStatus) {
        String query = "UPDATE " + USER_TABLE_NAME +
                " SET online=? " +
                " WHERE id=?";

        executeQuery(query, onlineStatus, user.getId());
    }

    public User getByParams(String username, String password) {
        String query = "SELECT * FROM " + USER_TABLE_NAME + " WHERE username='" + username + "'" +
                " AND password='" + password + "'";

        Map<String,Object> result = executeQueryWithSingleResult(query);
        if(result.isEmpty()) {
            return null;
        }

        User user = User.map(result);
        // Get characters of the user
        Set<Character> characterSet = characterDAO.getCharactersByUserId(user.getId());

        int roleId = Integer.parseInt(String.valueOf(result.get("role_id")));
        UserRole role = getRoleById(roleId);
        user.setUserRole(role);
        user.setCharacters(characterSet);

        return user;
    }

    public List<User> getAllUsers() {
        String query = "SELECT * FROM " + USER_TABLE_NAME +
                " WHERE online = '" + true + "'";

        List<Map<String,Object>> result = executeQueryWithMultipleResult(query);

        List<User> users = new ArrayList<>();
        for(int i = 0; i < result.size(); i++) {
            users.add(User.map(result.get(i)));
            // Get characters of the user
            Set<Character> characterSet = characterDAO.getCharactersByUserId(users.get(i).getId());
            users.get(i).setCharacters(characterSet);
        }
        return users;
    }

    /**
     * Role methods
     * @param role
     * @return role id be his ROLE
     */
    public int getRoleId(UserRole role) {
        String query = "SELECT * FROM " + USER_ROLE_TABLE_NAME + " WHERE role_name = '" + role.getRoleName() + "'";
        return (int) executeQueryWithSingleResult(query).get("id");
    }

    public UserRole getRoleById(int roleId) {
        String query = "SELECT * FROM " + USER_ROLE_TABLE_NAME + " WHERE id = " + roleId;
        Map<String, Object> resultMap = executeQueryWithSingleResult(query);

        return UserRole.map(resultMap);
    }
}
