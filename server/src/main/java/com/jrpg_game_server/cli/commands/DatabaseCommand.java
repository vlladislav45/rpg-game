package com.jrpg_game_server.cli.commands;

import com.jrpg_game_server.cli.commands.database.DatabaseInstallCommand;
import picocli.CommandLine;

@CommandLine.Command(name = "database", aliases = "db", subcommands = {
        DatabaseInstallCommand.class
})
public class DatabaseCommand extends AbstractCommand {

    @Override
    public void run() {
        System.err.println("Please invoke a subcommand");
        new CommandLine(new DatabaseCommand()).usage(System.out);
    }
}