import 'package:flutter/material.dart';
import 'package:tokmat/domain/entities/transaction_entity.dart';

class TransactionWidget extends StatelessWidget {
  final TransactionEntity transaction;
  const TransactionWidget({super.key, required this.transaction});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 20),
      child: Row(
        children: [
          Flexible(flex: 3, child: Text(transaction.note!)),
          Flexible(flex: 1, child: Text(transaction.total!.toString())),
        ],
      ),
    );
  }
}
