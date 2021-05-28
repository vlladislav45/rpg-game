package com.jrpg_game_server.cli.commands;

import com.corundumstudio.socketio.AckRequest;
import com.corundumstudio.socketio.Configuration;
import com.corundumstudio.socketio.SocketIOClient;
import com.corundumstudio.socketio.SocketIOServer;
import com.corundumstudio.socketio.listener.DataListener;
import com.jrpg_game_server.cli.config.Config;
import com.jrpg_game_server.cli.dao.UserDAO;
import com.jrpg_game_server.cli.entities.User;
import com.jrpg_game_server.cli.models.binding.AuthenticationRequestBindingModel;
import picocli.CommandLine;

@CommandLine.Command(name = "start server", aliases = "ss")

public class ServerStartCommand extends AbstractCommand {
    @Override
    public void run() {
        System.out.println("Server is starting..");

        UserDAO userDAO = new UserDAO();
        User user = new User("ivan", "pishka");
        userDAO.add(user);

        Configuration config = new Configuration();
        config.setHostname("localhost");
        config.setPort(9092);

        final SocketIOServer server = new SocketIOServer(config);
        server.addEventListener("authentication", AuthenticationRequestBindingModel.class, new DataListener<AuthenticationRequestBindingModel>() {
            @Override
            public void onData(SocketIOClient client, AuthenticationRequestBindingModel data, AckRequest ackRequest) {
                System.out.println(data.getUsername());
                // broadcast messages to all clients
                server.getBroadcastOperations().sendEvent("authentication", data);
            }
        });

        server.start();

        try {
            Thread.sleep(Integer.MAX_VALUE);
        } catch (InterruptedException e) {
            e.printStackTrace();
        }

        server.stop();

    }
}
