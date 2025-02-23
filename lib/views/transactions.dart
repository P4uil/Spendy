import 'package:flutter/material.dart';

class TransactionsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "Transactions",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 36,
            ),
          ),
        ),
      ),
    );
  }
}
