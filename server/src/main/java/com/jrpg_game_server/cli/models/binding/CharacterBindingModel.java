package com.jrpg_game_server.cli.models.binding;

public class CharacterBindingModel {
    private String id;
    private String nickname;
    private int hp;
    private int mana;
    private int level;
    private int offsetX;
    private int offsetY;

    public CharacterBindingModel() {
    }

    public CharacterBindingModel(String id, String nickname, int hp, int mana, int level) {
        this.id = id;
        this.nickname = nickname;
        this.hp = hp;
        this.mana = mana;
        this.level = level;
    }

    public String getId() {
        return id;
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

    public int getMana() {
        return mana;
    }

    public void setMana(int mana) {
        this.mana = mana;
    }

    public int getLevel() {
        return level;
    }

    public void setLevel(int level) {
        this.level = level;
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
