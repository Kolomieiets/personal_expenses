import 'package:expense_planner/models/transaction.dart';
import 'package:expense_planner/presentation/screens/home_screen/home_screen.dart';
import 'package:expense_planner/presentation/screens/home_screen/components/new_transaction.dart';
import 'package:flutter/material.dart';

mixin HomeScreenMixin<T extends StatefulWidget> on State<HomeScreen> {
  final List<Transaction> userTransactions = [];

  List<Transaction> get recentTransactions {
    return userTransactions.where((tx) {
      return tx.date.isAfter(
        DateTime.now().subtract(
          const Duration(days: 7),
        ),
      );
    }).toList();
  }

  void _addNewTransaction(
    String txTitle,
    double txAmount,
    DateTime chosenDate,
  ) {
    final Transaction newTX = Transaction(
      title: txTitle,
      amount: txAmount,
      date: chosenDate,
      id: DateTime.now().toString(),
    );

    userTransactions.add(newTX);

    setState(() {});
  }

  void startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return GestureDetector(
          onTap: () {},
          behavior: HitTestBehavior.opaque,
          child: NewTransaction(_addNewTransaction),
        );
      },
    );
  }

  void deleteTRansaction(String id) {
    setState(() {
      userTransactions.removeWhere((tx) => tx.id == id);
    });
  }
}
