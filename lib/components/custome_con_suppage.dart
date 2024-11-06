// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
<<<<<<< HEAD
=======
import 'package:otop_front/widget/product_listCont.dart';
>>>>>>> 74c189b (okay admin and supplier logreg)
// import 'package:otop_front/widget/supp_page.dart';

class CustomeConSuppage extends StatelessWidget {
  const CustomeConSuppage({super.key, required});

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    // final Map<String, dynamic> supplier = {};
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(186, 198, 228, 237),
        title: Column(
          children: [
            SizedBox(height: 32.0, width: 20.0),
            Row(
              children: [
                Text('Product List', style: TextStyle(fontSize: 18)),
              ],
            ),
            Divider(color: const Color.fromARGB(223, 137, 134, 134))
          ],
        ),
      ),
      body: Center(
        child: Container(
            // width: containerWidth,

            padding: EdgeInsets.only(
              bottom: 10,
              left: 10,
              right: 10,
            ),
            decoration: BoxDecoration(
              color: Color.fromARGB(186, 198, 228, 237),
              // boxShadow: [
              //   BoxShadow(
              //     color:
              //         const Color.fromARGB(255, 156, 151, 151).withOpacity(0.5),
              //     spreadRadius: 5,
              //     blurRadius: 7,
              //     offset: Offset(0, 3),
              //   )
              // ],
            ),
            // to put the listview inside the container
<<<<<<< HEAD
            // child: SupplierPage(supplier: supplier) // here i will the cart widget 
            ),
=======
            child: ProductListScreen()),
>>>>>>> 74c189b (okay admin and supplier logreg)
      ),
    );
  }
}

void main() {
  runApp(
    MaterialApp(home: CustomeConSuppage()),
  );
}
