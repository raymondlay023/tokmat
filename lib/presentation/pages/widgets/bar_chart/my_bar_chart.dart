import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:tokmat/core/utils.dart';
import 'package:tokmat/domain/entities/product_entity.dart';
import 'package:tokmat/domain/entities/transaction_entity.dart';
import 'package:tokmat/presentation/pages/widgets/bar_chart/individual_bar.dart';

class MyBarChart<T> extends StatelessWidget {
  final List<T> objects;
  final double Function(T object) getTotal;
  const MyBarChart({
    super.key,
    required this.objects,
    required this.getTotal,
  });

  @override
  Widget build(BuildContext context) {
    List<IndividualBar> individualBarList = List.generate(7, (index) {
      var dailyTotal = 0.0;
      for (var object in objects) {
        if (index + 1 == getWeekday(object)) {
          dailyTotal += getTotal(object);
        }
      }
      return IndividualBar(x: index + 1, y: dailyTotal);
    });

    double highestAmount = 0;
    for (var bar in individualBarList) {
      if (bar.y > highestAmount) {
        highestAmount = bar.y;
      }
    }

    return BarChart(
      BarChartData(
        maxY: highestAmount == 0 ? 100 : highestAmount.ceilToDouble(),
        minY: 0,
        gridData: const FlGridData(show: false),
        borderData: FlBorderData(show: false),
        titlesData: FlTitlesData(
          show: true,
          topTitles:
              const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          rightTitles:
              const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                  showTitles: true,
                  getTitlesWidget: getBottomTitles,
                  reservedSize: 30)),
        ),
        barGroups: individualBarList
            .map((data) => BarChartGroupData(
                  x: data.x,
                  barRods: [
                    BarChartRodData(
                      toY: data.y,
                      color: Colors.grey[800],
                      width: 25,
                      borderRadius: BorderRadius.circular(5),
                      backDrawRodData: BackgroundBarChartRodData(
                        show: true,
                        toY: 100,
                        color: Colors.grey[200],
                      ),
                    )
                  ],
                ))
            .toList(),
        barTouchData: BarTouchData(
          touchTooltipData: BarTouchTooltipData(
            tooltipBgColor: Colors.blueGrey,
            tooltipHorizontalAlignment: FLHorizontalAlignment.right,
            tooltipMargin: -10,
            getTooltipItem: (group, groupIndex, rod, rodIndex) {
              String weekDay = getWeekdayString(group.x);
              return BarTooltipItem(
                '$weekDay\n',
                const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
                children: <TextSpan>[
                  TextSpan(
                    text: formatCurrency(rod.toY).toString(),
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget getBottomTitles(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Colors.grey,
      fontWeight: FontWeight.bold,
      fontSize: 14,
    );

    String text = getWeekdayString(value.toInt());

    return SideTitleWidget(
        axisSide: meta.axisSide,
        child: Text(text.substring(0, 1), style: style));
  }

  int getWeekday(T object) {
    if (object is TransactionEntity) {
      return object.createdAt!.toDate().weekday;
    } else if (object is ProductEntity) {
      return object.createdAt!.toDate().weekday;
    } else {
      throw Error();
    }
  }

  String getWeekdayString(int value) {
    String text;
    switch (value) {
      case 1:
        text = 'Senin';
        break;
      case 2:
        text = 'Selasa';
        break;
      case 3:
        text = 'Rabu';
        break;
      case 4:
        text = 'Kamis';
        break;
      case 5:
        text = 'Jumat';
        break;
      case 6:
        text = 'Sabtu';
        break;
      case 7:
        text = 'Minggu';
        break;
      default:
        text = '';
    }
    return text;
  }
}
