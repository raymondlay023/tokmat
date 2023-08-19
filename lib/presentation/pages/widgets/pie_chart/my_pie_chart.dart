import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:tokmat/core/const.dart';
import 'package:tokmat/core/theme.dart';
import 'package:tokmat/core/utils.dart';
import 'package:tokmat/domain/entities/transaction_entity.dart';

import 'individual_pie_section.dart';

class MyPieChart extends StatelessWidget {
  final List<TransactionEntity> transactions;
  const MyPieChart({super.key, required this.transactions});

  @override
  Widget build(BuildContext context) {
    final totalTransaksi = sumTotalOfTransactions(transactions: transactions);
    final totalPemasukan = sumTotalOfTransactions(
        transactions: transactions, type: TypeConst.pemasukan);
    final totalPengeluaran = sumTotalOfTransactions(
        transactions: transactions, type: TypeConst.pengeluaran);
    List<IndividualPieSection> individualPieSectionList = [
      IndividualPieSection(
          name: TypeConst.pemasukan,
          percent: totalPemasukan / totalTransaksi,
          color: pemasukanColor),
      IndividualPieSection(
          name: TypeConst.pengeluaran,
          percent: totalPengeluaran / totalTransaksi,
          color: pengeluaranColor),
    ];
    return Column(
      children: [
        SizedBox(
          height: 200,
          child: PieChart(
            PieChartData(
              sectionsSpace: 0,
              centerSpaceRadius: 50,
              sections: individualPieSectionList
                  .map((section) => PieChartSectionData(
                        color: section.color,
                        title: "${(section.percent * 100).toStringAsFixed(2)}%",
                        value: section.percent,
                        titleStyle: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(color: Theme.of(context).canvasColor),
                      ))
                  .toList(),
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: individualPieSectionList
                    .map((section) => Row(
                          children: [
                            Container(
                                margin: const EdgeInsets.all(5),
                                width: 20,
                                height: 20,
                                color: section.color),
                            Text(section.name),
                          ],
                        ))
                    .toList(),
              ),
            )
          ],
        )
      ],
    );
  }
}
