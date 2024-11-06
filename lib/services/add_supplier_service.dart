// service.dart

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:logging/logging.dart' as logging;
import 'package:shared_preferences/shared_preferences.dart';

class AddSupplierService {
<<<<<<< HEAD
  final String baseUrl = 'http://127.0.0.1:8096'; 
  final log = logging.Logger('AddSupplierService');
=======
  final String apiUrl = 'http://127.0.0.1:8096/supplier';
  final String getAllSuppliersUrl = 'http://127.0.0.1:8096/supplier';

  final log = logging.Logger('UserService');
>>>>>>> 74c189b (okay admin and supplier logreg)

  // Register User Method
  Future<bool> registerUser(Map<String, String> userData) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token');

      log.info('Sending supplier registration data to the backend...');
      final response = await http.post(
        Uri.parse('$baseUrl/supplier'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(userData),
      );

      return _handleRegistrationResponse(response);
    } catch (e) {
      log.severe('Error registering supplier: $e');
      return false;
    }
  }

  // Fetch All Suppliers Method
  Future<List<Map<String, dynamic>>?> fetchAllSuppliers() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token');

      log.info('Fetching all registered suppliers from the backend...');
      final response = await http.get(
        Uri.parse('$baseUrl/supplier'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      return _handleFetchResponse(response);
    } catch (e) {
      log.severe('Error fetching suppliers: $e');
      return null;
    }
  }


  bool _handleRegistrationResponse(http.Response response) {
    final responseBody = jsonDecode(response.body);
    if (response.statusCode == 201) {
      log.info('Supplier registered successfully: ${response.body}');
      return true;
    } else {
      log.warning('Failed to register supplier: ${responseBody['error']}');
      return false;
    }
  }

  // Response Handler for Fetching Suppliers
  List<Map<String, dynamic>>? _handleFetchResponse(http.Response response) {
    if (response.statusCode == 200) {
      log.info('Suppliers fetched successfully.');
      List<dynamic> data = jsonDecode(response.body);
      return List<Map<String, dynamic>>.from(data);
    } else {
      final responseBody = jsonDecode(response.body);
      log.warning('Failed to fetch suppliers: ${responseBody['error']}');
      return null;
    }
  }
}
