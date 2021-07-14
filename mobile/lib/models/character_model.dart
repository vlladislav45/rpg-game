
class CharacterModel {
  late String id;
  late String nickname;
  late int hp;
  late int level;
  late int mana;

  CharacterModel({id, nickname, hp, level, mana}) {
    this.id = id;
    this.nickname = nickname;
    this.hp = hp;
    this.level = level;
    this.mana = mana;
  }

  static List<CharacterModel> fromJson(List<dynamic>? json) {
    List<CharacterModel> characters = [];
    json!.forEach((myMap) {
      characters.add(
          CharacterModel(id: myMap['id'],
              nickname: myMap['nickname'],
              hp: myMap['hp'],
              level: myMap['level'],
              mana: myMap['mana'],
          ));
    });
    return characters;
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'hp': hp,
    'mana': mana,
    'level': level,
  };
}