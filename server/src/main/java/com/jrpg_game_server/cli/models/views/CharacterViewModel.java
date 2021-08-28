package com.jrpg_game_server.cli.models.views;

import com.jrpg_game_server.cli.entities.Character;

public class CharacterViewModel {
    private String id;
    private String nickname;
    private int hp;
    private int level;
    private int mana;
    private int offsetX;
    private int offsetY;

    public static CharacterViewModel toViewModel(Character character) {
        CharacterViewModel characterViewModel = new CharacterViewModel();
        if(character != null) {
            characterViewModel.setId(character.getId().toString());
            characterViewModel.setNickname(character.getNickname());
            characterViewModel.setHp(character.getHp());
            characterViewModel.setMana(character.getMana());
            characterViewModel.setLevel(character.getLevel());
            characterViewModel.setOffsetX(character.getOffsetX());
            characterViewModel.setOffsetY(character.getOffsetY());
        }
        return characterViewModel;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getNickname() {
        return nickname;
    }

    public void setNickname(String nickname) {
        this.nickname = nickname;
    }

    public int getHp() {
        return hp;
    }

    public void setHp(int hp) {
        this.hp = hp;
    }

    public int getLevel() {
        return level;
    }

    public void setLevel(int level) {
        this.level = level;
    }

    public int getMana() {
        return mana;
    }

    public void setMana(int mana) {
        this.mana = mana;
    }

    public int getOffsetX() {
        return offsetX;
    }

    public void setOffsetX(int offsetX) {
        this.offsetX = offsetX;
    }

    public int getOffsetY() {
        return offsetY;
    }

    public void setOffsetY(int offsetY) {
        this.offsetY = offsetY;
    }
}
