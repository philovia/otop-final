import 'package:http/http.dart' as http; // For making HTTP requests
import 'dart:convert'; // For converting the response to JSON
import 'package:flutter/material.dart'; // Import Flutter Material for navigation

class AuthService {
  Future<void> logout(BuildContext context, String token) async {
    final response = await http.post(
      Uri.parse('http://127.0.0.1:8083/api/logout'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
    } else {
      throw Exception(json.decode(response.body)['error'] ?? 'Logout failed');
    }
  }
}
