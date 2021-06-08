package com.jrpg_game_server.cli.utils;

import java.io.InputStream;
import java.io.InputStreamReader;

public class CloseShieldInputStreamReader extends InputStreamReader {
    public CloseShieldInputStreamReader(InputStream inputStream) {
        super(inputStream);
    }

    @Override
    public void close() {
        // Do nothing.
    }
}
