/// Dart imports
import 'dart:async';
import 'dart:math' as math;

import 'package:firebase_database/firebase_database.dart';
/// Package imports
import 'package:flutter/material.dart';

/// Chart import
import 'package:syncfusion_flutter_charts/charts.dart';

/// Local imports
import 'sample_view.dart';

/// Renders the realtime line chart sample.
class LiveLineChart extends SampleView {
  /// Creates the realtime line chart sample.
  const LiveLineChart() : super();

  @override
  _LiveLineChartState createState() => _LiveLineChartState();
}

/// State class of the realtime line chart.
class _LiveLineChartState extends SampleViewState {
  final dref = FirebaseDatabase.instance.ref('UsersData');

  _LiveLineChartState() {
    timer =
        Timer.periodic(const Duration(milliseconds: 100), _updateDataSource);
  }

  Timer? timer;
  List<_ChartData>? chartData;
  late int count;
  ChartSeriesController? _chartSeriesController;

  @override
  void dispose() {
    timer?.cancel();
    chartData!.clear();
    _chartSeriesController = null;
    super.dispose();
  }

  @override
  void initState() {
    count = 19;
    chartData = <_ChartData>[
      _ChartData(0, 42),
      _ChartData(1, 47),
      _ChartData(2, 33),
      _ChartData(3, 49),
      _ChartData(4, 54),
      _ChartData(5, 41),
      _ChartData(6, 58),
      _ChartData(7, 51),
      _ChartData(8, 98),
      _ChartData(9, 41),
      _ChartData(10, 99),
      _ChartData(11, 72),
      _ChartData(12, 86),
      _ChartData(13, 52),
      _ChartData(14, 94),
      _ChartData(15, 92),
      _ChartData(16, 86),
      _ChartData(17, 72),
      _ChartData(18, 99),
    ];
    dref;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _buildLiveLineChart();
  }

  /// Returns the realtime Cartesian line chart.
  StreamBuilder _buildLiveLineChart() {
    return StreamBuilder(
      stream: dref.onValue,
      builder: (context, snapshot) {
        Map<dynamic, dynamic> map =
        snapshot.data?.snapshot.value as dynamic;
        List<dynamic> list = [];
        list.clear();
        list = map.values.toList();
        print('This is List${list.toString()}');
        /// This is Example how to access the specific index
        ///list[1]['readings']['heart_rate'].toString() etc.
        return SfCartesianChart(
            backgroundColor: Colors.black,
            plotAreaBorderWidth: 0,

            primaryXAxis:
            NumericAxis(
                isVisible: false,

                //Hide the gridlines of x-axis
                majorGridLines: MajorGridLines(width: 0),
                //Hide the axis line of x-axis
                axisLine: AxisLine(width: 0),
                majorTickLines: const MajorTickLines(size: 0)
            ),
            primaryYAxis: NumericAxis(
                isVisible: false,
                majorGridLines: MajorGridLines(width: 0),
                //Hide the axis line of x-axis
                axisLine: AxisLine(width: 0),

                //    axisLine: const AxisLine(width: 0),
                majorTickLines: const MajorTickLines(size: 0)),
            series: <LineSeries<_ChartData, int>>[
              LineSeries<_ChartData, int>(
                onRendererCreated: (ChartSeriesController controller) {
                  _chartSeriesController = controller;
                },
                dataSource: chartData!,
                color: Colors.green,
                xValueMapper: (_ChartData sales, _) => sales.country,
                yValueMapper: (_ChartData sales, _) => sales.sales,
                animationDuration: 0,
              )
            ]) ;
      },
    );
  }

  ///Continously updating the data source based on timer
  void _updateDataSource(Timer timer) {
    if (isCardView != null) {
        chartData!.add(_ChartData(count, _getRandomInt(10, 100)));
      if (chartData!.length == 20) {
        chartData!.removeAt(0);
        _chartSeriesController?.updateDataSource(
          addedDataIndexes: <int>[chartData!.length - 1],
          removedDataIndexes: <int>[0],
        );
      } else {
        _chartSeriesController?.updateDataSource(
          addedDataIndexes: <int>[chartData!.length - 1],
        );
      }
      count = count + 1;
    }
  }

  ///Get the random data
  int _getRandomInt(int min, int max) {
    final math.Random random = math.Random();
    return min + random.nextInt(max - min);
  }
}

/// Private calss for storing the chart series data points.
class _ChartData {
  _ChartData(this.country, this.sales);
  final int country;
  final num sales;
}
