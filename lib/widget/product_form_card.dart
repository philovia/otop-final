import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../models/product.dart'; 
import '../providers/product_provider.dart'; 

class ProductFormCard extends StatefulWidget {
  final VoidCallback onAddProduct;
  final VoidCallback onDelete;

  const ProductFormCard({
    super.key,
    required this.onAddProduct,
    required this.onDelete,
  });

  @override
  ProductFormCardState createState() => ProductFormCardState();
}

class ProductFormCardState extends State<ProductFormCard> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _categoryController = TextEditingController();
  final TextEditingController _stockController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();

  XFile? _pickedImage;

  // Getter for total price
  double get totalPrice {
    double price = double.tryParse(_priceController.text) ?? 0.0;
    int stock = int.tryParse(_stockController.text) ?? 0;
    return price * stock; // Calculate total price
  }

  // Getters for the product fields
  String get name => _nameController.text;
  String get description => _descriptionController.text;
  String get category => _categoryController.text;
  int get stock => int.tryParse(_stockController.text) ?? 0;
  double get price => double.tryParse(_priceController.text) ?? 0.0;
  String? get imagePath => _pickedImage?.path;


  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _pickedImage = image;
    });
  }

  void _submitForm() {
    if (_formKey.currentState!.validate() && _pickedImage != null) {
      final product = Product(
        name: _nameController.text,
        description: _descriptionController.text,
        category: _categoryController.text,
        stock: int.parse(_stockController.text),
        price: double.parse(_priceController.text),
        imagePath: _pickedImage!.path,
      );

      // Add the product to the provider
      Provider.of<ProductProvider>(context, listen: false).addProduct(product);

      // Call the callback to refresh the UI and allow another product to be added
      widget.onAddProduct();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      margin: EdgeInsets.all(12),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              GestureDetector(
                onTap: _pickImage,
                child: Container(
                  height: 150,
                  width: 50,
                  decoration: BoxDecoration(
                    border: Border.all(color: const Color.fromARGB(255, 142, 83, 83)),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: _pickedImage != null
                      ? Image.file(File(_pickedImage!.path), fit: BoxFit.cover)
                      : Center(child: Text("Upload Product Image")),
                ),
              ),  
              SizedBox(height: 5),
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(labelText: "Product Name", labelStyle: TextStyle(fontSize: 13)),
                validator: (value) => value == null || value.isEmpty ? "Enter product name" : null,
              ),
              TextFormField(
                controller: _descriptionController,
                decoration: InputDecoration(labelText: "Description", labelStyle: TextStyle(fontSize: 13)),
                validator: (value) => value == null || value.isEmpty ? "Enter product description" : null,
              ),
              TextFormField(
                controller: _categoryController,
                decoration: InputDecoration(labelText: "Category", labelStyle: TextStyle(fontSize: 13)),
                validator: (value) => value == null || value.isEmpty ? "Enter category" : null,
              ),
              TextFormField(
                controller: _stockController,
                decoration: InputDecoration(labelText: "Stock", labelStyle: TextStyle(fontSize: 13)),
                style: TextStyle(fontSize: 10),
                keyboardType: TextInputType.number,
                validator: (value) => value == null || value.isEmpty ? "Enter stock" : null,
              ),
              TextFormField(
                controller: _priceController,
                decoration: InputDecoration(labelText: "Price", labelStyle: TextStyle(fontSize: 13)),
              style: TextStyle(fontSize: 10),
                keyboardType: TextInputType.number,
                validator: (value) => value == null || value.isEmpty ? "Enter price" : null,
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: _submitForm,
                child: Text("Add Product", style: TextStyle(fontSize: 10),),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: widget.onDelete, // Directly use the callback
                style: ElevatedButton.styleFrom(backgroundColor: Color.fromARGB(255, 16, 136, 165),),
                child: Text("Delete Product", style: TextStyle(fontSize: 10, color: const Color.fromARGB(255, 0, 0, 0)),), // Red color for delete
              ),
            ],
          ),
        ),
      ),
    );
  }
}
