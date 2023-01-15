import 'dart:async';

import 'package:prodep_client/widgets/prodepvision/indicator.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class ProdepvisionEarchart extends StatefulWidget {
  final String username;
  final List<dynamic> data;
  final String date;

  const ProdepvisionEarchart({
    super.key,
    required this.username,
    required this.data,
    required this.date,
  });

  @override
  State<StatefulWidget> createState() => ProdepvisionEarchartState();
}

class ProdepvisionEarchartState extends State<ProdepvisionEarchart> {
  List<dynamic> filteredData = [];
  List<FlSpot> earValuesArr = [];
  int count = 0;

  @override
  void initState() {
    super.initState();
  }

  initialiseData() {
    setState(() {
      filteredData = [];
      earValuesArr = [];
      count = 0;
    });
    for (var i = 0; i < widget.data.length; i++) {
      if (widget.data[i]['username'] == widget.username && widget.data[i]['date'] == widget.date) {
        var flspot = FlSpot(
            count.toDouble(), double.parse(widget.data[i]['earValue']) * 10.0);
        setState(() {
          filteredData.add(widget.data[i]);
          earValuesArr.add(flspot);
          count = count + 1;
        });
      }
    }
  }

  List<Color> gradientColors = [
    const Color(0xff23b6e6),
    const Color(0xff02d39a),
  ];

  bool showAvg = false;

  @override
  Widget build(BuildContext context) {
    initialiseData();
    return Stack(
      children: <Widget>[
        AspectRatio(
          aspectRatio: 2.0,
          child: DecoratedBox(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(18),
              ),
              color: Color.fromARGB(255, 255, 255, 255),
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
        SizedBox(
          width: 60,
          height: 34,
          child: TextButton(
            onPressed: () {
              setState(() {
                showAvg = !showAvg;
              });
            },
            child: Text(
              'EAR',
              style: TextStyle(
                fontSize: 12,
                color: showAvg ? Colors.white.withOpacity(0.5) : Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Color(0xff68737d),
      fontWeight: FontWeight.bold,
      fontSize: 16,
    );
    Widget text;
    if (value <= filteredData.length) {
      //print(filteredData.length);
      text = Text(value.round().toString(), style: style);
    } else {
      text = Text(value.round().toString(), style: style);
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: text,
    );
  }

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Color(0xff67727d),
      fontWeight: FontWeight.bold,
      fontSize: 15,
    );
    String text;
    if (value <= filteredData.length) {
      text = (value / 10).toString();
    } else {
      text = 'x';
    }

    return Text(text, style: style, textAlign: TextAlign.left);
  }

  LineChartData mainData() {
    return LineChartData(
      gridData: FlGridData(
        show: true,
        drawVerticalLine: true,
        horizontalInterval: 1,
        verticalInterval: 1,
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: const Color(0xff37434d),
            strokeWidth: 1,
          );
        },
        getDrawingVerticalLine: (value) {
          return FlLine(
            color: const Color(0xff37434d),
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
          sideTitles: SideTitles(showTitles: false),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            interval: 1,
            getTitlesWidget: bottomTitleWidgets,
          ),
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
        show: true,
        border: Border.all(color: const Color(0xff37434d)),
      ),
      minX: 0,
      maxX: filteredData.length.toDouble() - 1.0,
      minY: 0,
      maxY: 5,
      lineBarsData: [
        LineChartBarData(
          spots: earValuesArr,
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
