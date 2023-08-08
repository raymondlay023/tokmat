import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tokmat/core/utils.dart';
import 'package:tokmat/domain/entities/transaction_entity.dart';

class DetailTransactionPage extends StatelessWidget {
  final TransactionEntity transaction;
  const DetailTransactionPage({super.key, required this.transaction});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Detail Transaksi',
          style: TextStyle(fontSize: 20),
        ),
        actions: [
          IconButton(
              splashRadius: 25, icon: Icon(Icons.mode_edit), onPressed: () {}),
          IconButton(
            splashRadius: 25,
            icon: Icon(
              Icons.delete,
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 30),
            // Header
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Text(
                      'Nama Toko',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    Text(
                      '[phone number]',
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.black.withOpacity(0.5),
                      ),
                    ),
                  ],
                )
              ],
            ),
            SizedBox(height: 30),
            Text(DateFormat('EEEE, MMM d, yyyy')
                .format(transaction.createdAt!.toDate())),
            SizedBox(height: 10),
            const DottedLine(),
            SizedBox(height: 15),
            Row(
              children: [
                Expanded(
                  flex: 3,
                  child: Text(
                    'Nama Barang',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black45,
                      fontSize: 16,
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Text(
                    'Jumlah',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black45,
                      fontSize: 16,
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Text(
                    'Total',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black45,
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
            Divider(
              thickness: 0.5,
              color: Colors.black.withOpacity(0.5),
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  flex: 3,
                  child: Column(
                    children: transaction.items!
                        .map((item) => Column(
                              children: [
                                Text("'\${item['product']['name']}'"),
                                Text(
                                  "'\${_formatCurrency(item['product']['price'])} / item'",
                                  style: TextStyle(
                                    color: Colors.black38,
                                  ),
                                ),
                                SizedBox(height: 10),
                              ],
                            ))
                        .toList(),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Column(
                    children: transaction.items!
                        .map((item) => Column(
                              children: [
                                Text("'\${item['quantity']}'"),
                                SizedBox(height: 25),
                              ],
                            ))
                        .toList(),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Column(
                    children: transaction.items!
                        .map((item) => Column(
                              children: [
                                Text(
                                    "'Rp. \${item['product']['price'] * item['quantity']}'"),
                                SizedBox(height: 25),
                              ],
                            ))
                        .toList(),
                  ),
                ),
              ],
            ),
            SizedBox(height: 15),
            const DottedLine(),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 15,
                ),
                Expanded(
                  flex: 2,
                  child: Text(
                    'Total Transaksi',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    // textAlign: TextAlign.center,
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Text(
                    formatPrice(transaction.total!),
                    style: TextStyle(fontSize: 15),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
            SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  width: 15,
                ),
                Text(
                  'Catatan :',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  // textAlign: TextAlign.center,
                ),
              ],
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  width: 15,
                ),
                Text(
                  '${transaction.note}',
                  style: TextStyle(fontSize: 15, color: Colors.black45),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
