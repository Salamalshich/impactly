import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocaleController extends ChangeNotifier {
  Locale _locale = const Locale('en');
  final SharedPreferences _prefs;

  Locale get locale => _locale;

  LocaleController(this._prefs) {
    // تحميل اللغة مباشرة من الـprefs
    String? code = _prefs.getString('locale');
    if (code != null && ['en', 'ar'].contains(code)) {
      _locale = Locale(code);
    }
  }

  Future<void> setLocale(Locale locale) async {
    if (!['en', 'ar'].contains(locale.languageCode)) return;
    _locale = locale;
    await _prefs.setString('locale', locale.languageCode);
    notifyListeners();
  }

  Future<void> clearLocale() async {
    _locale = const Locale('en');
    await _prefs.setString('locale', 'en');
    notifyListeners();
  }
}
