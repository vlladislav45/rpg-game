package com.jrpg_game_server.network;

import com.corundumstudio.socketio.Configuration;
import com.corundumstudio.socketio.SocketIOServer;
import com.jrpg_game_server.cli.config.Config;
import com.jrpg_game_server.cli.config.GameServerConfig;

public class SocketServerManager {
    private static SocketServerManager instance = null;
    final SocketIOServer socketServer;

    public SocketServerManager(GameServerConfig server) {
        Configuration config = new Configuration();
        config.setHostname(server.getHost());
        config.setPort(server.getPort());

        socketServer = new SocketIOServer(config);
    }

    public static SocketServerManager setup() {
        if(instance == null) {
            instance = new SocketServerManager(Config.gameServer());
        }
        return instance;
    }

    public SocketIOServer getSocketServer() {
        return socketServer;
    }
}
