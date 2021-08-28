package com.jrpg_game_server.cli.entities;

import java.util.Map;
import java.util.UUID;

public class Character {
    private UUID id;
    private String nickname;
    private int hp;
    private int level;
    private int mana;
    private int offsetX;
    private int offsetY;

    public Character() {
    }

    public Character(UUID id, String nickname, int hp, int mana, int level, int offsetX, int offsetY) {
        this.id = id;
        this.nickname = nickname;
        this.hp = hp;
        this.level = level;
        this.mana = mana;
        this.offsetX = offsetX;
        this.offsetY = offsetY;
    }

    public Character(String nickname, int hp, int mana) {
        this.nickname = nickname;
        this.hp = hp;
        this.mana = mana;
    }

    public UUID getId() {
        return id;
    }

    public void setId(UUID id) {
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

    public static Character map(Map<String,Object> objectMap) {
        Character character = new Character();
        character.setId((UUID) objectMap.get("id"));
        character.setNickname((String) objectMap.get("nickname"));
        character.setLevel((Integer) objectMap.get("character_level"));
        character.setHp((Integer) objectMap.get("hp"));
        character.setMana((Integer) objectMap.get("mana"));
        character.setOffsetX((Integer) objectMap.get("offsetx"));
        character.setOffsetY((Integer) objectMap.get("offsety"));

        return character;
    }
}
