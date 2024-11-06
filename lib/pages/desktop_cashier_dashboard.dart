// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
// import 'package:otop_front/components/custom_container_addsup.dart';

import 'package:otop_front/responsive/constant.dart';
import 'package:otop_front/services/logout_services.dart';
import 'package:otop_front/widget/pos_widget.dart';
import 'package:otop_front/widget/product_listCont.dart';

import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

class DesktopCashierDashboard extends StatefulWidget {
  const DesktopCashierDashboard({super.key});

  @override
  State<DesktopCashierDashboard> createState() =>
      _DesktopCashierDashboardState();
}

class _DesktopCashierDashboardState extends State<DesktopCashierDashboard> {
  Widget _currentWidget = POSScreen();

  final AuthService _authService = AuthService();

  double totalPrice = 0.0;
  int totalStock = 0;
  List<dynamic> cartItems = [];
  int productCount = 0;

  Future<void> _logout() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');

    try {
      await _authService.logout(context, token!);
      if (!mounted) {
        Navigator.of(context).pushReplacementNamed('/login');
      }
    } catch (e) {
      if (!mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.toString())),
        );
      }
    }
  }

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
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _logout();
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
                  Text('CASHIER DASHBOARD',
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
                        leading: Icon(Icons.shopping_bag),
                        title: Text(
                          'P O S',
                          style: TextStyle(fontSize: 13),
                        ),
                        onTap: () {
                          setState(() {
                            _currentWidget = POSScreen();
                          });
                        },
                      ),
                      Divider(color: const Color.fromARGB(207, 88, 86, 86)),
                      ListTile(
                        leading: Icon(Icons.shopping_bag),
                        title: Text(
                          'Receipts',
                          style: TextStyle(fontSize: 13),
                        ),
                        onTap: () {
                          setState(() {
                            // _currentWidget = CustomContainerCashier();
                          });
                        },
                      ),
                      Divider(color: const Color.fromARGB(207, 88, 86, 86)),
                      ListTile(
                        leading: Icon(Icons.add_box),
                        title: Text(
                          'Products',
                          style: TextStyle(fontSize: 13),
                        ),
                        onTap: () {
                          setState(() {
                            _currentWidget = ProductListScreen();
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
                      // padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          // borderRadius: BorderRadius.only(topLeft:Radius.circular(20.0),
                          // topRight: Radius.circular(20.0),)
                          ),
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
