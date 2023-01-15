import 'dart:async';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:prodep_client/widgets/prodepvision/indicator.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class Prodepfbchart extends StatefulWidget {
  final String username;
  final String date;
  final int positiveCount;
  final int negativeCount;

  const Prodepfbchart(
      {super.key,
      required this.username,
      required this.date,
      required this.positiveCount,
      required this.negativeCount});

  @override
  State<StatefulWidget> createState() => ProdepfbchartState();
}

class ProdepfbchartState extends State<Prodepfbchart> {
  int touchedIndex = -1;
  String positiveLabel = "";
  String negativeLabel = "";

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.3,
      child: Card(
        color: Colors.white,
        child: Row(
          children: <Widget>[
            const SizedBox(
              height: 18,
            ),
            Expanded(
              child: AspectRatio(
                aspectRatio: 1,
                child: PieChart(
                  PieChartData(
                    pieTouchData: PieTouchData(
                      touchCallback: (FlTouchEvent event, pieTouchResponse) {
                        setState(() {
                          if (!event.isInterestedForInteractions ||
                              pieTouchResponse == null ||
                              pieTouchResponse.touchedSection == null) {
                            touchedIndex = -1;
                            return;
                          }
                          touchedIndex = pieTouchResponse
                              .touchedSection!.touchedSectionIndex;
                        });
                      },
                    ),
                    borderData: FlBorderData(
                      show: false,
                    ),
                    sectionsSpace: 0,
                    centerSpaceRadius: 40,
                    sections: showingSections(
                        widget.positiveCount, widget.negativeCount),
                  ),
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  FontAwesomeIcons.facebook,
                  color: Colors.blue,
                  size: 60,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: const <Widget>[
                    Padding(
                      padding: EdgeInsets.only(left: 4.0),
                      child: Indicator(
                        color: Colors.red,
                        text: 'NEGATIVE',
                        isSquare: true,
                      ),
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Indicator(
                      color: Colors.green,
                      text: 'POSITIVE',
                      isSquare: true,
                    ),
                    SizedBox(
                      height: 4,
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(
              width: 28,
            ),
          ],
        ),
      ),
    );
  }

  List<PieChartSectionData> showingSections(
      int positiveCount, int negativeCount) {
    Timer(const Duration(milliseconds: 500), () {
      setState(() {
        positiveLabel =
            ((positiveCount / (negativeCount + positiveCount)) * 100.0)
                    .round()
                    .toString() +
                "%";
        negativeLabel =
            ((negativeCount / (negativeCount + positiveCount)) * 100.0)
                    .round()
                    .toString() +
                "%";
      });
    });

    return List.generate(2, (i) {
      final isTouched = i == touchedIndex;
      final fontSize = isTouched ? 25.0 : 16.0;
      final radius = isTouched ? 60.0 : 50.0;
      switch (i) {
        case 0:
          return PieChartSectionData(
            color: Colors.red,
            value: negativeCount.toDouble(),
            title: negativeLabel,
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: const Color(0xffffffff),
            ),
          );
        case 1:
          return PieChartSectionData(
            color: Colors.green,
            value: positiveCount.toDouble(),
            title: positiveLabel,
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: const Color(0xffffffff),
            ),
          );

        default:
          throw Error();
      }
    });
  }
}
