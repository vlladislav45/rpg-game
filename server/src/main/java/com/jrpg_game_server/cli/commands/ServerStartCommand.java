package com.jrpg_game_server.cli.commands;

import com.corundumstudio.socketio.AckRequest;
import com.corundumstudio.socketio.Configuration;
import com.corundumstudio.socketio.SocketIOClient;
import com.corundumstudio.socketio.SocketIOServer;
import com.corundumstudio.socketio.listener.DataListener;
import com.jrpg_game_server.cli.dao.UserDAO;
import com.jrpg_game_server.cli.models.binding.AuthenticationRequestBindingModel;
import com.jrpg_game_server.cli.models.views.UserViewModel;
import com.jrpg_game_server.cli.services.ServiceWrapper;
import com.jrpg_game_server.cli.services.UserServices;
import com.jrpg_game_server.cli.services.impl.UserServicesImpl;
import picocli.CommandLine;

@CommandLine.Command(name = "start server", aliases = "ss")

public class ServerStartCommand extends AbstractCommand {
    private ServiceWrapper serviceWrapper;

    @Override
    public void run() {
        System.out.println("Server is starting..");

        // Initialize entire set of services and dao's
        initialize();

        Configuration config = new Configuration();
        config.setHostname("localhost");
        config.setPort(9092);

        final SocketIOServer server = new SocketIOServer(config);
        server.addEventListener("authentication", AuthenticationRequestBindingModel.class, new DataListener<AuthenticationRequestBindingModel>() {
            @Override
            public void onData(SocketIOClient client, AuthenticationRequestBindingModel data, AckRequest ackRequest) {
                System.out.println(data.getUsername());
                boolean isAuthenticated = loginCheck(data.getUsername(), data.getPassword());
                if (isAuthenticated) {
                    //TODO: Send message for new screen
                    UserViewModel userViewModel = UserViewModel.toViewModel(serviceWrapper.getUserServices().getLoggedUser());
                    client.sendEvent("authenticated", userViewModel);
                } else {
                    //TODO: Send error message: WRONG CREDENTIALS!
                }
                // broadcast messages to all clients
//                server.getBroadcastOperations().sendEvent("authentication", data);
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

    private void initialize() {
        //Init Database access objects
        UserDAO userDAO = new UserDAO();

        //Init service layer
        UserServices userServices = new UserServicesImpl(userDAO);

        serviceWrapper = new ServiceWrapper();
        serviceWrapper.setServices(userServices);
    }

    private boolean loginCheck(String username, String password) {
        if (username == null || username.trim().isEmpty()
                || password == null || password.isEmpty()) {
            //TODO: Send warning message that the user doesn't has entered username or password
        } else {
            return
                    this.serviceWrapper
                            .getUserServices().checkLogin(username, password);
        }
        return false;
    }
}
