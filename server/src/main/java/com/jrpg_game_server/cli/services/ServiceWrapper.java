package com.jrpg_game_server.cli.services;

public class ServiceWrapper {
    private static boolean isInstantiated = false;

    private UserServices userServices;

    public ServiceWrapper() {
    }

    public void setServices(UserServices userServices) {
        if(!isInstantiated) {
            this.userServices = userServices;
            isInstantiated = true;
        }
        return;
    }

    /***
     * Getters
     * @return Services
     */
    public UserServices getUserServices() {
        return userServices;
    }
}
