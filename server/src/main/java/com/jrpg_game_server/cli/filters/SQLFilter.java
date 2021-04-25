package com.jrpg_game_server.cli.filters;

import java.io.File;
import java.io.FileFilter;

public class SQLFilter implements FileFilter {
    @Override
    public boolean accept(File f) {
        if ((f == null) || !f.isFile()) {
            return false;
        }
        return f.getName().toLowerCase().endsWith(".sql");
    }
}
