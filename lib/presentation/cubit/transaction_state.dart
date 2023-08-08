part of 'transaction_cubit.dart';

enum TransactionStatus { initial, success, loading, failure }

class TransactionState extends Equatable {
  final List<TransactionEntity> transactions;
  final TransactionStatus status;
  const TransactionState({required this.transactions, required this.status});

  factory TransactionState.initial() => TransactionState(
      transactions: List.empty(), status: TransactionStatus.initial);

  TransactionState copyWith(
      {List<TransactionEntity>? transactions, TransactionStatus? status}) {
    return TransactionState(
        transactions: transactions ?? this.transactions,
        status: status ?? this.status);
  }

  @override
  List<Object> get props => [transactions, status];
}
