
class CharacterModel {
  late String id;
  late String nickname;
  late int hp;
  late int level;
  late int mana;
  late int offsetX;
  late int offsetY;
  late String action;
  late String direction;

  CharacterModel({id, nickname, hp, level, mana, offsetX, offsetY, action, direction}) {
    this.id = id;
    this.nickname = nickname;
    this.hp = hp;
    this.level = level;
    this.mana = mana;
    this.offsetX = offsetX;
    this.offsetY = offsetY;
    this.action = action;
    this.direction = direction;
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
              action: myMap['action'],
              direction: myMap['direction'],
          ));
    });
    return characters;
  }

  CharacterModel.fromJsonSingle(Map<String,dynamic>? json) {
      this.id = json!['id'];
      nickname = json['nickname'];
      hp = json['hp'];
      level = json['level'];
      mana = json['mana'];
      offsetX = json['offsetX'];
      offsetY = json['offsetY'];
      action = json['action'];
      direction = json['direction'];
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'hp': hp,
    'level': level,
    'mana': mana,
    'offsetX': offsetX,
    'offsetY': offsetY,
    'action': action,
    'direction': direction,
  };
}
