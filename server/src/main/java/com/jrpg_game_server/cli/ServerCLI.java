package com.jrpg_game_server.cli;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.util.concurrent.Callable;

import com.jrpg_game_server.cli.commands.DatabaseCommand;
import com.jrpg_game_server.cli.commands.ExitCommand;
import com.jrpg_game_server.cli.commands.ServerStartCommand;
import picocli.CommandLine;
import picocli.CommandLine.Command;

@Command(name = "Daily Wars JRPG Server CLI",
        mixinStandardHelpOptions = true,
        version = "JRPG server 1.0",
        subcommands = {
                DatabaseCommand.class,
                ServerStartCommand.class,
                ExitCommand.class,
})
public class ServerCLI implements Callable<Void> {

    public ServerCLI() { }

    @Override
    public Void call() {
        System.out.println("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
        System.out.println("~                                     ~");
        System.out.println("~ (>^_^)> Welcome to Daily Wars Java Server <(^_^<) ~");
        System.out.println("~                                     ~");
        System.out.println("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
        System.out.println();
        try (InputStreamReader isr = new InputStreamReader(System.in); //
             BufferedReader br = new BufferedReader(isr)) {
            while (true) {
                System.out.print(">>> ");
                final var args = br.readLine().split(" ");
                new CommandLine(new ServerCLI()).execute(args);
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return null;
    }
}
