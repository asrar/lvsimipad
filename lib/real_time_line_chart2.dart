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
class LiveLineChart2 extends SampleView {
  /// Creates the realtime line chart sample.
  final Function() refreshParent;
  const LiveLineChart2( {required this.refreshParent}) : super(refreshParent: refreshParent);

  @override
  _LiveLineChart2State createState() => _LiveLineChart2State();
}

/// State class of the realtime line chart.
class _LiveLineChart2State extends SampleViewState {
  final dref = FirebaseDatabase.instance.ref('UsersData');

  double time=1;
  int indexoffset = 0;
  int index = 0;
  int spo2 = 0;
  List<dynamic> listIndex =  List.empty(growable: true);
  List list = [80,50,130,90,80,50];
  List list1 = [80,50,80,50,80,50];
  DateTime dt = DateTime(2022, 12, 10, 4, 05,1);
  int ii=0;
  _LiveLineChart2State() {
    timer =
        Timer.periodic( Duration(milliseconds: 400), _updateDataSource);
  }

  Timer? timer;

  List<_ChartData>? chartData;
  //late int count;
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
    //count = 50;
    chartData = <_ChartData>[
    ];
    dref;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    // if (timer == null) {
    //   // Calculate the initial timer interval.
    //   Overseer.HR_speedTime2 = calculateSpeedTime();
    //
    //   // Create a timer with the initial interval.
    //   timer = Timer.periodic(Duration(milliseconds: Overseer.HR_speedTime2), _updateDataSource);
    // }
    if (timer == null) {
      // Calculate the initial timer interval.
      Overseer.HR_speedTime3 = calculateSpeedTime();

      // Create a timer with the initial interval.
      timer = Timer.periodic(
          Duration(milliseconds: Overseer.HR_speedTime3), _updateDataSource);
    }

    return _buildLiveLineChart2();
  }

  /// Function to calculate the new speedTime based on Overseer.HR
  int calculateSpeedTime() {
    int newSpeedTime = 400;  // Default value, change this to your desired default.

    // Calculate new speedTime based on Overseer.HR
    if (Overseer.HR >= 150) {
      newSpeedTime = 130;
    } else if (Overseer.HR >= 140) {
      newSpeedTime = 170;
    } else if (Overseer.HR >= 130) {
      newSpeedTime = 200;
    } else if (Overseer.HR >= 120) {
      newSpeedTime = 240;
    } else if (Overseer.HR >= 120) {
      newSpeedTime = 270;
    } else if (Overseer.HR >= 110) {
      newSpeedTime = 300;
    } else if (Overseer.HR >= 100) {
      newSpeedTime = 340;
    } else if (Overseer.HR >= 90) {
      newSpeedTime = 370;
    } else if (Overseer.HR >= 80) {
      newSpeedTime = 400;
    } else if (Overseer.HR >= 70) {
      newSpeedTime = 450;
    } else if (Overseer.HR >= 60) {
      newSpeedTime = 500;
    } else if (Overseer.HR >= 50) {
      newSpeedTime = 550;
    } else if (Overseer.HR >= 40) {
      newSpeedTime = 600;
    } else if (Overseer.HR >= 30) {
      newSpeedTime = 650;
    } else if (Overseer.HR >= 20) {
      newSpeedTime = 700;
    }
    return newSpeedTime;
  }
  // int calculateSpeedTime() {
  //   int newSpeedTime =
  //   200; // Default value, change this to your desired default.
  //
  //   // Calculate new speedTime based on Overseer.HR
  //   if (Overseer.HR >= 150) {
  //     newSpeedTime = 40;
  //   } else if (Overseer.HR >= 140) {
  //     newSpeedTime = 60;
  //   } else if (Overseer.HR >= 130) {
  //     newSpeedTime = 80;
  //   } else if (Overseer.HR >= 120) {
  //     newSpeedTime = 100;
  //   } else if (Overseer.HR >= 120) {
  //     newSpeedTime = 120;
  //   } else if (Overseer.HR >= 110) {
  //     newSpeedTime = 140;
  //   } else if (Overseer.HR >= 100) {
  //     newSpeedTime = 160;
  //   } else if (Overseer.HR >= 90) {
  //     newSpeedTime = 180;
  //   } else if (Overseer.HR >= 80) {
  //     newSpeedTime = 200;
  //   } else if (Overseer.HR >= 70) {
  //     newSpeedTime = 250;
  //   } else if (Overseer.HR >= 60) {
  //     newSpeedTime = 300;
  //   } else if (Overseer.HR >= 50) {
  //     newSpeedTime = 350;
  //   } else if (Overseer.HR >= 40) {
  //     newSpeedTime = 400;
  //   } else if (Overseer.HR >= 30) {
  //     newSpeedTime = 450;
  //   } else if (Overseer.HR >= 20) {
  //     newSpeedTime = 500;
  //   } else if (Overseer.HR >= 10) {
  //     newSpeedTime = 550;
  //   } else if (Overseer.HR < 10) {
  //     newSpeedTime = 600;
  //   }
  //
  //   return newSpeedTime;
  // }


  /// Returns the realtime Cartesian line chart.
  StreamBuilder _buildLiveLineChart2() {
    return StreamBuilder(
      stream: dref.onValue,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (!snapshot.hasData || snapshot.data == null) {
          return const Center(child: CircularProgressIndicator()); // Show a progress indicator if data is null.
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
            primaryYAxis: NumericAxis(
                isVisible: true,
                majorGridLines: const MajorGridLines(width: 0),
                //Hide the axis line of x-axis
                axisLine: const AxisLine(width: 0),
               // desiredIntervals: 200,
              //  interval: 200,
                  minimum: 50,
                maximum: 200,

                //    axisLine: const AxisLine(width: 0),
                majorTickLines: const MajorTickLines(size: 0)),
            series: <LineSeries<_ChartData, DateTime>>[
              LineSeries<_ChartData, DateTime>(
                onRendererCreated: (ChartSeriesController controller) {
                  _chartSeriesController = controller;
                },
                dataSource: chartData!,
                color: Colors.yellow.shade400,
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

    Overseer.HR_speedTime = calculateSpeedTime();

    // Cancel the existing timer and start a new timer with the updated interval.
    timer.cancel();
    timer = Timer.periodic(
        Duration(milliseconds: Overseer.HR_speedTime), _updateDataSource);



    if(ii==5){
     ii=0;
   }else{
     ii=ii+1;
   }
    print("${ii}<<<<<<  ${chartData!.length}  the isCardView is >>>${isCardView}");
    if (isCardView != null) {

      print("Adding index is >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>..  ${index}");
      if(indexoffset == 201) {
        dt = DateTime(2022, 12, 10, 4, 05,1);
        indexoffset = 0;
        _chartSeriesController?.updateDataSource(removedDataIndexes:<int>[chartData!.length - 1],);
      //  chartData!.clear();
        print("------------------------------------------------- near length is ${chartData!.length}");
      }else {

        if(indexoffset>100){
        //  dt = dt.subtract(Duration(milliseconds: 300));
          dt = dt.add(const Duration(milliseconds: 700));
          widget.refreshParent();
        }else{
          dt = dt.add(const Duration(milliseconds: 700));
          widget.refreshParent();
        }

      }
      print("Adding index is >>>>>>>>>>>>>>>>>> DATE >>>>>>>>>>>>>>>>>>>>>>>>>. ${dt}");
      Overseer.SPO2 = spo2;
      if(indexoffset < 150){
        Overseer.SPO2 = list1[1];
        if(ii==0 || ii==2 || ii==4){
          chartData!.add(new _ChartData(dt, spo2));
        }else{
          chartData!.add(new _ChartData(dt, list1[ii]));
        }

      }else{
        Overseer.SPO2 = list[3];
        chartData!.add(new _ChartData(dt, list1[ii]));
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
