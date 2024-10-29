// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';

class CheckoutSection extends StatefulWidget {
  const CheckoutSection({super.key});

  @override
  _CheckoutSectionState createState() => _CheckoutSectionState();
}

class _CheckoutSectionState extends State<CheckoutSection> {
  double total = 243.00;
  double received = 0.00;
  double change = 0.00;

  List<Map<String, dynamic>> billItems = [
    {'name': 'Macchiato Milk Tea', 'price': 63.00},
    {'name': 'Cheese Milk Tea', 'price': 126.00},
    {'name': 'Latte Milk Tea', 'price': 54.00},
    {'name': 'Latte Milk Tea', 'price': 54.00},
    {'name': 'Latte Milk Tea', 'price': 54.00},
    {'name': 'Latte Milk Tea', 'price': 54.00},
    {'name': 'Latte Milk Tea', 'price': 54.00},
    {'name': 'Latte Milk Tea', 'price': 54.00},
    {'name': 'Cheese Milk Tea', 'price': 126.00},
    {'name': 'Cheese Milk Tea', 'price': 126.00},
    {'name': 'Cheese Milk Tea', 'price': 126.00},
    {'name': 'Cheese Milk Tea', 'price': 126.00},
    {'name': 'Cheese Milk Tea', 'price': 126.00},
  ];

  void calculateChange() {
    setState(() {
      change = received - total;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: const Color.fromARGB(255, 194, 192, 192).withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Bill',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: billItems.map((item) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                    child: Text(
                        '${item['name']}: Php${item['price'].toStringAsFixed(2)}'),
                  );
                }).toList(),
              ),
            ),
          ),
          Divider(),
          Text('Total: Php${total.toStringAsFixed(2)}',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          SizedBox(height: 10),
          Row(
            children: [
              Text('Received: Php', style: TextStyle(fontSize: 18)),
              SizedBox(width: 10),
              Expanded(
                child: TextField(
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    received = double.tryParse(value) ?? 0.00;
                    calculateChange();
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: '0.00',
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          Wrap(
            spacing: 10.0,
            runSpacing: 10.0,
            children: [20, 50, 100, 200, 500, 500].map((amount) {
              return ElevatedButton(
                onPressed: () {
                  setState(() {
                    received = amount.toDouble();
                    calculateChange();
                  });
                },
                child: Text('Php$amount'),
              );
            }).toList(),
          ),
          SizedBox(height: 10),
          Text('Change: Php${change.toStringAsFixed(2)}',
              style: TextStyle(fontSize: 18)),
          SizedBox(height: 10),
          // paymentButtons(),
          SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {},
            child: Text('Invoice Printing'),
          ),
        ],
      ),
    );
  }
}
