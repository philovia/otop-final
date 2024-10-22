// service.dart

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:logging/logging.dart' as logging;

class AddSupplierService {
  final String apiUrl = 'http://127.0.0.1:8083/admin/supplier';

  // Initialize logger
  final log = logging.Logger('UserService');

  // Function to register a new user
  Future<bool> registerUser(Map<String, String> userData) async {
    try {
      log.info('Sending data to the backend...');
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(userData),
      );

      if (response.statusCode == 200) {
        log.info('User registered successfully');
        return true;
      } else {
        log.warning('Failed to register user');
        return false;
      }
    } catch (e) {
      log.severe('Error registering user: $e');
      return false;
    }
  }
}
