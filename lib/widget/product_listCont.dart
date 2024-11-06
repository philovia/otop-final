// ignore_for_file: file_names

import 'package:flutter/material.dart';

class ProductListScreen extends StatelessWidget {
  const ProductListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Product List'),
      // ),
      body: Column(
        children: [
          // Action bar with options
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                DropdownButton<String>(
                  hint: Text("Choose action"),
                  items:
                      <String>['Delete', 'Update Product'].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (_) {},
                ),
                Row(
                  children: [
                    ElevatedButton(
                      onPressed: () {},
                      child: Text("Show all"),
                    ),
                    SizedBox(width: 10),
                    SizedBox(
                      width: 200,
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Search for a product...',
                          prefixIcon: Icon(Icons.search),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    IconButton(
                      icon: Icon(Icons.filter_list),
                      onPressed: () {},
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue),
                      child: Text("+ Add new product"),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Divider(),

          // Table header
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: [
                Checkbox(value: false, onChanged: (_) {}),
                Expanded(
                    child: Text("Name",
                        style: TextStyle(fontWeight: FontWeight.bold))),
                Expanded(
                    child: Text("Description",
                        style: TextStyle(fontWeight: FontWeight.bold))),
                Expanded(
                    child: Text("Category",
                        style: TextStyle(fontWeight: FontWeight.bold))),
                Expanded(
                    child: Text("Price",
                        style: TextStyle(fontWeight: FontWeight.bold))),
                Expanded(
                    child: Text("Quantity",
                        style: TextStyle(fontWeight: FontWeight.bold))),
                Expanded(
                    child: Text("Modified",
                        style: TextStyle(fontWeight: FontWeight.bold))),
              ],
            ),
          ),
          Divider(),

          // List of products
          Expanded(
            child: ListView.builder(
              itemCount: 5, // Example count
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Checkbox(value: false, onChanged: (_) {}),
                          Expanded(
                              child: Text("Product ${index + 1}",
                                  style: TextStyle(
                                      color: Colors.blue,
                                      fontWeight: FontWeight.bold))),
                          Expanded(child: Text("Lorem ipsum dolor")),
                          Expanded(child: Text("Category ${index + 1}")),
                          Expanded(child: Text("\$${(index + 1) * 10}")),
                          Expanded(child: Text("Quantity ${(index + 1) * 5}")),
                          Expanded(child: Text("1.8.2017")),
                        ],
                      ),
                      Divider(),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
