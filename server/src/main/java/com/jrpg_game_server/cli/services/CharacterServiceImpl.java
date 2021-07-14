package com.jrpg_game_server.cli.services;

import com.jrpg_game_server.cli.dao.CharacterDAO;
import com.jrpg_game_server.cli.entities.Character;
import com.jrpg_game_server.cli.services.base.CharacterService;

public class CharacterServiceImpl implements CharacterService {
    private final CharacterDAO characterDAO;

    public CharacterServiceImpl(CharacterDAO characterDAO) {
        this.characterDAO = characterDAO;
    }

    @Override
    public void update(Character character) {
        this.characterDAO.update(character);
    }
}
