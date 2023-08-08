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
      print("get Transaction error : $e");
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
      print("create Transaction error : $e");
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
