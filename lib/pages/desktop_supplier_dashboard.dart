import 'package:flutter/material.dart';
import 'package:otop_front/components/add_product_screen.dart';
import 'package:otop_front/components/order_list.dart';
import 'package:otop_front/components/transactions.dart';
// import 'package:otop_front/components/transactions.dart';
// import 'package:otop_front/components/supplier_list.dart';
import 'package:otop_front/responsive/constant.dart';
import 'package:otop_front/services/logout_services.dart';
import 'package:otop_front/widget/custom_container.dart';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

class DesktopSupplierDashboard extends StatefulWidget {
  const DesktopSupplierDashboard({super.key});

  @override
  State<DesktopSupplierDashboard> createState() =>
      _DesktopSupplierDashboardState();
}

class _DesktopSupplierDashboardState extends State<DesktopSupplierDashboard> {
  Widget _currentWidget = AddProductScreen();

  // Instance of AuthService
  final AuthService _authService = AuthService();

  // Function to handle logout
  Future<void> _logout() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token'); // Retrieve your token here

    try {
      // Call the logout method without passing context
      // ignore: use_build_context_synchronously
      await _authService.logout(context, token!);
      // After the logout, check if the widget is still mounted before using context
      if (mounted) {
        // Show a success message or navigate to the login screen
        Navigator.of(context)
            .pushReplacementNamed('/login'); // Adjust based on your routing
      }
    } catch (e) {
      // Check if the widget is still mounted before showing a Snackbar
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.toString())),
        );
      }
    }
  }

  // Function to show confirmation dialog before logout
  void _showLogoutConfirmationDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirm Logout'),
          content: Text('Are you sure you want to logout?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                _logout(); // Call the logout function
              },
              child: Text('Yes'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: myDefaultBackground,
      body: Column(
        children: [
          // AppBar
          PreferredSize(
            preferredSize: Size.fromHeight(90),
            child: AppBar(
              elevation: 0,
              title: Row(
                children: [
                  Image.asset(
                    'images/otopph.png',
                    height: 50,
                    width: 50,
                  ),
                  SizedBox(width: 575),
                  Text('SUPPLIER DASHBOARD',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white)),
                ],
              ),
              backgroundColor: Color.fromARGB(255, 16, 136, 165),
            ),
          ),
          // Main content
          Expanded(
            child: Row(
              children: [
                // Sidebar
                Container(
                  width: 200,
                  color: Color.fromARGB(255, 16, 136, 165),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 10),
                      ListTile(
                        leading: Icon(Icons.home),
                        title: Text(
                          'My Product',
                          style: TextStyle(fontSize: 13),
                        ),
                        onTap: () {
                          setState(() {
                            _currentWidget = AddProductScreen();
                          });
                        },
                      ),
                      Divider(
                        color: Color.fromARGB(207, 88, 86, 86),
                      ),
                      ListTile(
                        leading: Icon(Icons.shopping_bag),
                        title: Text(
                          'Orders',
                          style: TextStyle(fontSize: 13),
                        ),
                        onTap: () {
                          setState(() {
                            _currentWidget = OrderList();
                          });
                        },
                      ),
                      Divider(
                        color: Color.fromARGB(207, 88, 86, 86),
                      ),
                      ListTile(
                        leading: Icon(Icons.add_box),
                        title: Text(
                          'Transactions',
                          style: TextStyle(fontSize: 13),
                        ),
                        onTap: () {
                          setState(() {
                            _currentWidget = MyTransaction();
                          });
                        },
                      ),
                      Divider(
                        color: Color.fromARGB(207, 88, 86, 86),
                      ),
                      ListTile(
                        leading: Icon(Icons.shopping_bag_rounded),
                        title: Text(
                          'On Sales',
                          style: TextStyle(fontSize: 13),
                        ),
                        onTap: () {
                          setState(() {
                            _currentWidget = CustomContainer();
                          });
                        },
                      ),
                      Spacer(),
                      ListTile(
                        leading: Icon(Icons.logout),
                        title: Text(
                          'Logout',
                          style: TextStyle(fontSize: 13),
                        ),
                        onTap: _showLogoutConfirmationDialog,
                      ),
                    ],
                  ),
                ),
                // Main content area
                Expanded(
                  child: Center(
                    child: Container(
                      constraints: const BoxConstraints(maxWidth: 1700),
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20.0),
                        topRight: Radius.circular(20.0),
                      )),
                      child: Align(
                        alignment: Alignment.center,
                        child: _currentWidget,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
