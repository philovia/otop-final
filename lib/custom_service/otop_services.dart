import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:otop_front/api_constants.dart';
import 'package:otop_front/models/supplier_model.dart';
import 'package:otop_front/token_util/token_util.dart';
// import 'package:otop_front/widget/supplier_product_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SupplierService {
  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  Future<List<Supplier>> fetchAllSuppliers() async {
    final token = await TokenUtil.getToken();
    final response = await http.get(
      Uri.parse(ApiConstants.getAllSuppliers),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((supplier) => Supplier.fromJson(supplier)).toList();
    } else {
      throw Exception('Failed to load suppliers');
    }
  }

  // Create a new supplier (Authenticated request)
  // Future<void> createSupplier(Supplier supplier) async {
  //   final token = await TokenUtil.getToken();
  //   final response = await http.post(
  //     Uri.parse(ApiConstants.createSupplier),
  //     headers: {
  //       'Content-Type': 'application/json',
  //       'Authorization': 'Bearer $token', // Include the token here
  //     },
  //     body: json.encode(supplier.toJson()),
  //   );

  //   if (response.statusCode != 201) {
  //     throw Exception('Failed to create supplier');
  //   }
  // }

  // Future<void> updateSupplier(Supplier supplier) async {
  //   final token = await TokenUtil.getToken();
  //   final response = await http.put(
  //     Uri.parse('${ApiConstants.updateSupplier}${supplier.id}'),
  //     headers: {
  //       'Content-Type': 'application/json',
  //       'Authorization': 'Bearer $token',
  //     },
  //     body: json.encode(supplier.json()),
  //   );

  //   if (response.statusCode != 200) {
  //     throw Exception('Failed to update supplier');
  //   }
  // }

  Future<void> deleteSupplier(int id) async {
    final token = await TokenUtil.getToken();
    final response = await http.delete(
      Uri.parse('${ApiConstants.deleteSupplier}$id'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode != 204) {
      throw Exception('Failed to delete supplier');
    }
  }
}

Future<Supplier?> fetchSupplierByStoreName(String storeName) async {
  final token = await TokenUtil.getToken();
  final response = await http.get(
    Uri.parse('${ApiConstants.getSupplierByStoreName}$storeName'),
    headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    },
  );

  if (response.statusCode == 200) {
    return Supplier.fromJson(json.decode(response.body));
  } else if (response.statusCode == 404) {
    throw Exception('Supplier not found');
  } else {
    throw Exception('Failed to fetch supplier by store name');
  }
}

Future<Supplier?> getSupplierByEmail(String email) async {
  final token = TokenUtil.getToken();
  final response = await http.get(
    Uri.parse('${ApiConstants.getSupplierByEmail}$email'),
    headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    },
  );
  if (response.statusCode == 200) {
    return Supplier.fromJson(json.decode(response.body));
  } else if (response.statusCode == 404) {
    throw Exception('Supplier Email not found');
  } else {
    throw Exception('Failed to get supplier email');
  }
}
