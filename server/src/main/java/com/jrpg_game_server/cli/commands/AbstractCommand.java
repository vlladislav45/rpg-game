package com.jrpg_game_server.cli.commands;

import java.io.FilterInputStream;
import java.io.IOException;

public abstract class AbstractCommand implements Runnable {
    protected static final String YES = "y";

    protected static final FilterInputStream FILTER_INPUT_STREAM = new FilterInputStream(System.in) {
        @Override
        public void close() throws IOException {
            // Do not close it.
        }
    };
}
