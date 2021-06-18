
class CharacterModel {
  late final String _id;
  late final String _nickname;
  late final int _hp;
  late final int _level;
  late final int _mana;

  CharacterModel(this._id, this._nickname, this._hp, this._level, this._mana);

  static List<CharacterModel> fromJson(List<dynamic>? json) {
    List<CharacterModel> characters = [];
    json!.forEach((myMap) {
      characters.add(
          CharacterModel(myMap['id'],
              myMap['nickname'],
              myMap['hp'],
              myMap['level'],
              myMap['mana'],
          ));
    });
    return characters;
  }

  int get mana => _mana;

  int get level => _level;

  int get hp => _hp;

  String get nickname => _nickname;

  String get id => _id;
}