package com.jrpg_game_server.cli;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.util.concurrent.Callable;

import com.jrpg_game_server.cli.commands.DatabaseCommand;
import picocli.CommandLine;
import picocli.CommandLine.Command;

@Command(name = "RPG Server CLI",
        mixinStandardHelpOptions = true,
        version = "RPG server 1.0",
        subcommands = {
                DatabaseCommand.class,
})
public class ServerCLI implements Callable<Void> {

    public ServerCLI() { }

    @Override
    public Void call() {
        System.out.println("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
        System.out.println("~                                     ~");
        System.out.println("~ (>^_^)> Welcome to JRPG server  <(^_^<) ~");
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
