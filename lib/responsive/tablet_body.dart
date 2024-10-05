import 'package:flutter/material.dart';
import 'package:otop_front/components/auth.dart';

import 'package:otop_front/responsive/constant.dart';

// import 'constants.dart';

class TabletBody extends StatefulWidget {
  const TabletBody({super.key});

  @override
  State<TabletBody> createState() => _TabletBodyState();
}

class _TabletBodyState extends State<TabletBody> {
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
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(16),
                constraints: const BoxConstraints(
                  maxWidth: 1100, // max width for the tablet layout
                ),
                child: const AuthForm(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}