package com.jrpg_game_server.cli.dao;

public interface BaseDAO<T> {
    void add(T object);

    T getById(int id);

    void removeById(int id);

    void update(T element);

    int count();

}
