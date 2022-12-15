import 'dart:convert';

import 'package:dangoz/base/app_colors.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class HoldingsChart24 extends StatefulWidget {
  String chartTitle;
  String low;
  String high;
  List<double> priceList;
  HoldingsChart24({
    Key? key,
    required this.chartTitle,
    required this.low,
    required this.high,
    required this.priceList,
  }) : super(key: key);

  @override
  State<HoldingsChart24> createState() => _HoldingsChart24State();
}

class _HoldingsChart24State extends State<HoldingsChart24> {
  List<Color> gradientColors = const [
    Color.fromARGB(255, 158, 19, 208),
    Color.fromARGB(255, 229, 9, 222),
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Container(
        height: Get.height * 0.25,
        child: Stack(
          children: <Widget>[
            AspectRatio(
              aspectRatio: 1.70,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(18),
                  ),
                  color: AppColors.navy,
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                    right: 18,
                    left: 12,
                    top: 24,
                    bottom: 12,
                  ),
                  child: LineChart(
                    mainData(),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget topTitleWidgets(double value, TitleMeta meta) {
    dynamic style = TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.w600,
      letterSpacing: 1,
      fontSize: Get.width * 0.04,
    );
    Widget text;
    switch (value.toInt()) {
      case 11:
        text = Text(widget.chartTitle, style: style);
        break;
      default:
        text = Text('', style: style);
        break;
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: text,
    );
  }

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.bold,
      fontSize: 15,
    );
    String text;
    switch (value.toInt()) {
      case 1:
        text = widget.low;
        break;
      case 12:
        text = widget.high;
        break;
      default:
        return Container();
    }

    return Text(text, style: style, textAlign: TextAlign.left);
  }

  LineChartData mainData() {
    return LineChartData(
      gridData: FlGridData(
        show: false,
        drawVerticalLine: false,
        horizontalInterval: 1,
        verticalInterval: 1,
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: AppColors.navy,
            strokeWidth: 1,
          );
        },
        getDrawingVerticalLine: (value) {
          return FlLine(
            color: AppColors.navy,
            strokeWidth: 1,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        rightTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            interval: 1,
            getTitlesWidget: topTitleWidgets,
            reservedSize: 30,
          ),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            interval: 1,
            getTitlesWidget: leftTitleWidgets,
            reservedSize: 42,
          ),
        ),
      ),
      borderData: FlBorderData(
        show: false,
        border: Border.all(color: AppColors.white),
      ),
      minX: 0,
      maxX: 24,
      minY: -1,
      maxY: 12,
      lineBarsData: [
        LineChartBarData(
          spots: [
            FlSpot(0, widget.priceList[0]),
            FlSpot(1, widget.priceList[1]),
            FlSpot(2, widget.priceList[2]),
            FlSpot(3, widget.priceList[3]),
            FlSpot(4, widget.priceList[4]),
            FlSpot(5, widget.priceList[5]),
            FlSpot(6, widget.priceList[6]),
            FlSpot(7, widget.priceList[7]),
            FlSpot(8, widget.priceList[8]),
            FlSpot(9, widget.priceList[9]),
            FlSpot(10, widget.priceList[10]),
            FlSpot(11, widget.priceList[11]),
            FlSpot(12, widget.priceList[12]),
            FlSpot(13, widget.priceList[13]),
            FlSpot(14, widget.priceList[14]),
            FlSpot(15, widget.priceList[15]),
            FlSpot(16, widget.priceList[16]),
            FlSpot(17, widget.priceList[17]),
            FlSpot(18, widget.priceList[18]),
            FlSpot(19, widget.priceList[19]),
            FlSpot(20, widget.priceList[20]),
            FlSpot(21, widget.priceList[21]),
            FlSpot(22, widget.priceList[22]),
            FlSpot(23, widget.priceList[23]),
            FlSpot(24, widget.priceList[24]),
          ],
          isCurved: true,
          gradient: LinearGradient(
            colors: gradientColors,
          ),
          barWidth: 5,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
              colors: gradientColors
                  .map((color) => color.withOpacity(0.3))
                  .toList(),
            ),
          ),
        ),
      ],
    );
  }
}
