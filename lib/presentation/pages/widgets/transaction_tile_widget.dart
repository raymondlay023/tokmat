import 'package:flutter/material.dart';
import 'package:tokmat/core/const.dart';
import 'package:tokmat/core/theme.dart';
import 'package:tokmat/core/utils.dart';
import 'package:tokmat/domain/entities/transaction_entity.dart';

class TransactionTileWidget extends StatelessWidget {
  final TransactionEntity transaction;
  const TransactionTileWidget({super.key, required this.transaction});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: SizedBox(
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
                    flex: 3,
                    child: Text(
                      transaction.note ?? "-",
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const Flexible(flex: 1, child: SizedBox()),
                  Flexible(
                      flex: 2,
                      child: Text(
                        formatCurrency(transaction.total),
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: transaction.type == TypeConst.pemasukan
                                ? pemasukanColor
                                : pengeluaranColor),
                      )),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
