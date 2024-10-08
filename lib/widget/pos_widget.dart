import 'package:flutter/material.dart';
import 'cart_dialog.dart';  

// Cart Item Model
class CartItem {
  final Product product;
  final int quantity;

  CartItem({required this.product, required this.quantity});
}

// Product Model
class Product {
  final String name;
  final double price;
  int stock;

  Product({required this.name, required this.price, required this.stock});
}

// POSWidget for the main POS system
class POSWidget extends StatefulWidget {
  const POSWidget({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _POSWidgetState createState() => _POSWidgetState();
}

class _POSWidgetState extends State<POSWidget> {
  final List<Product> products = [
    Product(name: 'Turmeric Brew 20grams', price: 50.0, stock: 20),
    Product(name: 'Turmeric Brew 500grams', price: 150.0, stock: 50),
    Product(name: 'Turmeric Brew 250grams', price: 90.0, stock: 30),
    Product(name: 'Turmeric Flower 250grams', price: 90.0, stock: 30),
    Product(name: 'Turmeric Tea 250grams', price: 90.0, stock: 30),
    Product(name: 'Turmeric Coffee 250grams', price: 90.0, stock: 30),
    Product(name: 'Turmeric Brew 250grams', price: 90.0, stock: 30),
    Product(name: 'Turmeric Brew 250grams', price: 90.0, stock: 30),
    Product(name: 'Turmeric Organic 250grams', price: 90.0, stock: 30),
  ];

  List<Product> filteredProducts = [];
  List<CartItem> cart = [];  // List to store selected products for the cart
  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    filteredProducts = products;  // Initially, show all products
  }

  void filterProducts(String query) {
    final filtered = products.where((product) {
      final nameLower = product.name.toLowerCase();
      final queryLower = query.toLowerCase();
      return nameLower.contains(queryLower);
    }).toList();

    setState(() {
      filteredProducts = filtered;
    });
  }

  // Add a product to the cart with a specific quantity
  void addToCart(Product product, int quantity) {
    if (quantity > product.stock) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Not enough stock available')),
      );
      return;
    }

    setState(() {
      cart.add(CartItem(product: product, quantity: quantity));
      product.stock -= quantity;  // Decrease stock after adding to cart
    });
  }

  // Calculate the total price of the cart
  double calculateTotalPrice() {
    double total = 0;
    for (var item in cart) {
      total += item.product.price * item.quantity;
    }
    return total;
  }

  // Show a dialog to add a product to the cart with quantity control
  void showAddToCartDialog(Product product) {
    int quantity = 1; // Start with 1 by default

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder( // To update the quantity inside the dialog
          builder: (context, setState) {
            return AlertDialog(
              title: Text('Add to Cart'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Available stock: ${product.stock}'),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        icon: Icon(Icons.remove),
                        onPressed: quantity > 1
                            ? () {
                                setState(() {
                                  quantity--;
                                });
                              }
                            : null, // Disable if quantity is 1
                      ),
                      Text('Php $quantity', style: TextStyle(fontSize: 18)),
                      IconButton(
                        icon: Icon(Icons.add),
                        onPressed: quantity < product.stock
                            ? () {
                                setState(() {
                                  quantity++;
                                });
                              }
                            : null, // Disable if no more stock is available
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Price: Php${(product.price * quantity).toStringAsFixed(2)}',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('Cancel'),
                ),
                ElevatedButton(
                  onPressed: () {
                    addToCart(product, quantity);
                    Navigator.of(context).pop();
                  },
                  child: Text('Add to Cart'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  // Show Cart Dialog
  void showCartDialog() {
    double totalPrice = calculateTotalPrice();

    showDialog(
      context: context,
      builder: (context) {
        return CartDialog(cart: cart, totalPrice: totalPrice);  // Call CartDialog from cart_dialog.dart
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Custom header with search field and cart icon
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: searchController,
                    decoration: InputDecoration(
                      labelText: 'Search Product',
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (query) {
                      filterProducts(query);
                    },
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.shopping_cart),
                  onPressed: () {
                    showCartDialog(); // Open the cart dialog when cart icon is pressed
                  },
                ),
              ],
            ),
            SizedBox(height: 16.0),

            // Product ListView
            Expanded(
              child: searchController.text.isNotEmpty // Check if there's a search query
                  ? filteredProducts.isNotEmpty
                      ? ListView.builder(
                          itemCount: filteredProducts.length,
                          itemBuilder: (context, index) {
                            final product = filteredProducts[index];
                            return ListTile(
                              title: Text('${product.name} (Php${product.price})'),
                              subtitle: Text('Stock: ${product.stock}'),
                              trailing: IconButton(
                                icon: Icon(Icons.add_shopping_cart),
                                onPressed: () {
                                  showAddToCartDialog(product); // Show dialog to add to cart
                                },
                              ),
                            );
                          },
                        )
                      : Center(
                          child: Text('No products found matching your search'),
                        )
                  : Center(
                      child: Text('Please enter a search query to see products'),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: POSWidget(),
  ));
}
