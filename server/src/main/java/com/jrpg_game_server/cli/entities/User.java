package com.jrpg_game_server.cli.entities;

import java.sql.Timestamp;
import java.util.Map;
import java.util.Set;
import java.util.UUID;

public class User {
    private UUID id;
    private String email;
    private String username;
    private String password;
    private Timestamp timestamp;
    private UserRole userRole;
    private Set<Character> characters;
    private boolean online;

    public User() {
    }

    public User(String username, String password, UserRole userRole, Set<Character> characters, boolean online) {
        this.username = username;
        this.password = password;
        this.timestamp = new Timestamp(System.currentTimeMillis());
        this.userRole = userRole;
        this.characters = characters;
        this.online = online;
    }

    public User(UUID id, String username, String password, UserRole userRole, Set<Character> characters, boolean online) {
        this.id = id;
        this.username = username;
        this.password = password;
        this.timestamp = new Timestamp(System.currentTimeMillis());
        this.userRole = userRole;
        this.characters = characters;
        this.online = online;
    }

    public UUID getId() {
        return id;
    }

    public void setId(UUID id) {
        this.id = id;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public Timestamp getTimestamp() {
        return timestamp;
    }

    public void setTimestamp(Timestamp timestamp) {
        this.timestamp = timestamp;
    }

    public UserRole getUserRole() {
        return userRole;
    }

    public void setUserRole(UserRole userRole) {
        this.userRole = userRole;
    }

    public Set<Character> getCharacters() {
        return characters;
    }

    public void setCharacters(Set<Character> characters) {
        this.characters = characters;
    }

    public boolean isOnline() {
        return online;
    }

    public void setOnline(boolean online) {
        this.online = online;
    }

    public static User map(Map<String, Object> map) {
        final User user = new User();
        user.setId((UUID) map.get("id"));
        user.setUsername((String) map.get("username"));
        user.setPassword((String) map.get("password"));
        user.setTimestamp((Timestamp) map.get("time_created"));
        user.setOnline((Boolean) map.get("online"));

        return user;
    }
}
