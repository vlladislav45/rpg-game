package com.jrpg_game_server;

import com.jrpg_game_server.cli.ServerCLI;
import picocli.CommandLine;

public class Main {
    public static void main(String[] args) {
        new CommandLine(new ServerCLI()).execute(args);
    }
}
