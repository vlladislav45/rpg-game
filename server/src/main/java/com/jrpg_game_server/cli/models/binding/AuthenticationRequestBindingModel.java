package com.jrpg_game_server.cli.models.binding;

public class AuthenticationRequestBindingModel {
    private String username;
    private String password;

    public AuthenticationRequestBindingModel() {
    }

    public AuthenticationRequestBindingModel(String username, String password) {
        this.username = username;
        this.password = password;
    }

    public String getUsername() {
        return username;
    }

    public String getPassword() {
        return password;
    }
}
