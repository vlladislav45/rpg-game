package com.jrpg_game_server.cli.commands;

import picocli.CommandLine;

@CommandLine.Command(name = "exit", aliases = "e")
public class ExitCommand extends AbstractCommand {

    @Override
    public void run() {
        System.exit(0);
    }

}
