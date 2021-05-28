package com.jrpg_game_server.cli.dao;

import com.jrpg_game_server.cli.config.ServerConfig;
import com.jrpg_game_server.cli.filters.SQLFilter;

import java.io.File;
import java.util.Arrays;
import java.util.prefs.Preferences;

public abstract class AbstractFileSystemDatabaseCliDAO extends AbstractCliDAO {
    AbstractFileSystemDatabaseCliDAO(ServerConfig server) {
        super(server);
    }

    public void basic(File sqlPath) {
        System.out.println("Installing basic SQL scripts...");
        final var files = sqlPath.listFiles(new SQLFilter());
        runSQLFiles(files);
    }

    protected void updates(String cleanup, File sqlPath) {
        final var userPreferences = Preferences.userRoot();
        final var updatePath = new File(sqlPath, "updates");
        final var updatePreferences = getDatabase() + "_update";

        System.out.println("Executing cleanup script...");

        runSQLFiles(new File(sqlPath, cleanup));

        if (updatePath.exists()) {
            final var sb = new StringBuilder();
            for (var sqlFile : updatePath.listFiles(new SQLFilter())) {
                sb.append(sqlFile.getName() + ';');
            }
            userPreferences.put(updatePreferences, sb.toString());
        }
    }

    public void updates(File sqlPath) {
        updates("cleanup/cleanup.sql", sqlPath);
    }

    private void runSQLFiles(File... sqlFiles) {
        Arrays.sort(sqlFiles);

        for (var sqlFile : sqlFiles) {
            try {
                System.out.println("Running " + sqlFile.getName() + "...");
                executeSQLScript(sqlFile);
            } catch (Exception ex) {
                System.err.println("There has been an error executing SQL file " + sqlFile.getName() + "!");
                ex.printStackTrace();
            }
        }
    }
}
