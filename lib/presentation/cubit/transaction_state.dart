part of 'transaction_cubit.dart';

enum TransactionStatus { initial, success, loading, failure }

class TransactionState extends Equatable {
  final List<TransactionEntity> transactions;
  final List<TransactionEntity> filteredTransactions;
  final TransactionStatus status;
  const TransactionState(
      {required this.transactions,
      required this.filteredTransactions,
      required this.status});

  factory TransactionState.initial() => TransactionState(
        transactions: List.empty(),
        filteredTransactions: List.empty(),
        status: TransactionStatus.initial,
      );

  TransactionState copyWith({
    List<TransactionEntity>? transactions,
    List<TransactionEntity>? filteredTransactions,
    TransactionStatus? status,
  }) {
    return TransactionState(
        transactions: transactions ?? this.transactions,
        filteredTransactions: filteredTransactions ?? this.filteredTransactions,
        status: status ?? this.status);
  }

  @override
  List<Object> get props => [transactions, status];
}
