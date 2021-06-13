package com.jrpg_game_server.cli.dao;

import java.util.UUID;

public interface BaseDAO<T> {
    void add(T object);

    T getById(UUID id);

    void removeById(int id);

    void update(T object, Object... wildParams);
}
