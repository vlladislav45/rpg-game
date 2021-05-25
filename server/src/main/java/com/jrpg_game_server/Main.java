package com.jrpg_game_server;

import com.jrpg_game_server.cli.ServerCLI;
import com.corundumstudio.socketio.listener.*;
import com.corundumstudio.socketio.*;
import com.jrpg_game_server.models.binding.AuthenticationRequestBindingModel;
import picocli.CommandLine;

public class Main {
    public static void main(String[] args) throws InterruptedException {

        //new CommandLine(new ServerCLI()).execute(args);

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

        Thread.sleep(Integer.MAX_VALUE);

        server.stop();
    }
}
