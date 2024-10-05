import 'package:flutter/material.dart';
import 'package:otop_front/components/supplier_list.dart';
// import 'package:otop_app/components/admin_sales.dart';
// import 'package:otop_app/components/admin_on_sales.dart';
// import 'package:otop_app/components/cashier_supplies.dart';
// import 'package:otop_app/responsive/constants.dart';


class MobileCashierDashboard extends StatefulWidget {
  const MobileCashierDashboard({super.key});


  @override
  State<MobileCashierDashboard> createState() => _MobileCashierDashboardState();
}


class _MobileCashierDashboardState extends State<MobileCashierDashboard> {
  Widget _currentWidget = SupplierList();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text('CASHIER DASHBOARD'),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 16, 136, 165),
      ),
      drawer: Drawer(
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
                leading: const Icon(Icons.add_box_sharp),
                title: const Text(
                  'Suppliers',
                  style: TextStyle(fontSize: 20),
                ),
                onTap: () {
                  setState(() {
                    _currentWidget = const SupplierList();
                  });
                  Navigator.of(context).pop();
                },
              )
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
      ),
    );
  }
}



