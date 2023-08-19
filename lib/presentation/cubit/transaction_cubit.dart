import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tokmat/core/const.dart';
import 'package:tokmat/domain/entities/transaction_entity.dart';
import 'package:tokmat/domain/usecases/transactions/delete_transaction_use_case.dart';
import 'package:tokmat/domain/usecases/transactions/get_transactions_usecase.dart';
import 'package:tokmat/domain/usecases/transactions/create_transaction_usecase.dart';
import 'package:tokmat/domain/usecases/transactions/update_transaction_use_case.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
part 'transaction_state.dart';

class TransactionCubit extends Cubit<TransactionState> {
  final CreateTransactionUseCase createTransactionUseCase;
  final GetTransactionsUseCase getTransactionsUseCase;
  final UpdateTransactionUseCase updateTransactionUseCase;
  final DeleteTransactionUseCase deleteTransactionUseCase;

  TransactionCubit({
    required this.createTransactionUseCase,
    required this.getTransactionsUseCase,
    required this.updateTransactionUseCase,
    required this.deleteTransactionUseCase,
  }) : super(TransactionState.initial());

  Future<void> getTransactions() async {
    emit(state.copyWith(status: TransactionStatus.loading));
    try {
      final streamResponse = getTransactionsUseCase.call();
      streamResponse.listen((transactions) {
        emit(state.copyWith(
            transactions: transactions, status: TransactionStatus.success));
        print("get Transaction transactions : $transactions");
      });
    } catch (e) {
      emit(state.copyWith(status: TransactionStatus.failure));
    }
  }

  Future<void> createTransaction(
      {required TransactionEntity transaction}) async {
    emit(state.copyWith(status: TransactionStatus.loading));
    try {
      await createTransactionUseCase.call(transaction);
      emit(state.copyWith(status: TransactionStatus.success));
    } catch (e) {
      emit(state.copyWith(status: TransactionStatus.failure));
    }
  }

  Future<void> updateTransaction(
      {required TransactionEntity transaction}) async {
    emit(state.copyWith(status: TransactionStatus.loading));
    try {
      await updateTransactionUseCase.call(transaction);
      emit(state.copyWith(status: TransactionStatus.success));
    } catch (_) {
      emit(state.copyWith(status: TransactionStatus.failure));
    }
  }

  Future<void> deleteTransaction({required String transactionId}) async {
    emit(state.copyWith(status: TransactionStatus.loading));
    try {
      await deleteTransactionUseCase.call(transactionId);
      emit(state.copyWith(status: TransactionStatus.success));
    } catch (_) {
      emit(state.copyWith(status: TransactionStatus.failure));
    }
  }

  void filterTransactionByQuery(
      {required List<TransactionEntity> transactions, required String query}) {
    emit(state.copyWith(status: TransactionStatus.loading));
    try {
      final filteredTransactions = transactions.where((transaction) {
        final noteLower = transaction.note!.toLowerCase();
        final searchLower = query.toLowerCase();
        return noteLower.contains(searchLower);
      }).toList();
      emit(state.copyWith(
          transactions: filteredTransactions,
          status: TransactionStatus.success));
    } catch (_) {
      emit(state.copyWith(status: TransactionStatus.failure));
    }
  }

  // Debug
  @override
  void onChange(Change<TransactionState> change) {
    print("current: ${change.currentState.status}" +
        "\n next: ${change.nextState.status}");
    super.onChange(change);
  }
}
