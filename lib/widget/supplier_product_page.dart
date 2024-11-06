import 'package:flutter/material.dart';
import 'package:otop_front/services/add_supplier_service.dart';

class SupplierListWidget extends StatefulWidget {
  const SupplierListWidget({super.key});

  @override
  _SupplierListWidgetState createState() => _SupplierListWidgetState();
}

class _SupplierListWidgetState extends State<SupplierListWidget> {
  final AddSupplierService _supplierService = AddSupplierService();
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

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
  void initState() {
    super.initState();
    _searchController.addListener(() {
      setState(() {
        _searchQuery = _searchController.text.toLowerCase();
      });
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Search Field Container (aligned to the right)
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
            child: Row(
              children: [
                // Align search field to the right
                Expanded(
                  child:
                      Container(), // Empty container to take space on the left
                ),
                // Search Field (not expanded, aligned to the right)
                SizedBox(
                  width: 250, // You can adjust the width as per requirement
                  child: TextField(
                    controller: _searchController,
                    decoration: const InputDecoration(
                      labelText: 'Search Store Name',
                      border: OutlineInputBorder(),
                      isDense: true,
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Table Header with Store Name and Supplier Details
          Container(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            color: Colors.grey[300],
            child: Row(
              children: [
                const Expanded(
                  flex: 2,
                  child: Center(
                    child: Row(
                      children: [
                        SizedBox(width: 15),
                        Text(
                          'Store Name',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const Expanded(
                  flex: 1,
                  child: Center(
                    child: Text(
                      'Supplier Details',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: FutureBuilder<List<Map<String, dynamic>>?>(
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
                  final suppliers = snapshot.data!
                      .where((supplier) => supplier['store_name']
                          .toString()
                          .toLowerCase()
                          .contains(_searchQuery))
                      .toList();
                  return ListView.separated(
                    itemCount: suppliers.length,
                    separatorBuilder: (context, index) => const Divider(
                      thickness: 0.5,
                      height: 8.0,
                    ),
                    itemBuilder: (context, index) {
                      final supplier = suppliers[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: Text(
                                supplier['store_name'] ?? 'Unknown Supplier',
                                style: const TextStyle(
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromARGB(255, 47, 47, 49),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: TextButton(
                                onPressed: () => _showSupplierDetails(supplier),
                                child: const Text(
                                  'See Details',
                                  style: TextStyle(fontSize: 12.0),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
