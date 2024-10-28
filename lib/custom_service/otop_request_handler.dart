// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:http/http.dart';
import 'package:logger/logger.dart';

class ResponseModel {
  final bool success;
  final String message;
  final dynamic data;
  final logger = Logger();

  ResponseModel({required this.success, required this.message, this.data});

  factory ResponseModel.fromJson(Map<String, dynamic> json) {
    return ResponseModel(
      success: json['retCode'] == '200',
      message: json['message'],
      data: json['data'],
    );
  }

  bool get isSuccess => success;
  String get errorMessage => message;
}

Future<ResponseModel> requestMidleware({
  required String url,
  required Map<String, String> headers,
  required String body,
  required int failedCode,
}) async {
  try {
    final response = await post(
      Uri.parse(url),
      headers: headers,
      body: body,
    );

    // print('Response status code: ${response.statusCode}');
    // print('Response headers: ${response.headers}');

    if (response.statusCode == failedCode) {
      throw Exception('Failed to make the request: ${response.body}');
    }

    // Log response body for debugging
    // print('Response body: ${response.body}');

    if (response.body.isEmpty) {
      throw FormatException('Empty response body');
    }

    return ResponseModel.fromJson(jsonDecode(response.body));
  } catch (e) {
    ('Error occurred: $e');
    throw Exception('Error occurred: $e');
  }
}

Future<ResponseModel> requestMidleware1({
  required String url,
  required Map<String, String> headers,
  required int failedCode,
  required String body,
}) async {
  try {
    final response = await get(
      Uri.parse(url),
      headers: headers,
    );

    // print('Response status code: ${response.statusCode}');
    // print('Response headers: ${response.headers}');

    if (response.statusCode == failedCode) {
      throw Exception('Failed to make the request: ${response.body}');
    }

    // Log response body for debugging
    // print('Response body: ${response.body}');

    if (response.body.isEmpty) {
      throw FormatException('Empty response body');
    }
    return ResponseModel.fromJson(json.decode(utf8.decode(response.bodyBytes)));
  } catch (e) {
    print('Error occurred: $e');
    throw Exception('Error occurred: $e');
  }
}

Future<ResponseModel> requestMidleware2({
  required String url,
  required Map<String, String> headers,
  required String body,
  required int failedCode,
}) async {
  try {
    final response = await put(
      Uri.parse(url),
      headers: headers,
      body: body,
    );

    print('Response body: $body');

    print('Response status code: ${response.statusCode}');
    print('Response headers: ${response.headers}');

    if (response.statusCode == failedCode) {
      throw Exception('Failed to make the request: ${response.body}');
    }

    // Log response body for debugging
    print('Response body: ${response.body}');

    if (response.body.isEmpty) {
      throw FormatException('Empty response body');
    }

    return ResponseModel.fromJson(jsonDecode(response.body));
  } catch (e) {
    print('Error occurred: $e');
    throw Exception('Error occurred: $e');
  }
}
