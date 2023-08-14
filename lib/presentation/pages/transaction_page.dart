import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:tokmat/core/const.dart';
import 'package:tokmat/core/utils.dart';
import 'package:tokmat/domain/entities/transaction_entity.dart';
import 'package:tokmat/presentation/cubit/transaction_cubit.dart';
import 'package:tokmat/presentation/pages/widgets/transaction_widget.dart';
import 'package:tokmat/injection_container.dart' as di;

import '../../core/theme.dart';

class TransactionPage extends StatelessWidget {
  const TransactionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
            onPressed: () =>
                Navigator.pushNamed(context, PageConst.addTransactionPage),
            child: const Icon(Icons.add)),
        body: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 20),
              // Summary Card
              BlocBuilder<TransactionCubit, TransactionState>(
                builder: (context, transactionState) {
                  final profit = di.sl<TransactionCubit>().total(
                      transactions: transactionState.transactions,
                      type: TypeConst.pemasukan);
                  final loss = di.sl<TransactionCubit>().total(
                      transactions: transactionState.transactions,
                      type: TypeConst.pengeluaran);
                  final profitOrLoss = di.sl<TransactionCubit>().profitOrLoss(
                      transactions: transactionState.transactions);
                  final isLoss = profitOrLoss.isNegative;
                  return Card(
                    margin: const EdgeInsets.symmetric(
                        vertical: 15, horizontal: 25),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 20, horizontal: 25),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Column(
                                children: [
                                  const Text('Total Pemasukan'),
                                  Text(
                                    formatPrice(profit),
                                    style: pemasukanStyle,
                                  ),
                                ],
                              ),
                              const Spacer(),
                              Container(
                                  color: Colors.black,
                                  child: const SizedBox(height: 50, width: 1)),
                              const Spacer(),
                              Column(
                                children: [
                                  const Text('Total Pengeluaran'),
                                  Text(
                                    formatPrice(loss),
                                    style: pengeluaranStyle,
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 25, vertical: 10),
                            decoration: BoxDecoration(
                                color: isLoss
                                    ? pengeluaranColor.withOpacity(0.3)
                                    : pemasukanColor.withOpacity(0.3),
                                borderRadius: BorderRadius.circular(15)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  isLoss ? 'Rugi' : 'Untung',
                                  style: isLoss
                                      ? pengeluaranStyle
                                      : pemasukanStyle,
                                ),
                                Text(
                                  '${isLoss ? profitOrLoss.abs() : profitOrLoss}',
                                  style: isLoss
                                      ? pengeluaranStyle
                                      : pemasukanStyle,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
              BlocBuilder<TransactionCubit, TransactionState>(
                builder: (context, transactionState) {
                  if (transactionState.status == TransactionStatus.success) {
                    return Container(
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      child: GroupedListView<TransactionEntity, String>(
                        shrinkWrap: true,
                        elements: transactionState.transactions,
                        order: GroupedListOrder.DESC,
                        itemComparator: (element1, element2) =>
                            element1.note!.compareTo(element2.note!),
                        groupBy: (transaction) =>
                            formatDate(transaction.createdAt!),
                        groupSeparatorBuilder: (value) => Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(16),
                          color: Colors.black.withOpacity(0.3),
                          child: Text(value),
                        ),
                        itemBuilder: (context, transaction) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            child:
                                TransactionTileWidget(transaction: transaction),
                          );
                        },
                      ),
                    );
                  } else if (transactionState.status ==
                      TransactionStatus.loading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (transactionState.status ==
                      TransactionStatus.failure) {
                    return noTransaction(context);
                  }
                  return noTransaction(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget noTransaction(BuildContext context) => Center(
        child: Text(
          textAlign: TextAlign.center,
          'Belum ada transaksi yang dibuat',
          style: TextStyle(
            fontSize: 36,
            color: Theme.of(context).disabledColor,
          ),
        ),
      );
}
