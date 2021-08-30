package com.jrpg_game_server.cli.models.binding;

public class CharacterBindingModel {
    private String id;
    private String nickname;
    private int hp;
    private int mana;
    private int level;
    private int offsetX;
    private int offsetY;
    private String action;
    private String direction;

    public CharacterBindingModel() { }

    public CharacterBindingModel(String id, String nickname, int hp, int mana, int level,
                                 int offsetX, int offsetY, String action, String direction) {
        this.id = id;
        this.nickname = nickname;
        this.hp = hp;
        this.mana = mana;
        this.level = level;
        this.offsetX = offsetX;
        this.offsetY = offsetY;
        this.action = action;
        this.direction = direction;
    }

    public String getId() {
        return id;
    }

    public String getNickname() {
        return nickname;
    }

    public int getHp() {
        return hp;
    }

    public int getMana() {
        return mana;
    }

    public int getLevel() {
        return level;
    }

    public int getOffsetX() {
        return offsetX;
    }

    public int getOffsetY() {
        return offsetY;
    }

    public String getAction() {
        return action;
    }

    public String getDirection() {
        return direction;
    }
}
