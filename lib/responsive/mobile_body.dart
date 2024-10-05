import 'package:flutter/material.dart';
import 'package:otop_front/components/auth.dart';
import 'package:otop_front/responsive/constant.dart';

// import 'package:otop_web_app/pages/cashier_dashboard.dart';
// import 'package:otop_web_app/pages/supplier_dashboard.dart';
// import 'package:otop_web_app/components/register.dart';

// import '../pages/admin_dashboard.dart';
// import 'package:otop_web_app/responsive/constants.dart';

class MobileBody extends StatefulWidget {
  const MobileBody({super.key});

  @override
  State<MobileBody> createState() => _MobileBodyState();
}

class _MobileBodyState extends State<MobileBody> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text('O T O P . P H'),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 16, 136, 165),
      ),
      backgroundColor: myDefaultBackground,
      // drawer: myDrawer,

      body: const SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(16.0),
              // child: Text(
              //   'User Access',
              //   style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              // ),
            ),
            SizedBox(height: 20),
            AuthForm(),
            // SizedBox(height: 20),
            // RegisterForm(),
            //   AdminDashboard(),
            //   CashierDashboard(),
            //   SupplierDashboard(),
          ],
        ),
      ),
    );
  }
}