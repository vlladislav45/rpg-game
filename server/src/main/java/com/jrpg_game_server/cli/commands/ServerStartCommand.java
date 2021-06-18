package com.jrpg_game_server.cli.commands;

import com.corundumstudio.socketio.Configuration;
import com.corundumstudio.socketio.SocketIOServer;
import com.jrpg_game_server.cli.dao.CharacterDAO;
import com.jrpg_game_server.cli.dao.UserDAO;
import com.jrpg_game_server.cli.models.binding.AuthenticationRequestBindingModel;
import com.jrpg_game_server.cli.models.views.UserViewModel;
import com.jrpg_game_server.cli.services.ServiceWrapper;
import com.jrpg_game_server.cli.services.UserServices;
import com.jrpg_game_server.cli.services.impl.UserServicesImpl;
import picocli.CommandLine;

import java.util.HashMap;

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
        config.setPort(9096);

        final SocketIOServer server = new SocketIOServer(config);
        server.addEventListener("authentication", AuthenticationRequestBindingModel.class, (client, data, ackRequest) -> {
            boolean isAuthenticated = loginCheck(data.getUsername(), data.getPassword());
            if (isAuthenticated) {
                UserViewModel userViewModel = UserViewModel.toViewModel(serviceWrapper.getUserServices().getLoggedUser());
                client.sendEvent("authenticated", userViewModel);
            } else {
                // Wrong credentials
                client.sendEvent("authenticationError", new HashMap<String, String>(){{
                    put("error", "WRONG CREDENTIALS");
                }});
            }
        });

        if(serviceWrapper.getUserServices().getLoggedUser() != null) {
            System.out.println(serviceWrapper.getUserServices().getLoggedUser().getUsername());
            server.addEventListener("loggedPlayer", AuthenticationRequestBindingModel.class, (client, data, ackRequest) -> {

            });
        }

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
        CharacterDAO characterDAO = new CharacterDAO();
        UserDAO userDAO = new UserDAO(characterDAO);

        //Init service layer
        UserServices userServices = new UserServicesImpl(userDAO,
                characterDAO);

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
