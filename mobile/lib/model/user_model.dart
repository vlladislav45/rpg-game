
import 'character_model.dart';

class UserModel {
  late final String _id;
  late final String _username;
  late final String _email;
  late final List<CharacterModel> _characters;
  late final String _userRole;

  UserModel(this._id, this._username, this._email, this._characters);

  UserModel.clear() {
    this._id = '';
    this._username = '';
    this._email = '';
    this._characters = [];
  }

  UserModel.fromJson(Map<String, dynamic>? json) {
    this._id = json!['id'];
    this._username = json['username'];
    this._email = json['email'];
    this._characters = CharacterModel.fromJson(json['characters']);
    this._userRole = json['userRole'];
  }

  String get userRole => _userRole;

  set userRole(String value) {
    _userRole = value;
  }

  List<CharacterModel> get characters => _characters;

  set characters(List<CharacterModel> value) {
    _characters = value;
  }

  String get email => _email;

  set email(String value) {
    _email = value;
  }

  String get username => _username;

  set username(String value) {
    _username = value;
  }

  String get id => _id;

  set id(String value) {
    _id = value;
  }
}