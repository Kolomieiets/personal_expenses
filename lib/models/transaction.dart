import 'package:flutter/foundation.dart';

class Transaction {
  final String id;
  final String title;
  final double amount;
  final DateTime date;

  Transaction({
    required this.id,
    required this.title,
    required this.amount,
    required this.date,
  });

  // Transaction copyWith({
  //   String? id,
  //   String? title,
  //   double? amount,
  //   DateTime? date,
  // }) {
  //   return Transaction(
  //     id: id ?? this.id,
  //     title: title ?? this.title,
  //     amount: amount ?? this.amount,
  //     date: date ?? this.date,
  //   );
  // }
}
