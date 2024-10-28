// service.dart

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:logging/logging.dart' as logging;
import 'package:shared_preferences/shared_preferences.dart';

class AddSupplierService {
  final String apiUrl = 'http://127.0.0.1:8083/admin/supplier';
  final String getAllSuppliersUrl = 'http://127.0.0.1:8083/admin/suppliers';

  final log = logging.Logger('UserService');

  Future<bool> registerUser(Map<String, String> userData) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token');

      if (token == null) {
        log.warning('No token found, admin must log in.');
        return false;
      }

      log.info('Sending supplier registration data to the backend...');
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(userData),
      );

      if (response.statusCode == 201) {
        log.info('Supplier registered successfully: ${response.body}');
        return true;
      } else {
        final responseBody = jsonDecode(response.body);
        log.warning('Failed to register supplier: ${responseBody['error']}');
        return false;
      }
    } catch (e) {
      log.severe('Error registering supplier: $e');
      return false;
    }
  }

  // this is the service to fetch all the suppliers

  Future<List<Map<String, dynamic>>?> fetchAllSuppliers() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token');

      if (token == null) {
        log.warning('No token found, admin must log in.');
        return null;
      }

      log.info('Fetching all registered suppliers from the backend...');
      final response = await http.get(
        Uri.parse(getAllSuppliersUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        log.info('Suppliers fetched successfully.');
        List<dynamic> data = jsonDecode(response.body);
        return List<Map<String, dynamic>>.from(data);
      } else {
        final responseBody = jsonDecode(response.body);
        log.warning('Failed to fetch suppliers: ${responseBody['error']}');
        return null;
      }
    } catch (e) {
      log.severe('Error fetching suppliers: $e');
      return null;
    }
  }
}
