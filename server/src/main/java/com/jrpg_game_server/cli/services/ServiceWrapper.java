package com.jrpg_game_server.cli.services;

import com.jrpg_game_server.cli.services.base.CharacterService;
import com.jrpg_game_server.cli.services.base.UserService;

public class ServiceWrapper {
    private static boolean isInstantiated = false;

    private UserService userService;
    private CharacterService characterService;

    public ServiceWrapper() {
    }

    public void setServices(UserService userService, CharacterService characterService) {
        if(!isInstantiated) {
            this.userService = userService;
            this.characterService = characterService;

            isInstantiated = true;
        }
        return;
    }

    /***
     * Getters
     * @return Services
     */
    public UserService getUserServices() {
        return userService;
    }

    public CharacterService getCharacterService() {
        return characterService;
    }
}
