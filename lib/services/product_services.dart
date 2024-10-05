import 'dart:convert';
// import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';

class ProductService {
  final String _baseUrl = "http://127.0.0.1:8083/api/products"; // Update with your backend URL

  Future<String?> _uploadImage(String? imagePath) async {
    if (imagePath == null) return null;

    var request = http.MultipartRequest(
      'POST',
      Uri.parse(_baseUrl), // Update with your upload URL
    );

    request.files.add(await http.MultipartFile.fromPath(
      'image', // This should match your backend parameter name
      imagePath,
      filename: basename(imagePath),
    ));

    var response = await request.send();
    if (response.statusCode == 200) {
      
      var responseBody = await response.stream.bytesToString();
      var jsonResponse = json.decode(responseBody);
      return jsonResponse['file_path']; 
    } else {
      throw Exception("Failed to upload image");
    }
  }

  Future<void> saveAllProducts(List<Map<String, dynamic>> productDataList) async {
    for (var productData in productDataList) {
      // Handle image upload if necessary
      final imagePath = await _uploadImage(productData["image"]); // If you're saving the image
      if (imagePath != null) {
        productData["file_path"] = imagePath;
      }

      // Send the product data to the backend
      final response = await http.post(
        Uri.parse(_baseUrl),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(productData),
      );

      if (response.statusCode != 200) {
        throw Exception("Failed to save product");
      }
    }
  }
}
