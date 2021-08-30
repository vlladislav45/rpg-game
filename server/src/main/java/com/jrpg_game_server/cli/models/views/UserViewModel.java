package com.jrpg_game_server.cli.models.views;

import com.jrpg_game_server.cli.entities.User;

import java.util.List;
import java.util.stream.Collectors;

public class UserViewModel {
    private String id;
    private String username;
    private String email;
    private List<CharacterViewModel> characters;
    private String userRole;
    private boolean online;

    public UserViewModel() {
    }

    public static UserViewModel toViewModel(User user) {
        UserViewModel userViewModel = new UserViewModel();
        if(user != null) {
            userViewModel.setUserId(user.getId().toString());
            userViewModel.setUsername(user.getUsername());
            userViewModel.setEmail(user.getEmail());

            userViewModel.setCharacters(user.getCharacters().stream().map(CharacterViewModel::toViewModel).collect(Collectors.toList()));
            userViewModel.setUserRole(user.getUserRole().getRoleName());
            userViewModel.setOnline(user.isOnline());
        }
        return userViewModel;
    }

    public String getUserId() {
        return id;
    }

    public void setUserId(String userId) {
        this.id = userId;
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

    public List<CharacterViewModel> getCharacters() {
        return characters;
    }

    public void setCharacters(List<CharacterViewModel> characters) {
        this.characters = characters;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getUserRole() {
        return userRole;
    }

    public void setUserRole(String userRole) {
        this.userRole = userRole;
    }

    public boolean isOnline() {
        return online;
    }

    public void setOnline(boolean online) {
        this.online = online;
    }
}
