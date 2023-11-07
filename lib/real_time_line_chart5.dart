/// Dart imports
import 'dart:async';
import 'dart:math' as math;

import 'package:firebase_database/firebase_database.dart';
/// Package imports
import 'package:flutter/material.dart';

/// Chart import
import 'package:syncfusion_flutter_charts/charts.dart';

import 'AppLayer/Overseer.dart';
/// Local imports
import 'sample_view.dart';

/// Renders the realtime line chart sample.
class LiveLineChart5 extends SampleView {
  /// Creates the realtime line chart sample.
  final Function() refreshParent;
  const LiveLineChart5( {required this.refreshParent}) : super(refreshParent: refreshParent);

  @override
  _LiveLineChart5State createState() => _LiveLineChart5State();
}

/// State class of the realtime line chart.
class _LiveLineChart5State extends SampleViewState {
  final dref = FirebaseDatabase.instance.ref('UsersData');

  double time=1;
  int indexoffset = 0;
  int index = 0;
  int spo2 = 0;
  int lvPressure = 0;
  List<dynamic> listIndex =  List.empty(growable: true);
  List list = [80, 90, 75, 70, 78, 76, 73];
  List list1 = [80, 90, 75, 70, 78, 76, 73];
  List list2 = [80, 90, 75, 70, 78, 76, 73];
  List list12 = [80, 90, 75, 70, 78, 76, 73];
  DateTime dt = DateTime(2022, 12, 10, 4, 05,1);
  int ii=0;
  _LiveLineChart5State() {
    timer =
        Timer.periodic(const Duration(milliseconds: 400), _updateDataSource);
  }

  Timer? timer;

  List<_ChartData>? chartData;
  @override
  void dispose() {
    timer?.cancel();
    chartData!.clear();
    _chartSeriesController = null;
    super.dispose();
  }

  @override
  void initState() {
    //count = 50;
    chartData = <_ChartData>[];
    dref;
    super.initState();
  }

  //late int count;
  ChartSeriesController? _chartSeriesController;

  @override
  Widget build(BuildContext context) {
    return _buildLiveLineChart5();
  }

  /// Returns the realtime Cartesian line chart.
  StreamBuilder _buildLiveLineChart5() {
    return StreamBuilder(
      stream: dref.onValue,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (!snapshot.hasData || snapshot.data == null) {
          return Center(child: const CircularProgressIndicator()); // Show a progress indicator if data is null.
        }
        Map<dynamic, dynamic> map =
        snapshot.data?.snapshot.value as dynamic;
        List<dynamic> list = [];
        list.clear();
        list = map.values.toList();

        Map mm = list[1];
        print("----mm value are >>> ${mm.values.toString()}");
        String stn = mm.values.last["spo2"].toString();
        spo2 = int.parse(stn);
        String stn2 = mm.values.last["lv_pressure"].toString();
        lvPressure = int.parse(stn2);
        Overseer.lvPressure = lvPressure;
        String stn3 = mm.values.last["lv_pressure"].toString();
        lvPressure = int.parse(stn2);
        Overseer.lvPressure = lvPressure;
        print("HR value is here as HR ${stn}");
        print('>>This is List${list.toString()}');
        print('This is List${list.toString()}');
        /// This is Example how to access the specific index
        ///list[1]['readings']['heart_rate'].toString() etc.
        return SfCartesianChart(
            backgroundColor: Colors.black,
            plotAreaBorderWidth: 0,
            primaryXAxis: DateTimeAxis(
                isVisible: true,
                minimum: DateTime(2022, 12, 10, 4, 05,01),
                intervalType: DateTimeIntervalType.seconds,
                desiredIntervals: 60,
                axisLine: const AxisLine(width: 0),
                majorGridLines: const MajorGridLines(width: 0),
                interval: 60,
                maximum: DateTime(2022, 12, 10, 4, 06,01),
                majorTickLines: const MajorTickLines(size: 0)),
            // NumericAxis(
            //     isVisible: true,
            //
            //     //Hide the gridlines of x-axis
            //     majorGridLines: MajorGridLines(width: 0),
            //     //Hide the axis line of x-axis
            //     axisLine: AxisLine(width: 0),
            //   //  desiredIntervals: 10,
            //
            //     majorTickLines: const MajorTickLines(size: 0)
            // ),
            primaryYAxis: NumericAxis(
                isVisible: true,
                majorGridLines: const MajorGridLines(width: 0),
                //Hide the axis line of x-axis
                axisLine: const AxisLine(width: 0),
                // desiredIntervals: 200,
                //  interval: 200,
                minimum: 20,
                maximum: 200,
                //    axisLine: const AxisLine(width: 0),
                majorTickLines: const MajorTickLines(size: 0)),
            series: <ChartSeries<_ChartData, DateTime>>[
              SplineSeries<_ChartData, DateTime>(
                onRendererCreated: (ChartSeriesController controller) {
                  _chartSeriesController = controller;
                },
                dataSource: chartData!,
                color: Colors.deepOrangeAccent.shade200,
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
    listIndex.add(indexoffset);
    indexoffset = indexoffset+1;
    if(ii==5){
      ii=0;
    }else{
      ii=ii+1;
    }
    print("${ii}<<<<<<  ${chartData!.length}  the isCardView is >>>${isCardView}");
    if (isCardView != null) {

      print("Adding index is >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>..  ${index}");
      if(indexoffset == 151) {
        dt = DateTime(2022, 12, 10, 4, 05,1);
        indexoffset = 0;
        _chartSeriesController?.updateDataSource(removedDataIndexes:<int>[chartData!.length - 1],);
        //  chartData!.clear();
        print("------------------------------------------------- near length is ${chartData!.length}");
      }else {

        if(indexoffset>80){
          //  dt = dt.subtract(Duration(milliseconds: 300));
          dt = dt.add(Duration(milliseconds: 700));
          widget.refreshParent();
        }else{
          dt = dt.add(Duration(milliseconds: 700));
          widget.refreshParent();
        }

      }
      print("Adding index is >>>>>>>>>>>>>>>>>> DATE >>>>>>>>>>>>>>>>>>>>>>>>>. ${dt}");
      Overseer.SPO2 = spo2;
      if(indexoffset < 150){
        Overseer.SPO2 = list1[1];
        if(ii==0 || ii==2 || ii==4){
          chartData!.add(_ChartData(dt, spo2));
        }else{
          chartData!.add(_ChartData(dt, list1[ii]));
        }

      }else{
        Overseer.SPO2 = list[3];
        chartData!.add(_ChartData(dt, list1[ii]));
      }

      print("before list is>>>> ${ii}");
      print("LISTING LIST IS ${chartData!.last.country}");
      print("LISTING LIST IS >>>  ${chartData!.last.sales}");
      index = index+1;
      if(index==19) {
        //     index = 0;
      }//_ChartData(time+.5,43 )
      //  time = time+.5;
      if(time ==9) {
        //   time = 1.0;
      }
      if (chartData!.length > 149) {
        print("***************************** yes *********************");
        print("index>  ${index} > ${time} £ is removing at ofo2 ${chartData!.length - 1}");
        chartData!.removeAt(0);
        _chartSeriesController?.updateDataSource(
          removedDataIndexes: <int>[0],
          addedDataIndexes:  <int>[chartData!.length - 2],//
        );
        //  chartData!.clear();
      } else {

        print("***************************** NO *********************");
        print(" ${time} ** is 20 >>>${chartData!.length}");
        _chartSeriesController?.updateDataSource(
          addedDataIndexes: <int>[chartData!.length - 1],
        );
      }
      //count = count + 1;
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
  final DateTime country;
  final num sales;
}
