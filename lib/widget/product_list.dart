import 'package:flutter/material.dart';

class Product {
  final String name;
  final double price;
  int stock;

  Product({required this.name, required this.price, required this.stock});
}

class ProductList extends StatefulWidget {
  final Function(Product) onProductAdded;

  const ProductList({super.key, required this.onProductAdded});

  @override
  // ignore: library_private_types_in_public_api
  _ProductListState createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  final List<Product> products = [
    Product(name: 'Turmeric 100grams', price: 50.0, stock: 20),
    Product(name: 'Turmeric 150grams', price: 90.5, stock: 50),
    Product(name: 'Turmeric 200grams', price: 120.2, stock: 30),
  ];

  final TextEditingController nameController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController stockController = TextEditingController();

  // Function to add new products
  void addProduct() {
    final String name = nameController.text;
    final double price = double.tryParse(priceController.text) ?? 0.0;
    final int stock = int.tryParse(stockController.text) ?? 0;

    if (name.isNotEmpty && price > 0 && stock > 0) {
      setState(() {
        final newProduct = Product(name: name, price: price, stock: stock);
        products.add(newProduct);
        widget.onProductAdded(newProduct); // Pass the new product to POSWidget
      });

      // Clear input fields
      nameController.clear();
      priceController.clear();
      stockController.clear();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please enter valid product details')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: TextField(
            controller: nameController,
            decoration: InputDecoration(labelText: 'Product Name'),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: TextField(
            controller: priceController,
            decoration: InputDecoration(labelText: 'Price'),
            keyboardType: TextInputType.number,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: TextField(
            controller: stockController,
            decoration: InputDecoration(labelText: 'Stock'),
            keyboardType: TextInputType.number,
          ),
        ),
        ElevatedButton(
          onPressed: addProduct,
          child: Text('Add Product'),
        ),
        SizedBox(height: 16),
        Expanded(
          child: ListView.builder(
            itemCount: products.length,
            itemBuilder: (context, index) {
              final product = products[index];
              return ListTile(
                title: Text('${product.name} (Php${product.price})'),
                subtitle: Text('Stock: ${product.stock}'),
              );
            },
          ),
        ),
      ],
    );
  }
}
