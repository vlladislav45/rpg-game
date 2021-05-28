package com.jrpg_game_server.cli.commands.database;

import com.jrpg_game_server.cli.commands.AbstractCommand;
import com.jrpg_game_server.cli.config.Config;
import com.jrpg_game_server.cli.dao.AbstractFileSystemDatabaseCliDAO;
import com.jrpg_game_server.cli.dao.GameServerFileSystemDatabaseCliDAO;
import org.aeonbits.owner.Mutable;
import picocli.CommandLine;

import java.io.File;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.Scanner;

@CommandLine.Command(name = "install", aliases = "i")
public class DatabaseInstallCommand extends AbstractCommand {
    @CommandLine.Option(names = "-sql", required = true, description = "SQL Files location")
    private String path;

    @CommandLine.Option(names = "-url", description = "Database URL")
    private String url;

    @CommandLine.Option(names = "-db", description = "Database Name")
    private String name;

    @CommandLine.Option(names = "-u", description = "Database User")
    private String user;

    @CommandLine.Option(names = "-p", description = "Database Password")
    private String password;

    @Override
    public void run() {
        // Validate files exists
        final var sqlPath = new File(path);
        if (!sqlPath.exists()) {
            System.err.println("The path does not exist!");
            return;
        }

        final AbstractFileSystemDatabaseCliDAO databaseDAO = databaseDAO();

        try {
            databaseDAO.createDatabase();
        } catch (Exception ex) {
            System.out.print("Seems database already exists, do you want to continue installing? (y/N): ");
            try (var reader = new Scanner(new InputStreamReader(System.in))) {
                final var input = reader.next();
                if (!"y".equalsIgnoreCase(input) && !"yes".equalsIgnoreCase(input)) {
                    return;
                }
            }
        }

        databaseDAO.updates(sqlPath);

        databaseDAO.basic(sqlPath);

        System.out.println("Database installation complete.");
    }

    private AbstractFileSystemDatabaseCliDAO databaseDAO() {
        overrideConfigs(Config.gameServer());
        return new GameServerFileSystemDatabaseCliDAO();
    }

    private void overrideConfigs(Mutable databaseConfiguration) {
        if (url != null) {
            databaseConfiguration.setProperty("DatabaseURL", url);
        }

        if (user != null) {
            databaseConfiguration.setProperty("DatabaseUser", user);
        }

        if (password != null) {
            databaseConfiguration.setProperty("DatabasePassword", password);
        }

        if (name != null) {
            databaseConfiguration.setProperty("DatabaseName", name);
        }
    }
}
