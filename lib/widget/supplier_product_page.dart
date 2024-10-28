// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:otop_front/services/add_supplier_service.dart';
import 'package:otop_front/widget/supp_page.dart';

class SupplierListWidget extends StatefulWidget {
  const SupplierListWidget({super.key});

  @override
  _SupplierListWidgetState createState() => _SupplierListWidgetState();
}

class _SupplierListWidgetState extends State<SupplierListWidget> {
  final AddSupplierService _supplierService = AddSupplierService();

  // Function to display supplier details in a pop-up dialog
  void _showSupplierDetails(Map<String, dynamic> supplier) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Supplier Details'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Store Name: ${supplier['store_name'] ?? 'N/A'}'),
              Text('Email: ${supplier['email'] ?? 'N/A'}'),
              Text('Phone Number: ${supplier['phone_number'] ?? 'N/A'}'),
              Text('Address: ${supplier['address'] ?? 'N/A'}'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<Map<String, dynamic>>?>(
        future: _supplierService.fetchAllSuppliers(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error fetching suppliers: ${snapshot.error}'),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No suppliers found.'));
          } else {
            final suppliers = snapshot.data!;
            return ListView.separated(
              itemCount: suppliers.length,
              separatorBuilder: (context, index) => Divider(
                thickness: 0.5,
                height: 8.0,
              ),
              itemBuilder: (context, index) {
                final supplier = suppliers[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: ListTile(
                    dense: true,
                    contentPadding: EdgeInsets.zero,
                    title: GestureDetector(
                      onTap: () {
                        // Navigate to the supplier detail page
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => SuppPage(supplier: supplier),
                          ),
                        );
                      },
                      child: Text(
                        supplier['store_name'] ?? 'Unknown Supplier',
                        style: const TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 47, 47, 49)),
                      ),
                    ),
                    trailing: TextButton(
                      onPressed: () => _showSupplierDetails(supplier),
                      child: const Text(
                        'See Details',
                        style: TextStyle(fontSize: 12.0),
                      ),
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
