package com.jrpg_game_server.cli.dao;

import com.jrpg_game_server.cli.config.Config;
import com.jrpg_game_server.cli.entities.Character;
import com.jrpg_game_server.cli.entities.User;

import java.util.*;

public class CharacterDAO extends AbstractDatabaseCliDAO implements BaseDAO<Character> {
    private static final String CHARACTER_TABLE_NAME = "character";
    private static final String CHARACTERS_TABLE_NAME = "characters";

    public CharacterDAO() {
        super(Config.databaseConfig());
    }

    @Override
    public void add(Character character) {
        String query = "INSERT INTO " + CHARACTER_TABLE_NAME +
                "(nickname, character_level, hp, mana) VALUES (?,?,?,?)";

        this.executeQuery(query, character);
    }

    public void linkCharacterToUser(Character character, User user) {
        String query = "INSERT INTO " + CHARACTERS_TABLE_NAME +
                "(user_id, character_id) VALUES (?,?)";

        this.executeQuery(query, user.getId(), character.getId());
    }

    @Override
    public Character getById(UUID characterId) {
        String query = "SELECT * FROM " + CHARACTER_TABLE_NAME + " WHERE id = '" + characterId + "'";
        Map<String,Object> result = executeQueryWithSingleResult(query);

        return Character.map(result);
    }

    /**
     * Get character of the certain user
     * @param userId
     * @return Set<Character>characters
     */
    public Set<Character> getCharactersByUserId(UUID userId) {
        String query = "SELECT * FROM " + CHARACTERS_TABLE_NAME + " WHERE user_id = '" + userId + "'";
        List<Map<String,Object>> results = executeQueryWithMultipleResult(query);

        Set<Character> characters = new HashSet<>();
        for(Map<String,Object> result : results) {
            UUID characterId = (UUID) result.get("character_id");

            //Query to get character
            characters.add(this.getById(characterId));
        }
        return characters;
    }

    @Override
    public void removeById(int id) {
        //TODO: We have to implement remove row by certain character id
    }

    @Override
    public void update(Character character) {
        String query = "UPDATE " + CHARACTER_TABLE_NAME +
                " SET  character_level = ?," +
                " hp = ?, " +
                " mana = ?," +
                " offsetx = ?, " +
                " offsety = ?, " +
                " action = ?, " +
                " direction = ? " +
                " WHERE id = ?";

        executeQuery(query, character.getLevel(), character.getHp(), character.getMana(),
                character.getOffsetX(), character.getOffsetY(),
                character.getAction(), character.getDirection(), character.getId());
    }
}
