// supplier_service.dart

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:otop_front/models/supplier_model.dart';

class SupplierService {
  final String baseUrl; // Replace with your actual base URL

  SupplierService(this.baseUrl);

  Future<List<Supplier>> fetchSuppliers() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/suppliers'));

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((json) => Supplier.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load suppliers');
      }
    } catch (e) {
      throw Exception('Failed to fetch suppliers: $e');
    }
  }
}
