import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tokmat/domain/entities/transaction_entity.dart';
import 'package:tokmat/domain/usecases/transactions/get_transactions_usecase.dart';
import 'package:tokmat/domain/usecases/transactions/create_transaction_usecase.dart';

part 'transaction_state.dart';

class TransactionCubit extends Cubit<TransactionState> {
  final CreateTransactionUseCase createTransactionUseCase;
  final GetTransactionsUseCase getTransactionsUseCase;
  TransactionCubit({
    required this.createTransactionUseCase,
    required this.getTransactionsUseCase,
  }) : super(TransactionInitial());

  Future<void> getTransactions() async {
    try {
      final streamResponse = getTransactionsUseCase.call();
      streamResponse.listen((transactions) {
        emit(TransactionLoaded(transactions: transactions));
      });
    } catch (e) {
      print(e);
      emit(TransactionFailure());
    }
  }

  Future<void> createTransaction(
      {required TransactionEntity transaction}) async {
    try {
      await createTransactionUseCase.call(transaction);
    } catch (e) {
      print(e);
      emit(TransactionFailure());
    }
  }

  // Future<void> updateTransaction({required TransactionEntity transaction}) {
  //   try {
  //     await updateTransactionUseCase.call
  //   } catch (e) {
  //     print(e);
  //     emit(TransactionError());
  //   }
  // }
}
