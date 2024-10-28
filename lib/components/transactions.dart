import 'package:flutter/material.dart';

void main() {
  runApp(MyTransaction());
}

class MyTransaction extends StatelessWidget {
  const MyTransaction({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Center(child: Text('Transaction List')),
        ),
        body: TransactionList(),
      ),
    );
  }
}

class Transaction {
  final String cashier;
  final String date;

  Transaction({required this.cashier, required this.date});
}

class TransactionList extends StatefulWidget {
  const TransactionList({super.key});

  @override
  TransactionListState createState() => TransactionListState();
}

class TransactionListState extends State<TransactionList> {
  List<Transaction> transactions = [
    Transaction(cashier: 'Cashier 1', date: '2024-10-01'),
    Transaction(cashier: 'Cashier 2', date: '2024-10-02'),
    Transaction(cashier: 'Cashier 3', date: '2024-10-03'),
  ];

  void _deleteTransaction(int index) {
    setState(() {
      transactions.removeAt(index);
    });
  }

  void addTransaction(String cashier, String date) {
    setState(() {
      transactions.add(Transaction(cashier: cashier, date: date));
    });
  }

  void _showAddTransactionDialog(BuildContext context) {
    final cashierController = TextEditingController();
    final dateController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add Transaction'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: cashierController,
                decoration: InputDecoration(labelText: 'Cashier Name'),
              ),
              TextField(
                controller: dateController,
                decoration: InputDecoration(labelText: 'Date (YYYY-MM-DD)'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                final cashier = cashierController.text;
                final date = dateController.text;
                if (cashier.isNotEmpty && date.isNotEmpty) {
                  addTransaction(cashier, date);
                  Navigator.of(context).pop();
                }
              },
              child: Text('Add'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double cardWidth =
            constraints.maxWidth < 400 ? constraints.maxWidth : 400;

        return Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: transactions.length,
                itemBuilder: (context, index) {
                  return Container(
                    width: cardWidth,
                    margin: EdgeInsets.all(8.0),
                    child: Card(
                      child: ListTile(
                        title: Text(
                          transactions[index].cashier,
                          style: TextStyle(fontSize: cardWidth < 400 ? 14 : 16),
                        ),
                        subtitle: Text(
                          transactions[index].date,
                          style: TextStyle(fontSize: cardWidth < 400 ? 12 : 14),
                        ),
                        trailing: IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () => _deleteTransaction(index),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            FloatingActionButton(
              onPressed: () => _showAddTransactionDialog(context),
              tooltip: 'Add Transaction',
              child: Icon(Icons.add),
            ),
          ],
        );
      },
    );
  }
}
