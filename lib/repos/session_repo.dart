import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

const namespace = 'session';

class LocalSessionRepo {
  final SharedPreferences _prefs = GetIt.I.get<SharedPreferences>();

  void setSessionKey(String value) {
    _prefs.setString('$namespace/key', value);
  }

  String? getSessionKey() {
    return _prefs.getString('$namespace/key');
  }

  void setPhoneNumber(String value) {
    _prefs.setString('$namespace/phoneNumber', value);
  }

  String? getPhoneNumber() {
    return _prefs.getString('$namespace/phoneNumber');
  }
}
