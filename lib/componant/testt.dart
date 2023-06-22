// ignore_for_file: unnecessary_new

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:charts_flutter/flutter.dart' as charts;

// ignore: camel_case_types
class Charts extends StatefulWidget {
  @override
  State<Charts> createState() => _chartsState();
}

class _chartsState extends State<Charts> {
  final chart = new charts.BarChart(
    [
      new charts.Series<HistogramData, String>(
        id: 'Histogram',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (HistogramData data, _) => data.category,
        measureFn: (HistogramData data, _) => data.value,
        data: [
          new HistogramData('Positive', 0.25),
          new HistogramData('Neutral', 0.40),
          new HistogramData('Negative', 0.20),
        ],
      )
    ],
    animate: true,
    vertical: false,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("dfsdfsdfsdf"),
      ),
      body: Column(children: []),
    );
  }
}

class HistogramData {
  final String category;
  final double value;

  HistogramData(this.category, this.value);
}
