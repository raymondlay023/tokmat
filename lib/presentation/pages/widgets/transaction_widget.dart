import 'package:flutter/material.dart';
import 'package:tokmat/core/const.dart';
import 'package:tokmat/core/utils.dart';
import 'package:tokmat/domain/entities/transaction_entity.dart';

class TransactionTileWidget extends StatelessWidget {
  final TransactionEntity transaction;
  const TransactionTileWidget({super.key, required this.transaction});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      child: Card(
        child: InkWell(
          onTap: () => Navigator.pushNamed(
            context,
            PageConst.detailTransactionPage,
            arguments: transaction,
          ),
          borderRadius: BorderRadius.circular(12),
          child: Ink(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    flex: 2,
                    child: Text(
                      transaction.note ?? "-",
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Flexible(
                      flex: 1, child: Text(formatPrice(transaction.total))),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
