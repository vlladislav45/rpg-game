package com.jrpg_game_server.cli.commands;

import com.corundumstudio.socketio.SocketIOClient;
import com.corundumstudio.socketio.SocketIOServer;
import com.jrpg_game_server.cli.dao.CharacterDAO;
import com.jrpg_game_server.cli.dao.UserDAO;
import com.jrpg_game_server.cli.entities.Character;
import com.jrpg_game_server.cli.entities.User;
import com.jrpg_game_server.cli.models.binding.AuthenticationRequestBindingModel;
import com.jrpg_game_server.cli.models.binding.CharacterBindingModel;
import com.jrpg_game_server.cli.models.views.CharacterViewModel;
import com.jrpg_game_server.cli.models.views.UserViewModel;
import com.jrpg_game_server.cli.services.CharacterServiceImpl;
import com.jrpg_game_server.cli.services.ServiceWrapper;
import com.jrpg_game_server.cli.services.base.CharacterService;
import com.jrpg_game_server.cli.services.base.UserService;
import com.jrpg_game_server.cli.services.UserServiceImpl;
import com.jrpg_game_server.cli.network.SocketServerManager;
import picocli.CommandLine;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.UUID;

@CommandLine.Command(name = "start server", aliases = "ss")

public class ServerStartCommand extends AbstractCommand {
    private ServiceWrapper serviceWrapper;
    private SocketServerManager socketServerManager;

    @Override
    public void run() {
        System.out.println("Server is starting..");

        // Initialize entire set of services and dao's
        initializeServices();

        // Init socket server
        socketServerManager = SocketServerManager.setup();
        final SocketIOServer server = socketServerManager.getSocketServer();

        server.addEventListener("authentication", AuthenticationRequestBindingModel.class, (client, data, ackRequest) -> {
            boolean isAuthenticated = loginCheck(data.getUsername(), data.getPassword());
            if (isAuthenticated) {
                User user = serviceWrapper.getUserServices().getLoggedUser();
                UserViewModel userViewModel = UserViewModel.toViewModel(user);

                client.sendEvent("authenticated", userViewModel);
            } else {
                // Wrong credentials
                client.sendEvent("authenticationError", new HashMap<String, String>() {{
                    put("error", "WRONG CREDENTIALS");
                }});
            }
        });

        server.addEventListener("onlineStatus", UserViewModel.class, (client, data, ackRequest) -> {
            User user = serviceWrapper.getUserServices().getUserBy(UUID.fromString(data.getId()));
            serviceWrapper.getUserServices().updateOnlineStatus(user, data.isOnline());

            // If player leave arena
            if (!data.isOnline()) {
                System.out.println(user.getUsername() + " leaves the arena");
                server.getBroadcastOperations().sendEvent("leaveArena", user.getCharacters().iterator().next());
            } else {
                System.out.println(user.getUsername() + " enter in arena");
                server.getBroadcastOperations().sendEvent("newPlayer", user.getCharacters().iterator().next());
            }
        });

        server.addEventListener("handshake", CharacterBindingModel.class, (client, data, ackRequest) -> {
            if (serviceWrapper.getUserServices().getLoggedUser() != null) {
                CharacterViewModel characterViewModel =
                        CharacterViewModel.toViewModel(serviceWrapper.getUserServices().getLoggedUser().getCharacters().iterator().next());
                client.sendEvent("loggedPlayer", characterViewModel);
            }
        });

        server.addEventListener("multiplayer", CharacterBindingModel.class, (client, data, ackRequest) -> {
            User loggedUser = serviceWrapper.getUserServices().getLoggedUser();
            if (loggedUser != null) {
                List<CharacterViewModel> characterViewModels = new ArrayList<>();
                for (User user : serviceWrapper.getUserServices().getAllUsers()) {
                    if (!user.getId().toString().equals(loggedUser.getId().toString())) {
                        characterViewModels.add(CharacterViewModel.toViewModel(user.getCharacters().iterator().next()));
                    }
                }

                for (var c : characterViewModels) {
                    System.out.println(c.getNickname());
                }
                client.sendEvent("firstUpdate", characterViewModels);
            }
        });

        server.addEventListener("update", CharacterBindingModel.class, (client, data, ackRequest) -> {
            User loggedUser = serviceWrapper.getUserServices().getLoggedUser();
            if (loggedUser != null) {
                // update the information about character
                Character character = new Character(
                        UUID.fromString(data.getId()),
                        data.getNickname(),
                        data.getHp(),
                        data.getLevel(),
                        data.getMana(),
                        data.getOffsetX(),
                        data.getOffsetY(),
                        data.getAction(),
                        data.getDirection()
                );
                serviceWrapper.getCharacterService().update(character);

                server.getBroadcastOperations().sendEvent("remotePlayer", character);
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

//    private void returnRemotePlayers(SocketIOClient client, String eventName) {
//        List<CharacterViewModel> characterViewModels = new ArrayList<>();
//        for (User user : serviceWrapper.getUserServices().getAllUsers()) {
////            if(!user.getId().toString().equals(loggedUser.getId().toString())) {
//            characterViewModels.add(CharacterViewModel.toViewModel(user.getCharacters().iterator().next()));
////            }
//        }
//
//        client.sendEvent(eventName, characterViewModels);
//    }

    private void initializeServices() {
        //Init Database access objects
        CharacterDAO characterDAO = new CharacterDAO();
        UserDAO userDAO = new UserDAO(characterDAO);

        //Init service layer
        UserService userService = new UserServiceImpl(userDAO,
                characterDAO);
        CharacterService characterService = new CharacterServiceImpl(characterDAO);

        serviceWrapper = new ServiceWrapper();
        serviceWrapper.setServices(userService, characterService);
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
