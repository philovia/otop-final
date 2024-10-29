import 'package:flutter/material.dart';
import 'package:otop_front/widget_pos/checkout_section.dart';
import 'package:otop_front/widget_pos/product_cart.dart';
// import 'package:otop_front/widget_pos/product_cart.dart';

class POSScreen extends StatelessWidget {
  const POSScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Text('POS System'),
          ],
        ),
      ),
      body: Row(
        children: [
          Expanded(flex: 2, child: productList()),
          Expanded(flex: 1, child: CheckoutSection()),
        ],
      ),
    );
  }
}
