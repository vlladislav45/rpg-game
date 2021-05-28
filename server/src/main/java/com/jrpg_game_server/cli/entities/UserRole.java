package com.jrpg_game_server.cli.entities;

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
}
