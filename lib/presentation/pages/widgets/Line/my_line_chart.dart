import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:tokmat/core/utils.dart';
import 'package:tokmat/domain/entities/transaction_entity.dart';

class MyLineChart extends StatelessWidget {
  final List<TransactionEntity> transactions;
  const MyLineChart({super.key, required this.transactions});

  @override
  Widget build(BuildContext context) {
    final transactionByMonth = splitTransactionsByMonth(transactions);

    final spots = List.generate(12, (month) {
      final transactionsInMonth = transactionByMonth[month + 1] ?? [];

      final totalInMonth = transactionsInMonth.fold<double>(
        0,
        (previousValue, transaction) => previousValue + transaction.total!,
      );

      return FlSpot((month + 1).toDouble(), totalInMonth);
    });

    double highestAmount = 0;
    for (var bar in spots) {
      if (bar.y > highestAmount) {
        highestAmount = bar.y;
      }
    }

    return LineChart(
      LineChartData(
        gridData: FlGridData(show: false),
        maxY: highestAmount == 0 ? 100 : highestAmount.ceilToDouble(),
        lineTouchData: LineTouchData(
          getTouchedSpotIndicator:
              (LineChartBarData barData, List<int> spotIndexes) {
            return spotIndexes.map((spotIndex) {
              return TouchedSpotIndicatorData(
                FlLine(
                  color: Colors.blue,
                  strokeWidth: 3,
                ),
                FlDotData(
                  getDotPainter: (spot, percent, barData, index) {
                    if (index.isEven) {
                      return FlDotCirclePainter(
                        radius: 8,
                        color: Colors.white,
                        strokeWidth: 5,
                        strokeColor: Colors.green,
                      );
                    } else {
                      return FlDotSquarePainter(
                        size: 16,
                        color: Colors.white,
                        strokeWidth: 5,
                        strokeColor: Colors.green,
                      );
                    }
                  },
                ),
              );
            }).toList();
          },
          touchTooltipData: LineTouchTooltipData(
            tooltipBgColor: Theme.of(context).primaryColor,
            getTooltipItems: (List<LineBarSpot> touchedBarSpots) {
              return touchedBarSpots.map((barSpot) {
                final flSpot = barSpot;
                TextAlign textAlign;
                switch (flSpot.x.toInt()) {
                  case 1:
                    textAlign = TextAlign.left;
                    break;
                  case 5:
                    textAlign = TextAlign.right;
                    break;
                  default:
                    textAlign = TextAlign.center;
                }
                return LineTooltipItem(
                  '${getMonthString(flSpot.x.toInt())} \n',
                  TextStyle(
                    color: Theme.of(context).canvasColor,
                    fontWeight: FontWeight.bold,
                  ),
                  children: [
                    TextSpan(
                      text: formatCurrency(flSpot.y),
                      style: TextStyle(
                        color: Theme.of(context).canvasColor,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ],
                  textAlign: textAlign,
                );
              }).toList();
            },
          ),
        ),
        titlesData: FlTitlesData(
          rightTitles:
              const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          topTitles:
              const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                  showTitles: true,
                  getTitlesWidget: getBottomTitles,
                  reservedSize: 30)),
        ),
        lineBarsData: [
          LineChartBarData(
            spots: spots,
            barWidth: 3,
          ),
        ],
      ),
    );
  }

  Widget getBottomTitles(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Colors.grey,
      fontWeight: FontWeight.bold,
      fontSize: 14,
    );

    String text = getMonthString(value.toInt());

    return SideTitleWidget(
        axisSide: meta.axisSide,
        child: Text(text.substring(0, 3), style: style));
  }

  String getMonthString(int value) {
    String text;
    switch (value) {
      case 1:
        text = 'Januari';
        break;
      case 2:
        text = 'Februari';
        break;
      case 3:
        text = 'Maret';
        break;
      case 4:
        text = 'April';
        break;
      case 5:
        text = 'Mei';
        break;
      case 6:
        text = 'Juni';
        break;
      case 7:
        text = 'Juli';
        break;
      case 8:
        text = 'Agustus';
        break;
      case 9:
        text = 'September';
        break;
      case 10:
        text = 'Oktober';
        break;
      case 11:
        text = 'November';
        break;
      case 12:
        text = 'Desember';
        break;
      default:
        text = '';
    }
    return text;
  }
}
