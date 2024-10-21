// supplier_list_page.dart

// ignore_for_file: use_key_in_widget_constructors, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:otop_front/services/supplier_product_service.dart';
import 'package:otop_front/models/supplier_model.dart';

class SupplierListPage extends StatefulWidget {
  @override
  _SupplierListPageState createState() => _SupplierListPageState();
}

class _SupplierListPageState extends State<SupplierListPage> {
  late SupplierService _supplierService;
  late Future<List<Supplier>> _suppliersFuture;

  @override
  void initState() {
    super.initState();
    _supplierService =
        SupplierService('https://your-api-url.com'); // Set your base URL
    _suppliersFuture = _supplierService.fetchSuppliers();
  }

  // Function to show supplier details
  void showSupplierDetails(Supplier supplier) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Supplier Details'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Store Name: ${supplier.storeName}'),
              // You can add more details here if needed
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  // Optionally navigate to an edit page here
                },
                child: Text('Edit Details'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: Text('Supplier List')),
      body: FutureBuilder<List<Supplier>>(
        future: _suppliersFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No suppliers found.'));
          } else {
            final suppliers = snapshot.data!;
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: DataTable(
                  columns: const [
                    DataColumn(label: Text('Store Name')),
                    DataColumn(label: Text('Actions')),
                  ],
                  rows: suppliers.map((supplier) {
                    return DataRow(cells: [
                      DataCell(
                        Text(supplier.storeName),
                        onTap: () {
                          showSupplierDetails(supplier); // Show details on tap
                        },
                      ),
                      DataCell(
                        IconButton(
                          icon: Icon(Icons.info),
                          onPressed: () {
                            showSupplierDetails(
                                supplier); // Show details on icon press
                          },
                        ),
                      ),
                    ]);
                  }).toList(),
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
