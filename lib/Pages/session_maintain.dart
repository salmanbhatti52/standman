// import 'package:shared_preferences/shared_preferences.dart';
//
// class SessionManager {
//   static const String _isLoggedInKey = 'isLoggedIn';
//
//   static Future<bool> isLoggedIn() async {
//     final prefs = await SharedPreferences.getInstance();
//     return prefs.getBool(_isLoggedInKey) ?? false;
//   }
//
//   static Future<void> setLoggedIn(bool value) async {
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.setBool(_isLoggedInKey, value);
//   }
// }
