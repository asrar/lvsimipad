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
class LiveLineChart extends SampleView {
  /// Creates the realtime line chart sample.
  final Function() refreshParent;

  const LiveLineChart({required this.refreshParent})
      : super(refreshParent: refreshParent);

  @override
  _LiveLineChartState createState() => _LiveLineChartState();
}

/// State class of the realtime line chart.
class _LiveLineChartState extends SampleViewState {
  final dref = FirebaseDatabase.instance.ref('UsersData');

  double time = 1;
  int indexoffset = 0;
  int index = 0;

  int spo2 = 0;
  List<dynamic> listIndex = List.empty(growable: true);

  // List list = [50, 80, 50, 150, 80, 50];
  List list = [0, 27, 0, 62, 27, 0];

  //
  // List list1 = [70,72,60,150,70,72];
  // List list2 = [50,140,50,140,50,140];

  // List listA = [45, 48, 45, 49, 45, 45, 100, 45, 46];
  List listA = [7, 10, 7, 11, 7, 7, 60, 7, 8];

  // List listB = [55, 45, 100, 50, 45, 60, 45, 55, 45, 55];
  List listB = [17, 7, 60, 12, 7, 22, 7, 17, 7, 17];

  // List listC = [60, 100, 45, 58, 53, 55, 53];
  List listC = [22, 62, 7, 20, 15, 17, 15];

  // List listD = [60, 50, 100, 45, 60, 65, 60, 55];
  List listD = [22, 7, 62, 7, 22, 27, 22, 17];

  // List listE = [65, 80, 100, 80, 90, 45, 55];
  List listE = [27, 42, 62, 42, 52, 7, 17];

  // List listF = [48, 100, 45, 50, 52, 50, 67, 63];
  List listF = [10, 59, 7, 12, 14, 10, 34, 25];

  // List listG = [45, 45, 55, 47, 45, 100, 43, 45, 45, 56, 46, 58, 48, 48, 48];
  List listG = [7, 7, 17, 10, 7, 62, 7, 7, 7, 18, 7, 20, 10, 10, 10];

  // List listH = [
  //   45,
  //   45,
  //   54,
  //   45,
  //   43,
  //   100,
  //   45,
  //   47,
  //   47,
  //   55,
  //   48,
  //   48,
  //   56,
  //   48,
  //   48,
  //   56,
  //   48,
  //   48
  // ];
  List listH = [
    7,
    7,
    16,
    52,
    7,
    62,
    7,
    10,
    10,
    17,
    10,
    10,
    18,
    10,
    10,
    18,
    10,
    10
  ];

  // List listI = [
  //   90,
  //   90,
  //   95,
  //   90,
  //   97,
  //   45,
  //   50,
  //   52,
  //   67,
  //   100,
  //   70,
  //   70,
  //   73,
  //   70,
  //   70,
  //   70,
  //   70,
  //   73,
  //   70,
  //   73
  // ];
  List listI = [
    52,
    52,
    57,
    52,
    54,
    7,
    17,
    19,
    5,
    62,
    32,
    32,
    35,
    32,
    32,
    32,
    33,
    35,
    32,
    35
  ];
  int a_count = 9;
  int b_count = 10;
  int c_count = 7;
  int d_count = 8;
  int e_count = 7;
  int f_count = 8;
  int g_count = 15;
  int h_count = 18;
  int i_count = 20;
  DateTime dt = DateTime(2022, 12, 10, 4, 05, 1);
  int heartRate = 70;
  String lv_mean = '';
  String ab_mean = '';
  String ab_sys = '';
  String ab_dia = '';
  String pressure = '';
  int ii = 0;
  int j = 0;
  int ii_count = 0;
  int a_index = 6;
  int b_index = 2;
  int c_index = 1;
  int d_index = 2;
  int e_index = 2;
  int f_index = 1;
  int g_index = 5;
  int h_index = 5;
  int i_index = 9;
  String runningWaveForm = "";
  String runningPressure = "";
  String onGoingWaveForm = "";
  String onGoingPressure = "";
  int typeCount = 0;
  String typeOfWave = "";
  String typeOfPressure = "";
  Timer? timer;
  List<_ChartData>? chartData;
  ChartSeriesController? _chartSeriesController;

  @override
  void dispose() {
    // timer?.cancel();
    chartData!.clear();
    _chartSeriesController = null;
    super.dispose();
  }

  @override
  void initState() {
    timer?.cancel();
    chartData = <_ChartData>[];
    dref;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Create or update the timer in the build method.
    if (timer == null) {
      // Calculate the initial timer interval.
      Overseer.HR_speedTime = calculateSpeedTime();

      // Create a timer with the initial interval.
      timer = Timer.periodic(
          Duration(milliseconds: Overseer.HR_speedTime), _updateDataSource);
    }

    return _buildLiveLineChart();
  }

  // Function to calculate the new speedTime based on Overseer.HR
  int calculateSpeedTime() {
    int newSpeedTime =
        200; // Default value, change this to your desired default.

    // Calculate new speedTime based on Overseer.HR
    if (Overseer.HR >= 150) {
      newSpeedTime = 40;
    } else if (Overseer.HR >= 140) {
      newSpeedTime = 60;
    } else if (Overseer.HR >= 130) {
      newSpeedTime = 80;
    } else if (Overseer.HR >= 120) {
      newSpeedTime = 100;
    } else if (Overseer.HR >= 120) {
      newSpeedTime = 120;
    } else if (Overseer.HR >= 110) {
      newSpeedTime = 140;
    } else if (Overseer.HR >= 100) {
      newSpeedTime = 160;
    } else if (Overseer.HR >= 90) {
      newSpeedTime = 180;
    } else if (Overseer.HR >= 80) {
      newSpeedTime = 200;
    } else if (Overseer.HR >= 70) {
      newSpeedTime = 250;
    } else if (Overseer.HR >= 60) {
      newSpeedTime = 300;
    } else if (Overseer.HR >= 50) {
      newSpeedTime = 350;
    } else if (Overseer.HR >= 40) {
      newSpeedTime = 400;
    } else if (Overseer.HR >= 30) {
      newSpeedTime = 450;
    } else if (Overseer.HR >= 20) {
      newSpeedTime = 500;
    } else if (Overseer.HR >= 10) {
      newSpeedTime = 550;
    } else if (Overseer.HR < 10) {
      newSpeedTime = 600;
    }

    return newSpeedTime;
  }

  /// Returns the realtime Cartesian line chart.
  StreamBuilder _buildLiveLineChart() {
    return StreamBuilder(
      stream: dref.onValue,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (!snapshot.hasData || snapshot.data == null) {
          return const Center(
              child:
                  CircularProgressIndicator()); // Show a progress indicator if data is null.
        }
        Map<dynamic, dynamic> map = snapshot.data?.snapshot.value as dynamic;
        List<dynamic> list = [];
        list.clear();
        ////String hr = map["heart_rate"];
        list = map.values.toList();
        Map mm = list[1];
        print("----mm value are >>> okkkkk ${mm.values.toString()}");
        print("----mm value are length >>> okkkkk  ${mm.values.length}");
        var iter = mm.values.iterator;
        while (iter.moveNext()) {
          print("at first");
          // while there is next element
          Map values = iter.current;
          Overseer.HR;
          print("at second");
          values.forEach((key, value) {
            print(">>>>>>>>iter current heart_rate > $key *****  $value ");
            if (key.toString().contains("heart_rate")) {
              heartRate = value;
              timer;
            }
            if (key.toString().contains("lv_mean")) {
              lv_mean = value.toString();
              Overseer.lvpMean = lv_mean ;
              print('object.....${lv_mean}');
              print('object.....${Overseer.lvpMean}');
            }
            if (key.toString().contains("ab_mean")) {
              ab_mean = value.toString();
              Overseer.abpMean = ab_mean;
              print('object.....${ab_mean}');
              print('object.....${Overseer.abpMean}');
            }
            if (key.toString().contains("ab_sys")) {
              ab_sys = value.toString();
              Overseer.absys = ab_sys;
              print('object.....${ab_mean}');
              print('object.....${Overseer.absys}');
            }
            if (key.toString().contains("ab_dai")) {
              ab_dia = value.toString();
              Overseer.abdia = ab_dia;
              print('object.....${ab_mean}');
              print('object.....${Overseer.abdia}');
            }
            if (key.toString().contains("rhythm")) {
              if (!runningWaveForm.contains(value.toString())) {
                ii = 0;
              }
              typeOfWave = value.toString();
              runningWaveForm = typeOfWave;
            }
            if (key.toString().contains("LALVPressure")) {
              if (!runningPressure.contains(value.toString())) {}
              typeOfPressure = value.toString();
              runningPressure = typeOfPressure;
              Overseer.Pressure = runningPressure;
              print('object.....${Overseer.Pressure}');
              print('object.............123sfdf${Overseer.Pressure}');
            }
          });
          //print("iter current heart_rate > ${iter.current}");
        }
        String stn = ""; //mm.values.elementAt(0)["heart_rate"].toString();
        //   String stn1 = mm.values.elementAt(13)["rhythm"].toString();
        // print("--- stn0 ${stn}");
        //  print("--- stn1 ${stn1}");
        // String stn = "";//mm.values.first["heart_rate"].toString();
        print("---------stn-------------0000 heart rate ${typeOfWave}");
        // heartRate = int.parse(heartRate);
        print("HR value is here as HR0000 ${heartRate}");
        print("typeOfWave  value is >>   ${typeOfWave}");

        print('>>This is List${list.toString()}');

        /// This is Example how to access the specific index
        ///list[1]['readings']['heart_rate'].toString() etc.
        return SfCartesianChart(
            plotAreaBorderWidth: 0,
            primaryXAxis: DateTimeAxis(
                isVisible: true,
                minimum: DateTime(2022, 12, 10, 4, 05, 01),
                intervalType: DateTimeIntervalType.seconds,
                desiredIntervals: 60,
                axisLine: const AxisLine(width: 0),
                majorGridLines: const MajorGridLines(width: 0),
                interval: 60,
                maximum: DateTime(2022, 12, 10, 4, 06, 01),
                majorTickLines: const MajorTickLines(size: 0)),
            primaryYAxis: NumericAxis(
                isVisible: true,
                majorGridLines: const MajorGridLines(width: 0),
                //Hide the axis line of x-axis
                axisLine: const AxisLine(width: 0),
                minimum: -15,
                maximum: 200,
                //    axisLine: const AxisLine(width: 0),
                majorTickLines: const MajorTickLines(size: 0)),
            series: <ChartSeries<_ChartData, DateTime>>[
              SplineSeries<_ChartData, DateTime>(
                onRendererCreated: (ChartSeriesController controller) {
                  _chartSeriesController = controller;
                },
                dataSource: chartData!,
                color: Colors.green,
                xValueMapper: (_ChartData sales, _) => sales.country,
                yValueMapper: (_ChartData sales, _) => sales.sales,
                animationDuration: 0,
              )
            ]);
      },
    );
  }

  ///Continously updating the data source based on timer
  void _updateDataSource(Timer timer) {
    listIndex.add(indexoffset);
    indexoffset = indexoffset + 1;
    Overseer.HR_speedTime = calculateSpeedTime();

    // Cancel the existing timer and start a new timer with the updated interval.
    timer.cancel();
    timer = Timer.periodic(
        Duration(milliseconds: Overseer.HR_speedTime), _updateDataSource);
    ///
    if (typeOfWave.contains("Sinus Rhythm")) {
      onGoingWaveForm = "Sinus Rhythm";
      ii_count = listA.length;
      typeCount = a_index;
    } else if (typeOfWave.contains("Atrial Flutter")) {
      onGoingWaveForm = "Atrial Flutter";
      ii_count = listB.length;
      typeCount = b_index;
    } else if (typeOfWave.contains("Fibrillation")) {
      onGoingWaveForm = "Fibrillation";
      ii_count = listC.length;
      typeCount = c_index;
    } else if (typeOfWave.contains("AV Nodal Tachycardia")) {
      onGoingWaveForm = "AV Nodal Tachycardia";
      ii_count = listD.length;
      typeCount = d_index;
    } else if (typeOfWave.contains("Ventricular Tachycardia")) {
      onGoingWaveForm = "Ventricular Tachycardia";
      ii_count = listE.length;
      typeCount = e_index;
    } else if (typeOfWave.contains("First Degree A-V Block")) {
      onGoingWaveForm = "First Degree A-V Block";
      ii_count = listF.length;
      typeCount = f_index;
    } else if (typeOfWave.contains("Type2-Second Degree A-V Block")) {
      onGoingWaveForm = "Type2-Second Degree A-V Block";
      ii_count = listG.length;
      typeCount = g_index;
    } else if (typeOfWave.contains("Type1-Second Degree A-V Block")) {
      onGoingWaveForm = "Type1-Second Degree A-V Block";
      ii_count = listH.length;
      typeCount = h_index;
    } else if (typeOfWave.contains("Third Degree A-V Block")) {
      onGoingWaveForm = "Third Degree A-V Block";
      ii_count = listI.length;
      typeCount = i_index;
    }
    print(
        "${ii}<<<<<<  ${chartData!.length}  the isCardView is >>>${isCardView}");
    if (isCardView != null) {
      print(
          "Adding index is >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>..  ${index}");
      if (indexoffset == 201) {
        dt = DateTime(2022, 12, 10, 4, 05, 1);
        indexoffset = 0;
        _chartSeriesController?.updateDataSource(
          removedDataIndexes: <int>[chartData!.length - 1],
        );
        //  chartData!.clear();
        print(
            "------------------------------------------------- near length is ${chartData!.length}");
      } else {
        if (indexoffset < 100) {
          print('in side if line 364');
          dt = dt.subtract(const Duration(milliseconds: 300));
          dt = dt.add(const Duration(milliseconds: 700));
          widget.refreshParent();
        } else {
          print('in side else line 369');
          dt = dt.add(const Duration(milliseconds: 300));
          widget.refreshParent();
        }
      }
      print(
          " waveform is>>> ${typeOfWave}  Adding index is ${indexoffset} >>>>>>>>>>>>>>>>>> DATE >>>>>>>>>>>>>>>>>>>>>>>>>. ${dt}");

      if (indexoffset < 100) {
        print('in side if line 378');
        Overseer.HR = heartRate;
        Overseer.Pressure = pressure;
        if (ii == typeCount) {
          print(
              "FB heart rate 1 with normal ${ii} >> ${dt}   --E  data:${heartRate}");
          chartData!.add(_ChartData(dt, heartRate));
        } else {
          if (listA.length == ii) {
            ii = ii - 1;
          }
          print("list length is ${listA.length}  and index is ${ii}");
          //    print("${typeOfWave} with normal ${ii} >> ${dt}   --  E data:${listA[ii]}");
          if (typeOfWave.contains("Sinus Rhythm")) {
            // _LiveLineChartState();
            print("YES YES----less 100---- Sinus Rhythm");
            chartData!.add(_ChartData(dt, listA[ii]));
          } else if (typeOfWave.contains("Atrial Flutter")) {
            // _LiveLineChartState();
            print("YES YES----less 100---- Atrial Flutter");
            chartData!.add(_ChartData(dt, listB[ii]));
          } else if (typeOfWave.contains("Fibrillation")) {
            // _LiveLineChartState();
            chartData!.add(_ChartData(dt, listC[ii]));
          } else if (typeOfWave.contains("AV Nodal Tachycardia")) {
            // _LiveLineChartState();
            chartData!.add(_ChartData(dt, listD[ii]));
          } else if (typeOfWave.contains("Ventricular Tachycardia")) {
            chartData!.add(_ChartData(dt, listE[ii]));
          } else if (typeOfWave.contains("First Degree A-V Block")) {
            chartData!.add(_ChartData(dt, listF[ii]));
          } else if (typeOfWave.contains("Type2-Second Degree A-V Block")) {
            chartData!.add(_ChartData(dt, listG[ii]));
          } else if (typeOfWave.contains("Type1-Second Degree A-V Block")) {
            chartData!.add(_ChartData(dt, listH[ii]));
          } else if (typeOfWave.contains("Third Degree A-V Block")) {
            chartData!.add(_ChartData(dt, listI[ii]));
          }
        }
      } else {
        Overseer.HR = heartRate;
        Overseer.Pressure = pressure;
        if (ii == typeCount) {
          print(" FB heart rate 2 is $heartRate");
          print(" FB heart rate 2 is $pressure");
          print(" FB heart rate 2 is ${Overseer.Pressure}");
          chartData!.add(_ChartData(dt, heartRate));
        } else {
          if (listA.length == ii) {
            ii = ii - 1;
          }
          print(" waveform is $typeOfWave ");
          if (typeOfWave.contains("Sinus Rhythm")) {
            print("YES YES----less 100---- Sinus Rhythm");
            chartData!.add(_ChartData(dt, listA[ii]));
          } else if (typeOfWave.contains("Atrial Flutter")) {
            print("YES YES----less 100---- Atrial Flutter");
            chartData!.add(_ChartData(dt, listB[ii]));
          } else if (typeOfWave.contains("Fibrillation")) {
            chartData!.add(_ChartData(dt, listC[ii]));
          } else if (typeOfWave.contains("AV Nodal Tachycardia")) {
            chartData!.add(_ChartData(dt, listD[ii]));
          } else if (typeOfWave.contains("Ventricular Tachycardia")) {
            chartData!.add(_ChartData(dt, listE[ii]));
          } else if (typeOfWave.contains("First Degree A-V Block")) {
            chartData!.add(_ChartData(dt, listF[ii]));
          } else if (typeOfWave.contains("Type2-Second Degree A-V Block")) {
            chartData!.add(_ChartData(dt, listG[ii]));
          } else if (typeOfWave.contains("Type1-Second Degree A-V Block")) {
            chartData!.add(_ChartData(dt, listH[ii]));
          } else if (typeOfWave.contains("Third Degree A-V Block")) {
            chartData!.add(_ChartData(dt, listI[ii]));
          }
        }
      }
      print("before list is>>>> ${ii}");
      print("LISTING LIST IS ${chartData!.last.country}");
      print("LISTING LIST IS >>>  ${chartData!.last.sales}");
      index = index + 1;
      if (index == 19) {
        //     index = 0;
      } //_ChartData(time+.5,43 )
      //  time = time+.5;
      if (time == 9) {
        //   time = 1.0;
      }
      if (chartData!.length > 199) {
        print(
            "***************************** yessddsf${chartData?.length.toString()} *********************");
        print(
            "index>  ${index} > ${time} £ is removing at ofo ${chartData!.length - 1}");
        chartData!.removeAt(0);
        // chartData!.removeAt(1);
        //chartData!.removeAt(2);

        _chartSeriesController?.updateDataSource(
          removedDataIndexes: <int>[0],
          addedDataIndexes: <int>[chartData!.length - 2], //
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

      print("Running ${runningWaveForm}     ---- OnGoing ${onGoingWaveForm}");
      if (!runningWaveForm.contains(onGoingWaveForm)) {
        print("YES CHANGED");
        ii = 0;
      } else {
        print("YES SAME ii=$ii   and j=$j");
        if (typeOfWave.contains("Sinus Rhythm")) {
          print(" the real ii is ${ii + 1}   real_count_a is ${a_count - 1}");
          ii + 1 == a_count - 1 ? ii = 0 : ii = ii + 1;
        } else if (typeOfWave.contains("Atrial Flutter")) {
          print(" the real ii is ${ii + 1}   real_count_b is ${b_count - 1}");
          ii + 1 == b_count - 1 ? ii = 0 : ii = ii + 1;
        } else if (typeOfWave.contains("Fibrillation")) {
          print(" the real ii is ${ii}   real_count_c is ${c_count - 1}");
          ii + 1 == c_count - 1 ? ii = 0 : ii = ii + 1;
        } else if (typeOfWave.contains("AV Nodal Tachycardia")) {
          print(" the real ii is ${ii}   real_count_d is ${d_count - 1}");
          ii + 1 == d_count - 1 ? ii = 0 : ii = ii + 1;
        } else if (typeOfWave.contains("Ventricular Tachycardia")) {
          print(" the real ii is ${ii}   real_count_e is ${e_count - 1}");
          ii + 1 == e_count - 1 ? ii = 0 : ii = ii + 1;
        } else if (typeOfWave.contains("First Degree A-V Block")) {
          print(" the real ii is ${ii}   real_count_f is ${f_count - 1}");
          ii + 1 == f_count - 1 ? ii = 0 : ii = ii + 1;
        } else if (typeOfWave.contains("Type2-Second Degree A-V Block")) {
          print(" the real ii is ${ii}   real_count_g is ${g_count - 1}");
          ii + 1 == g_count - 1 ? ii = 0 : ii = ii + 1;
        } else if (typeOfWave.contains("Type1-Second Degree A-V Block")) {
          print(" the real ii is ${ii}   real_count_h is ${h_count - 1}");
          ii + 1 == h_count - 1 ? ii = 0 : ii = ii + 1;
        } else if (typeOfWave.contains("Third Degree A-V Block")) {
          print(" the real ii is ${ii}   real_count_i is ${i_count - 1}");
          ii + 1 == i_count - 1 ? ii = 0 : ii = ii + 1;
        }
        j = ii;
      }
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
