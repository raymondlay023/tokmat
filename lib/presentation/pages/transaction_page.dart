import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:tokmat/core/const.dart';
import 'package:tokmat/core/utils.dart';
import 'package:tokmat/domain/entities/transaction_entity.dart';
import 'package:tokmat/presentation/cubit/transaction_cubit.dart';
import 'package:tokmat/presentation/pages/widgets/transaction_tile_widget.dart';
import 'package:tokmat/injection_container.dart' as di;

import '../../core/theme.dart';

class TransactionPage extends StatefulWidget {
  const TransactionPage({super.key});

  @override
  State<TransactionPage> createState() => _TransactionPageState();
}

class _TransactionPageState extends State<TransactionPage> {
  @override
  void initState() {
    context.read<TransactionCubit>().getTransactions();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final transactionState = context.watch<TransactionCubit>().state;
    List<TransactionEntity> transactions = transactionState.transactions;

    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
            onPressed: () =>
                Navigator.pushNamed(context, PageConst.addTransactionPage),
            child: const Icon(Icons.add)),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Column(
            children: [
              const SizedBox(height: 20),
              // Summary Card
              Builder(
                builder: (context) {
                  final profit = sumTotalOfTransactions(
                      transactions: transactions, type: TypeConst.pemasukan);
                  final loss = sumTotalOfTransactions(
                      transactions: transactions, type: TypeConst.pengeluaran);
                  final profitOrLoss =
                      profitOrLossOfTransactions(transactions: transactions);
                  final isLoss = profitOrLoss.isNegative;
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 15),
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
                                    formatCurrency(profit),
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
                                    formatCurrency(loss),
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
                                  formatCurrency(isLoss
                                      ? profitOrLoss.abs()
                                      : profitOrLoss),
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
              // Button Laporan Transaksi
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                          onPressed: () => Navigator.pushNamed(
                              context, PageConst.transactionReportPage,
                              arguments: transactions),
                          child: const Text('Laporan Transaksi')),
                    ),
                  ],
                ),
              ),
              // Custom Search Bar
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: TextField(
                  onChanged: (value) {
                    if (value == "") {
                      context.read<TransactionCubit>().getTransactions();
                    } else {
                      context.read<TransactionCubit>().filterTransactionByQuery(
                          transactions: transactions, query: value);
                    }
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    hintStyle: Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .copyWith(color: Colors.black26),
                    hintText: "contoh: Transaksi pak abdul",
                    prefixIcon: const Icon(Icons.search),
                  ),
                ),
              ),
              // List Transaction
              Builder(
                builder: (context) {
                  if (transactionState.status == TransactionStatus.success) {
                    return Container(
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      child: GroupedListView<TransactionEntity, String>(
                        shrinkWrap: true,
                        elements: transactions,
                        order: GroupedListOrder.DESC,
                        itemComparator: (element1, element2) =>
                            element1.note!.compareTo(element2.note!),
                        groupBy: (transaction) =>
                            formatDate(transaction.createdAt!),
                        groupHeaderBuilder: (transaction) {
                          final profitOrLoss = profitOrLossOfTransactions(
                              transactions: transactions,
                              date: transaction.createdAt);
                          final isLoss = profitOrLoss.isNegative;
                          return Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(
                                vertical: 15, horizontal: 25),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: Colors.black.withOpacity(0.15),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  formatDate(transaction.createdAt!),
                                  style:
                                      Theme.of(context).textTheme.titleMedium,
                                ),
                                Text(
                                  formatCurrency(profitOrLoss.abs()),
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium!
                                      .copyWith(
                                        color: isLoss
                                            ? pengeluaranColor
                                            : pemasukanColor,
                                      ),
                                ),
                              ],
                            ),
                          );
                        },
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
                    return noTransaction;
                  } else {
                    return noTransaction;
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget get noTransaction => Center(
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
