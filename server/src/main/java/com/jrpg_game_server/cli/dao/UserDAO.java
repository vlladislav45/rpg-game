package com.jrpg_game_server.cli.dao;

import com.jrpg_game_server.cli.config.Config;
import com.jrpg_game_server.cli.entities.User;
import com.jrpg_game_server.cli.entities.UserRole;

import java.util.List;
import java.util.Map;

public class UserDAO extends AbstractDatabaseCliDAO implements BaseDAO {
    private static final String USER_TABLE_NAME = "users";
    private static final String USER_ROLE_TABLE_NAME = "user_roles";

    public UserDAO() {
        super(Config.gameServer());
    }

    @Override
    public void add(Object object) {
        User user = (User) object;

        String query =
                "INSERT INTO "
                        + USER_TABLE_NAME +
                        "(username, password, time_created, role_id) VALUES(?,?,?,?)";

        int roleId = getRoleId(user.getUserRole());

        executeQuery(query, user.getUsername(), user.getPassword(), user.getTimestamp(), roleId);
    }

    @Override
    public Object getById(int id) {
        String query = "SELECT * FROM " + USER_TABLE_NAME + " WHERE id =" + id;
        Map<String,Object> result = executeQueryWithSingleResult(query);

        int roleId = (int) result.get("role_id");
        UserRole userRole = this.getRoleById(roleId);

        User user = User.map(result);
        user.setUserRole(userRole);

        return user;
    }

    @Override
    public void removeById(int id) {
        String query = "DELETE FROM " + USER_TABLE_NAME + " WHERE id=?";

        executeQuery(query, id);
    }

    @Override
    public void update(Object object, Object... wildParams) {
        User user = (User) object;

        String query = "UPDATE " + USER_TABLE_NAME +
                " SET password=? " +
                " WHERE username=?";

        executeQuery(query, wildParams, user.getUsername());
    }

    public User getByParams(String username, String password) {
        String query = "SELECT * FROM " + USER_TABLE_NAME + " WHERE username='" + username + "'" +
                " AND password='" + password + "'";

        Map<String,Object> result = executeQueryWithSingleResult(query);

        if(result.isEmpty()) {
            return null;
        }
        User user = User.map(result);
        int roleId = Integer.parseInt(String.valueOf(result.get("role_id")));
        UserRole role = getRoleById(roleId);
        user.setUserRole(role);

        return user;
    }

    public List<Map<String,Object>> getAllUsers() { // Get all users at database

        String query = "SELECT * FROM " + USER_TABLE_NAME;

        List<Map<String, Object>> result = executeQueryWithMultipleResult(query);
        return result;
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

        final UserRole userRole = UserRole.map(resultMap);
        return userRole;
    }
}
