import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ServicesProvider with ChangeNotifier {
  SharedPreferences? _prefs;

  /// تحميل SharedPreferences داخل init
  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  String get token => _prefs?.getString('token') ?? '';

  String get role => _prefs?.getString('role') ?? '';

  bool get isLoggedIn => _prefs?.getBool('isLoggin') ?? false;

  Future<void> saveTokenAndRole(String token, String role) async {
    await _prefs?.setString('token', token);
    await _prefs?.setString('role', role);
    await _prefs?.setBool('isLoggin', true);
    notifyListeners();
  }

  Future<void> logout() async {
    await _prefs?.remove('token');
    await _prefs?.remove('role');
    await _prefs?.remove('isLoggin');
    notifyListeners();
  }
}
