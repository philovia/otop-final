import 'package:flutter/material.dart';
import 'package:otop_front/widget/costom_listview.dart';

class CustomContainer extends StatelessWidget {
  const CustomContainer({super.key});

  @override
  Widget build(BuildContext context) {
    // get the width of the screen
    double screenWidth = MediaQuery.of(context).size.width;

    // set the container width
    double containerWidth;
    if (screenWidth <= 500) {
      containerWidth = screenWidth * 0.9; // magagamit yung .9 percent ng screen
    } else if (screenWidth > 500 && screenWidth <= 1100) {
      containerWidth = 500; // magagmmit yug max widt ng screen na 500
    } else {
      containerWidth =
          1100; // use a larger screen more than the 1100 screen size
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[400],
        title: Center(child: Text('On Sales', style: TextStyle(fontSize: 16))),
      ),
      body: Center(
        child: Container(
          width: containerWidth,
          height: 550,
          // padding: EdgeInsets.all(1.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20.0),
              bottomRight: Radius.circular(20.0),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(0, 3),
              )
            ],
          ),
          // to put the listview inside the container
          child: ListViewWidget(),
        ),
      ),
    );
  }
}

void main() {
  runApp(
    MaterialApp(
      home: CustomContainer(),
    ),
  );
}
