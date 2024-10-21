// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:otop_front/components/custom_container_addsup.dart';
import 'package:otop_front/components/custom_container_supselect.dart';
import 'package:otop_front/components/on_sales.dart';
// import 'package:otop_front/components/supplier_list.dart';
import 'package:otop_front/components/transactions.dart';
import 'package:otop_front/responsive/constant.dart';
import 'package:otop_front/services/logout_services.dart';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

class DesktopAdminDashboard extends StatefulWidget {
  const DesktopAdminDashboard({super.key});

  @override
  State<DesktopAdminDashboard> createState() => _DesktopAdminDashboardState();
}

class _DesktopAdminDashboardState extends State<DesktopAdminDashboard> {
  Widget _currentWidget = CustomContainerCashier();

  final AuthService _authService = AuthService();
  bool _isSuppliersExpanded = false;

  Future<void> _logout() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token'); // Retrieve your token here

    try {
      await _authService.logout(context, token!);
      if (mounted) {
        Navigator.of(context).pushReplacementNamed('/login');
      }
    } catch (e) {
      if (mounted) {
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
                  Text('ADMIN DASHBOARD',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white)),
                ],
              ),
              backgroundColor: Color.fromARGB(255, 6, 122, 151),
            ),
          ),
          Expanded(
            child: Row(
              children: [
                Container(
                  width: 200,
                  color: Color.fromARGB(255, 6, 122, 151),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 10),
                      ListTile(
                        leading: Icon(Icons.shopping_bag),
                        iconColor: const Color.fromARGB(255, 228, 224, 224),
                        title: Text(
                          'Suppliers',
                          style: TextStyle(fontSize: 13),
                        ),
                        dense: true,
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                        trailing: Icon(
                          _isSuppliersExpanded
                              ? Icons.expand_less
                              : Icons.expand_more,
                          color: const Color.fromARGB(255, 228, 224, 224),
                        ),
                        onTap: () {
                          setState(() {
                            _isSuppliersExpanded =
                                !_isSuppliersExpanded; // Toggle dropdown
                          });
                        },
                      ),
                      if (_isSuppliersExpanded)
                        Column(
                          children: [
                            ListTile(
                              title: Text(
                                'Add Supplier',
                                style: TextStyle(fontSize: 12),
                              ),
                              dense: true,
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 52, vertical: 0),
                              onTap: () {
                                setState(() {
                                  _currentWidget = CustomContainerCashier();
                                  _isSuppliersExpanded =
                                      false; // Close dropdown
                                });
                              },
                            ),
                            ListTile(
                              title: Text(
                                'Supplier Selection',
                                style: TextStyle(fontSize: 10),
                              ),
                              dense: true,
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 52, vertical: 0),
                              onTap: () {
                                setState(() {
                                  _currentWidget = CustomContainerSupselect();
                                  _isSuppliersExpanded =
                                      false; // Close dropdown
                                });
                              },
                            ),
                            ListTile(
                              title: Text(
                                'Supplier Page',
                                style: TextStyle(fontSize: 12),
                              ),
                              dense: true,
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 52, vertical: 0),
                              onTap: () {
                                setState(() {
                                  // _currentWidget = SupplierList();
                                  _isSuppliersExpanded =
                                      false; // Close dropdown
                                });
                              },
                            ),
                            ListTile(
                              title: Text(
                                'Cart',
                                style: TextStyle(fontSize: 12),
                              ),
                              dense: true,
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 52, vertical: 0),
                              onTap: () {
                                setState(() {
                                  // _currentWidget = SupplierList();
                                  _isSuppliersExpanded =
                                      false; // Close dropdown
                                });
                              },
                            ),
                          ],
                        ),
                      Divider(
                          color: const Color.fromARGB(207, 88, 86,
                              86)), // Divider after Suppliers category

                      ListTile(
                        leading: Icon(Icons.home),
                        iconColor: const Color.fromARGB(255, 228, 224, 224),
                        title: Text(
                          'Transacions',
                          style: TextStyle(fontSize: 13),
                        ),
                        dense: true,
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                        onTap: () {
                          setState(() {
                            _currentWidget = OnSales();
                          });
                        },
                      ),
                      Divider(
                          color: const Color.fromARGB(
                              207, 88, 86, 86)), // Divider after Sales category

                      ListTile(
                        leading: Icon(Icons.add_box),
                        iconColor: const Color.fromARGB(255, 228, 224, 224),
                        title: Text(
                          'Product List',
                          style: TextStyle(fontSize: 13),
                        ),
                        dense: true,
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                        onTap: () {
                          setState(() {
                            _currentWidget = MyTransaction();
                          });
                        },
                      ),
                      Divider(
                          color: const Color.fromARGB(207, 88, 86,
                              86)), // Divider after Transactions category

                      ListTile(
                        leading: Icon(Icons.shopping_bag_rounded),
                        iconColor: const Color.fromARGB(255, 228, 224, 224),
                        title: Text(
                          'Sales',
                          style: TextStyle(fontSize: 13),
                        ),
                        dense: true,
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                        onTap: () {
                          setState(() {
                            _currentWidget = OnSales();
                          });
                        },
                      ),
                      Spacer(),
                      // Divider(), // Divider before Logout

                      ListTile(
                        leading: Icon(Icons.logout),
                        iconColor: const Color.fromARGB(255, 228, 224, 224),
                        title: Text(
                          'Logout',
                          style: TextStyle(fontSize: 13),
                        ),
                        dense: true,
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                        onTap: _showLogoutConfirmationDialog,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Center(
                    child: Container(
                      // constraints: const BoxConstraints(maxWidth: 1700),

                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(98, 151, 147, 147),
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
