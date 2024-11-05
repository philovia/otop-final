import 'package:shared_preferences/shared_preferences.dart';

class TokenUtil {
  static const String _tokenKey = 'token';

  static Future<void> saveToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_tokenKey, token);
  }

  static Future<String?> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_tokenKey);
  }

  static Future<void> clearToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(_tokenKey);
  }

  static Future<void> loadTokenAndRedirect(
      Function(String role) onRedirect) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString(_tokenKey);

    String role = await fetchRoleFromBackendOrDecode(token!);
    onRedirect(role);
    }

  static Future<String> fetchRoleFromBackendOrDecode(String token) async {
    return 'admin';
  }
}
