package com.jrpg_game_server.cli.entities;

import java.util.Map;

public class UserRole {
    private int id;
    private String roleName;

    public UserRole() {
    }

    public UserRole(String role) {
        this.roleName = role;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getRoleName() {
        return roleName;
    }

    public void setRoleName(String roleName) {
        this.roleName = roleName;
    }

    public static UserRole map(Map<String, Object> map) {
        final UserRole userRole = new UserRole();
        userRole.setId((Integer) map.get("id"));
        userRole.setRoleName((String) map.get("role_name"));

        return userRole;
    }
}
