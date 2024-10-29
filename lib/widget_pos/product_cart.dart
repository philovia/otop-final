// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:otop_front/widget_pos/search_bar.dart';

class ProductCard extends StatefulWidget {
  final String productName;
  final double price;

  const ProductCard({required this.productName, required this.price});

  @override
  _ProductCardState createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  late TextEditingController _controller;
  int _quantity = 1;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: '$_quantity');
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _incrementQuantity() {
    setState(() {
      _quantity++;
      _controller.text = '$_quantity';
    });
  }

  void _decrementQuantity() {
    setState(() {
      if (_quantity > 1) {
        _quantity--;
        _controller.text = '$_quantity';
      }
    });
  }

  void _updateQuantity(String value) {
    setState(() {
      _quantity = int.tryParse(value) ?? 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.productName,
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                Text("Php${widget.price.toStringAsFixed(2)}",
                    style: TextStyle(color: Colors.grey[700])),
              ],
            ),
            Spacer(),
            IconButton(
              icon: Icon(Icons.remove),
              onPressed: _decrementQuantity,
            ),
            SizedBox(
              width: 50,
              child: TextField(
                controller: _controller,
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                onChanged: _updateQuantity,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(vertical: 5),
                ),
              ),
            ),
            IconButton(
              icon: Icon(Icons.add),
              onPressed: _incrementQuantity,
            ),
          ],
        ),
      ),
    );
  }
}

Widget productList() {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Column(
      children: [
        searchBar(),
        Expanded(
          child: ListView(
            children: [
              ProductCard(productName: 'Macchiato Milk Tea', price: 63.00),
              ProductCard(productName: 'Cheese Milk Tea', price: 126.00),
              ProductCard(productName: 'Latte Milk Tea', price: 54.00),
              ProductCard(productName: 'Cheese Milk Tea', price: 126.00),
              ProductCard(productName: 'Macchiato Milk Tea', price: 63.00),
              ProductCard(productName: 'Macchiato Milk Tea', price: 63.00),
              ProductCard(productName: 'Macchiato Milk Tea', price: 63.00),
              ProductCard(productName: 'Macchiato Milk Tea', price: 63.00),
            ],
          ),
        ),
      ],
    ),
  );
}
