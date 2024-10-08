  import 'package:flutter/material.dart';
  import 'pos_widget.dart';  

  // CartDialog Widget
  class CartDialog extends StatelessWidget {
    final List<CartItem> cart;  // List of items in the cart
    final double totalPrice;    // Total price of the cart
    

    const CartDialog({super.key, required this.cart, required this.totalPrice});

    @override
    Widget build(BuildContext context) {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        elevation: 16,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min, // Makes the dialog wrap the content size
            children: [
              // Dialog Title
              Text(
                'Your Cart',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16.0),

              // List of Cart Items
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: cart.length,
                  itemBuilder: (context, index) {
                    final cartItem = cart[index];
                    return ListTile(
                      title: Text(cartItem.product.name),
                      subtitle: Text('Quantity: ${cartItem.quantity}'),
                      trailing: Text(
                        'Php${(cartItem.product.price * cartItem.quantity).toStringAsFixed(2)}',
                      ),
                    );
                  },
                ),
              ),

              SizedBox(height: 16.0),

              // Total Price
              Text(
                'Total: Php${totalPrice.toStringAsFixed(2)}',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),

              SizedBox(height: 16.0),

              // Proceed to Payment Button
              ElevatedButton(
                onPressed: () {
                  // Handle the payment logic here
                  Navigator.of(context).pop();  // Close the dialog
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Proceeding to payment...')),
                  );
                },
                child: Text('Proceed to Pay'),
              ),
            ],
          ),
        ),
      );
    }
  }
