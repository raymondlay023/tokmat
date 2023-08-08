import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

void toast(String message) {
  Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 1,
    fontSize: 16,
  );
}

String formatPrice(double? price) {
  return NumberFormat.currency(locale: 'id', decimalDigits: 0, symbol: "Rp ")
      .format(price);
}

String formatDate(Timestamp date) {
  final dateInDateTime = date.toDate().copyWith(
        hour: 0,
        minute: 0,
        second: 0,
        millisecond: 0,
        microsecond: 0,
      );
  return DateFormat('dd MMMM yyyy').format(dateInDateTime);
}
