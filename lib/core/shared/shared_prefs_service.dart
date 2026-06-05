import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService {
  final SharedPreferences _prefs;
  SharedPreferencesService(this._prefs);

  static const _tokenKey = 'jwt_token';

  Future<void> saveToken(String token) async {
    await _prefs.setString(_tokenKey, token);
  }

  String? getToken() {
    return _prefs.getString(_tokenKey);
  }

  Future<void> deleteToken() async {
    await _prefs.remove(_tokenKey);
  }

  bool hasToken() {
    return _prefs.containsKey(_tokenKey);
  }
}
