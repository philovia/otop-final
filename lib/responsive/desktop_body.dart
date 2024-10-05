import 'package:flutter/material.dart';
import 'package:otop_front/components/auth.dart';
// import 'package:otop_front/responsive/constant.dart';

class DesktopBody extends StatefulWidget {
  const DesktopBody({super.key});

  @override
  State<DesktopBody> createState() => _DesktopBodyState();
}

class _DesktopBodyState extends State<DesktopBody> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[400],
        elevation: 0,
        title: const Text('O T O P . P H', selectionColor: Colors.white),
        centerTitle: true,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Stack(
            children: [
              // Background image
              Container(
                width: constraints.maxWidth, // Full width of the screen
                height: constraints.maxHeight, // Full height of the screen
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("images/otop.png"), // Your image path
                    fit: BoxFit.cover, // Cover the entire background
                  ),
                ),
              ),
              // Login/Register form
              const SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(16.0),
                    ),
                    SizedBox(height: 20),
                    AuthForm(),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}