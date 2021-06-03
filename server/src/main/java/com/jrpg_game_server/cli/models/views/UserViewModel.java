package com.jrpg_game_server.cli.models.views;

import com.jrpg_game_server.cli.entities.User;

import java.util.UUID;

public class UserViewModel {
    private UUID userId;
    private String username;
    private String email;

    public UserViewModel() {
    }

    public static UserViewModel toViewModel(User user) {
        UserViewModel userViewModel = new UserViewModel();
        if(user != null) {
            userViewModel.setUserId(user.getId());
            userViewModel.setUsername(user.getUsername());
            userViewModel.setEmail(user.getEmail());
        }
        return userViewModel;
    }

    public UUID getUserId() {
        return userId;
    }

    public void setUserId(UUID userId) {
        this.userId = userId;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }
}
