import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tokmat/core/const.dart';
import 'package:tokmat/domain/entities/transaction_entity.dart';

import '../../core/theme.dart';
import '../../core/utils.dart';

class TransactionReportPage extends StatefulWidget {
  final List<TransactionEntity> transactions;
  const TransactionReportPage({super.key, required this.transactions});

  @override
  State<TransactionReportPage> createState() => _TransactionReportPageState();
}

class _TransactionReportPageState extends State<TransactionReportPage> {
  late DateTimeRange _dateRange;
  late List<TransactionEntity> _filteredTransactions;

  @override
  void initState() {
    _dateRange = DateTimeRange(
      start: DateTime.now().subtract(const Duration(days: 14)),
      end: DateTime.now(),
    );
    _filteredTransactions = transactionsBetweenDates(
      transactions: widget.transactions,
      start: _dateRange.start,
      end: _dateRange.end,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Laporan Transaksi')),
      body: SingleChildScrollView(
        child: Column(children: [
          // Date Range Picker
          Container(
            margin: const EdgeInsets.only(top: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton.icon(
                  icon: Icon(
                    Icons.calendar_month,
                    color: Theme.of(context).primaryColor,
                  ),
                  style: TextButton.styleFrom(
                    primary: Theme.of(context).primaryColor.withOpacity(0.25),
                    side: BorderSide(color: Theme.of(context).primaryColor),
                  ),
                  onPressed: pickDateRange,
                  label: Text(
                    DateFormat('dd/MM/yyy').format(_dateRange.start),
                    style: TextStyle(color: Colors.black87),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  height: 2,
                  width: 10,
                  decoration: const BoxDecoration(color: Colors.black),
                ),
                TextButton.icon(
                  icon: Icon(
                    Icons.calendar_month,
                    color: Theme.of(context).primaryColor,
                  ),
                  style: TextButton.styleFrom(
                    primary: Theme.of(context).primaryColor.withOpacity(0.25),
                    side: BorderSide(color: Theme.of(context).primaryColor),
                  ),
                  onPressed: pickDateRange,
                  label: Text(
                    DateFormat('dd/MM/yyy').format(_dateRange.end),
                    style: const TextStyle(color: Colors.black87),
                  ),
                )
              ],
            ),
          ),
          // Transaction List Header
          Container(
            margin: const EdgeInsets.only(top: 30),
            child: Row(
              children: [
                Expanded(
                    flex: 2,
                    child: box(
                        text: 'Transaksi', color: Theme.of(context).cardColor)),
                Expanded(
                    flex: 1,
                    child: box(
                        text: 'Pemasukan', color: Theme.of(context).cardColor)),
                Expanded(
                    flex: 1,
                    child: box(
                        text: 'Pengeluaran',
                        color: Theme.of(context).cardColor)),
              ],
            ),
          ),
          // Transactions List Items
          ListView(
            shrinkWrap: true,
            children: [
              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Column(
                      children: _filteredTransactions
                          .map((transaction) => box(
                              color:
                                  Theme.of(context).cardColor.withOpacity(0.25),
                              text: transaction.note!))
                          .toList(),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Column(
                      children: _filteredTransactions.map((transaction) {
                        if (transaction.type == TypeConst.pemasukan) {
                          return box(
                              text: formatCurrency(transaction.total!),
                              color: pemasukanColor.withOpacity(0.25));
                        } else {
                          return box(color: pemasukanColor.withOpacity(0.25));
                        }
                      }).toList(),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Column(
                      children: _filteredTransactions.map((transaction) {
                        if (transaction.type == TypeConst.pengeluaran) {
                          return box(
                              text: formatCurrency(transaction.total!),
                              color: pengeluaranColor.withOpacity(0.25));
                        } else {
                          return box(color: pengeluaranColor.withOpacity(0.25));
                        }
                      }).toList(),
                    ),
                  ),
                ],
              ),
            ],
          )
        ]),
      ),
    );
  }

  Widget box({String text = '', required Color? color}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 20),
      decoration: BoxDecoration(
        color: color!,
      ),
      child: Text(
        text,
        textAlign: TextAlign.center,
      ),
    );
  }

  Future pickDateRange() async {
    DateTimeRange? newDateRange = await showDateRangePicker(
      context: context,
      initialDateRange: _dateRange,
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );

    if (newDateRange == null) return;

    setState(() {
      _dateRange = newDateRange;
      _filteredTransactions = transactionsBetweenDates(
        transactions: widget.transactions,
        start: _dateRange.start,
        end: _dateRange.end,
      );
    });
  }
}
