import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreferencesService {
  final SharedPreferences _prefs = GetIt.I<SharedPreferences>();

  String? get key => _prefs.getString('key');

  Future setKey(String value) async {
    await _prefs.setString('key', value);
  }
}
