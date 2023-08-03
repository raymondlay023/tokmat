import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tokmat/injection_container.dart' as di;
import 'package:tokmat/presentation/cubit/transaction_cubit.dart';
import 'package:tokmat/presentation/pages/widgets/transaction_widget.dart';

class TransactionPage extends StatelessWidget {
  const TransactionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          onPressed: () => Navigator.pushNamed(context, '/add-transaction'),
          child: Icon(Icons.add)),
      body: BlocProvider(
        create: (context) => di.sl<TransactionCubit>()..getTransactions(),
        child: BlocBuilder<TransactionCubit, TransactionState>(
          builder: (context, transactionState) {
            if (transactionState is TransactionLoaded) {
              ListView.builder(
                itemCount: transactionState.transactions.length,
                itemBuilder: (context, index) {
                  final transaction = transactionState.transactions[index];
                  return BlocProvider(
                    create: (context) => di.sl<TransactionCubit>(),
                    child: TransactionWidget(transaction: transaction),
                  );
                },
              );
            } else if (transactionState is TransactionLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (transactionState is TransactionFailure) {
              return NoTransactionPage();
            }
            return NoTransactionPage();
          },
        ),
      ),
    );
  }
}

class NoTransactionPage extends StatelessWidget {
  const NoTransactionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
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
}
