
class CharacterModel {
  late String id;
  late String nickname;
  late int hp;
  late int level;
  late int mana;
  late int offsetX;
  late int offsetY;

  CharacterModel({id, nickname, hp, level, mana, offsetX, offsetY}) {
    this.id = id;
    this.nickname = nickname;
    this.hp = hp;
    this.level = level;
    this.mana = mana;
    this.offsetX = offsetX;
    this.offsetY = offsetY;
  }

  static List<CharacterModel> fromJson(List<dynamic>? json) {
    List<CharacterModel> characters = [];
    json!.forEach((myMap) {
      characters.add(
          CharacterModel(
              id: myMap['id'],
              nickname: myMap['nickname'],
              hp: myMap['hp'],
              level: myMap['level'],
              mana: myMap['mana'],
              offsetX: myMap['offsetX'],
              offsetY: myMap['offsetY'],
          ));
    });
    return characters;
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'hp': hp,
    'level': level,
    'mana': mana,
    'offsetX': offsetX,
    'offsetY': offsetY,
  };
}
