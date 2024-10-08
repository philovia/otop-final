import 'package:flutter/material.dart';

class ListViewWidget extends StatelessWidget {
  const ListViewWidget({super.key});

  @override
  Widget build(BuildContext context) {
    // Sample data for the list
    final List<String> items = List<String>.generate(10, (index) => 'Product ${index + 1}');

    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        return Card(
          margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          child: ListTile(
            leading: const Icon(Icons.check_circle_outline),
            title: Text(items[index]),
            trailing: Text('Stocks: 24'),
          ),
        );
      },
    );
  }
}
