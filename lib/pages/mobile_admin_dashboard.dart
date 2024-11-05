import 'package:flutter/material.dart';
import 'package:otop_front/components/transactions.dart';
// import 'package:otop_front/components/admin_sales.dart';
// import 'package:otop_app/components/admin_on_sales.dart';
// import 'package:otop_front/components/on_sales.dart';
// import 'package:otop_app/components/admin_orders.dart';
// import 'package:otop_app/components/admin_purchases.dart';
// import 'package:otop_app/components/admin_sales.dart';
// import 'package:otop_app/components/supplier_my_product.dart';
// import 'package:otop_app/responsive/constants.dart';
import 'package:otop_front/responsive/constant.dart';
// import 'package:otop_web_app/responsive/constants.dart';


class MobileAdminDashboard extends StatefulWidget {
  const MobileAdminDashboard({super.key});


  @override
  State<MobileAdminDashboard> createState() => _MobileAdminDashboardState();
}


class _MobileAdminDashboardState extends State<MobileAdminDashboard> {
  Widget _currentWidget = MyTransaction();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: myDefaultBackground,
      appBar: AppBar(
        elevation: 0,
        title: const Text('ADMIN DASHBOARD'),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 16, 136, 165),
      ),
      drawer: Drawer(
        // backgroundColor: Color.fromARGB(255, 16, 136, 165),
        child: Container(
          color: const Color.fromARGB(255, 16, 136, 165),
          child: ListView(
            children: [
              DrawerHeader(
                child: Image.asset(
                  'images/otopph.png',
                  height: 150,
                  width: 150,
                ),
              ),
              ListTile(
                leading: const Icon(Icons.home),
                title: const Text(
                  'Sales',
                  style: TextStyle(fontSize: 20),
                ),
                onTap: () {
                  setState(() {
                    _currentWidget = MyTransaction();
                  });
                  Navigator.of(context).pop(); // Close the drawer
                },
              ),
              // Add more ListTile widgets for other categories if needed
              ListTile(
                leading: const Icon(Icons.shopping_bag),
                title: const Text(
                  'Orders',
                  style: TextStyle(fontSize: 20),
                ),
                onTap: () {
                  setState(() {
                    // _currentWidget = const OrderListWidget();
                  });
                  Navigator.of(context).pop(); // Close the drawer
                },
              ),
              // Add more ListTile widgets for other categories if needed
              ListTile(
                leading: const Icon(Icons.handshake),
                title: const Text(
                  'On Sales',
                  style: TextStyle(fontSize: 20),
                ),
                onTap: () {
                  setState(() {
                    // _currentWidget = const AdminOnSales();
                  });
                  Navigator.of(context).pop(); // Close the drawer
                },
              ),
              // ListTile(
              //   leading: const Icon(Icons.hardware_rounded),
              //   title: const Text(
              //     'Purchases',
              //     style: TextStyle(fontSize: 20),
              //   ),
              //   onTap: () {
              //     setState(() {
              //       _currentWidget = const PurchasesScreen();
              //     });
              //     Navigator.of(context).pop();
              //   },
              // )
            ],
          ),
        ),
      ),
      body: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 1700),
          padding: const EdgeInsets.all(16),
          child: Align(
            alignment: Alignment.center,
            child: _currentWidget,
          ),
        ),
      ), // Display the selected widget (default is the dashboard content)
    );
  }
}



