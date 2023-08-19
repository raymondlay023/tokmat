import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

import '../domain/entities/product_entity.dart';
import '../domain/entities/transaction_entity.dart';
import 'const.dart';

/// Showing snackbar everywhere
void toast(String message) {
  Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 1,
    fontSize: 16,
  );
}

/// Format any double to IDR currency
String formatCurrency(double? currency) {
  return NumberFormat.currency(locale: 'id', decimalDigits: 0, symbol: "Rp ")
      .format(currency);
}

/// Convert Timestamp to Formatted DateTime in String
String formatDate(Timestamp date) {
  return DateFormat('dd MMMM yyyy').format(date.toDate());
}

double sumTotalOfTransactions(
    {required List<TransactionEntity> transactions, String? type}) {
  double total = 0;
  if (type != null) {
    for (var transaction
        in transactions.where((transaction) => transaction.type == type)) {
      total += transaction.total!;
    }
  } else {
    for (var transaction in transactions) {
      total += transaction.total!;
    }
  }
  return total;
}

double countAvgOfTransactions(
    {required List<TransactionEntity> transactions, String? type}) {
  return sumTotalOfTransactions(transactions: transactions) /
      transactions.length;
}

double profitOrLossOfTransactions(
    {required List<TransactionEntity> transactions, Timestamp? date}) {
  return transactions
      .where((transaction) => date == null || transaction.createdAt == date)
      .fold(
          0,
          (result, transaction) =>
              result +
              (transaction.type == TypeConst.pemasukan
                  ? transaction.total!
                  : -transaction.total!));
}

List<List<TransactionEntity>> groupTransactionByWeek(
    int year, int month, List<TransactionEntity> transactions) {
  DateTime firstDayOfMonth = DateTime(year, month, 1);
  DateTime lastDayOfMonth = DateTime(year, month + 1, 0);

  List<List<TransactionEntity>> weeks = [];
  List<TransactionEntity> currentWeekTransactions = [];

  for (int i = 1; i <= lastDayOfMonth.day; i++) {
    DateTime day = DateTime(year, month, i);

    for (var transaction in transactions) {
      if (transaction.createdAt!.toDate().day == day.day &&
          transaction.createdAt!.toDate().month == day.month &&
          transaction.createdAt!.toDate().year == day.year) {
        currentWeekTransactions.add(transaction);
      }
    }

    if (day.weekday == DateTime.sunday || day == lastDayOfMonth) {
      weeks.add(List.from(currentWeekTransactions));
      currentWeekTransactions.clear();
    }
  }

  return weeks;
}

List<TransactionEntity> transactionsBetweenDates({
  required List<TransactionEntity> transactions,
  required DateTime start,
  required DateTime end,
}) {
  return transactions.where((transaction) {
    final date = transaction.createdAt!.toDate();
    return date.isAfter(start.subtract(const Duration(days: 1))) &&
        date.isBefore(end.add(const Duration(days: 1)));
  }).toList();
}

Map<int, List<TransactionEntity>> splitTransactionsByMonth(
    List<TransactionEntity> transactions) {
  Map<int, List<TransactionEntity>> transactionsByMonth = {};

  for (var transaction in transactions) {
    int month = transaction.createdAt!.toDate().month;

    if (!transactionsByMonth.containsKey(month)) {
      transactionsByMonth[month] = [];
    }

    transactionsByMonth[month]!.add(transaction);
  }

  return transactionsByMonth;
}

List<ProductEntity> getProductsWithLowestAmount(
    List<ProductEntity> products, int count) {
  // Sort the products by their amount in ascending order
  products.sort((a, b) => a.stock!.compareTo(b.stock!));

  // Take the first 'count' products from the sorted list
  return products.take(count).toList();
}
