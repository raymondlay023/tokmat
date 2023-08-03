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
