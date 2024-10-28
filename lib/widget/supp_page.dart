import 'package:flutter/material.dart';

class SuppPage extends StatelessWidget {
  final Map<String, dynamic> supplier;

  const SuppPage({super.key, required this.supplier});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${supplier['store_name'] ?? 'Supplier Details'}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Store Name: ${supplier['store_name'] ?? 'N/A'}',
                style: const TextStyle(fontSize: 18)),
            SizedBox(height: 8.0),
            Text('Email: ${supplier['email'] ?? 'N/A'}',
                style: const TextStyle(fontSize: 16)),
            SizedBox(height: 8.0),
            Text('Phone Number: ${supplier['phone_number'] ?? 'N/A'}',
                style: const TextStyle(fontSize: 16)),
            SizedBox(height: 8.0),
            Text('Address: ${supplier['address'] ?? 'N/A'}',
                style: const TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
