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
  const LiveLineChart( {required this.refreshParent}) : super(refreshParent: refreshParent);

  @override
  _LiveLineChartState createState() => _LiveLineChartState();
}

/// State class of the realtime line chart.
class _LiveLineChartState extends SampleViewState {
  final dref = FirebaseDatabase.instance.ref('UsersData');

  double time=1;
  int indexoffset = 0;
  int index = 0;
  List<dynamic> listIndex =  List.empty(growable: true);
  List list = [50,80,50,150,80,50];
  List list1 = [70,72,60,150,70,72];
  List list2 = [50,140,50,140,50,140];

  List listA = [45,48,45,49,45,45,100,45,46];
  List listB = [55,45,100,50,45,60,45,55,45,55];
  List listC = [60,100,45,58,53,55,53];
  List listD = [60,50,100,45,60,65,60,55];
  List listE = [65,80,100,80,90,45,55];
  List listF = [48,100,45,50,52,50,67,63];
  List listG = [45,45,55,47,45,100,43,45,45,56,46,58,48,48,48];
  List listH = [45,45,54,45,43,100,45,47,47,55,48,48,56,48,48,56,48,48];
  List listI = [90,90,95,90,97,45,50,52,67,100,70,70,73,70,70,70,70,73,70,73];

  int a_count=9;
  int b_count=10;
  int c_count=7;
  int d_count=8;
  int e_count=7;
  int f_count=8;
  int g_count=15;
  int h_count=18;
  int i_count=20;





  DateTime dt = DateTime(2022, 12, 10, 4, 05,1);
  int heartRate = 50;
  int ii=0;
  int j=0;
  int ii_count=0;
  int a_index=6;
  int b_index=2;
  int c_index=1;
  int d_index=2;
  int e_index=2;
  int f_index=1;
  int g_index=5;
  int h_index=5;
  int i_index=9;





  String runningWaveForm ="";
  String onGoingWaveForm ="";

  int typeCount=0;

  String typeOfWave  = "";

  _LiveLineChartState() {

    timer =
        Timer.periodic(Duration(milliseconds: 200), _updateDataSource);
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
      // _ChartData(0, 99),
      // _ChartData(.5, 33),
      // _ChartData(1, 43),
      // _ChartData(1.5, 33),
      // _ChartData(2, 43),
      // _ChartData(2.5, 33),
      // _ChartData(3, 99),
      // _ChartData(3.5, 33),
      // _ChartData(4, 43),
      // _ChartData(4.5, 33),
      // _ChartData(5, 43),
      // _ChartData(5.5, 33),
      // _ChartData(6, 99),
      // _ChartData(6.5, 33),
      // _ChartData(7, 43),
      // _ChartData(7.5, 33),
      // _ChartData(8, 43),
      // _ChartData(8.5, 33),
      // _ChartData(100, 99),
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
        ////String hr = map["heart_rate"];

        list = map.values.toList();
        
        Map mm = list[1];
        print("----mm value are >>> ${mm.values.toString()}");
        print("----mm value are length >>> ${mm.values.length}");
        var iter = mm.values.iterator; // get the iterator


        while (iter.moveNext()) {
          // while there is next element
          Map values = iter.current;
          values.forEach((key, value) {
            print("iter current heart_rate > $key *****  $value ");
            if(key.toString().contains("heart_rate")){
              heartRate = value;
            }
            if(key.toString().contains("rhythm")){
              if(!runningWaveForm.contains(value.toString())){
                ii=0;
              }
              typeOfWave = value.toString();
              runningWaveForm = typeOfWave;
            }
          });
          //print("iter current heart_rate > ${iter.current}");
        }

        String stn = "";//mm.values.elementAt(0)["heart_rate"].toString();
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
            backgroundColor: Colors.black,
            plotAreaBorderWidth: 0,

            primaryXAxis: DateTimeAxis(
                isVisible: true,
                minimum: DateTime(2022, 12, 10, 4, 05,01),
                intervalType: DateTimeIntervalType.seconds,
                desiredIntervals: 60,
                axisLine: AxisLine(width: 0),
                majorGridLines: MajorGridLines(width: 0),
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
                majorGridLines: MajorGridLines(width: 0),
                //Hide the axis line of x-axis
                axisLine: AxisLine(width: 0),
               // desiredIntervals: 200,
              //  interval: 30,
                minimum: 35,
                maximum: 100,

                //    axisLine: const AxisLine(width: 0),
                majorTickLines: const MajorTickLines(size: 0)),
            series: <LineSeries<_ChartData, DateTime>>[
              LineSeries<_ChartData, DateTime>(
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
    listIndex.add(indexoffset);
    indexoffset = indexoffset+1;
    if(typeOfWave.contains("Sinus Rhythm")){
      onGoingWaveForm = "Sinus Rhythm";
      ii_count = listA.length;
      typeCount = a_index;
    }
    else if(typeOfWave.contains("Atrial Flutter")){
      onGoingWaveForm = "Atrial Flutter";
      ii_count = listB.length;
      typeCount = b_index;
    }
    else if(typeOfWave.contains("Fibrillation")){
      onGoingWaveForm = "Fibrillation";
      ii_count = listC.length;
      typeCount = c_index;
    }
    else if(typeOfWave.contains("AV Nodal Tachycardia")){
      onGoingWaveForm = "AV Nodal Tachycardia";
      ii_count = listD.length;
      typeCount = d_index;
    }

    else if(typeOfWave.contains("Ventricular Tachycardia")){
      onGoingWaveForm = "Ventricular Tachycardia";
    ii_count = listE.length;
    typeCount = e_index;
    }
    else if(typeOfWave.contains("First Degree A-V Block")){
      onGoingWaveForm = "First Degree A-V Block";
      ii_count = listF.length;
      typeCount = f_index;
    }
    else if(typeOfWave.contains("Type2-Second Degree A-V Block")){
      onGoingWaveForm = "Type2-Second Degree A-V Block";
      ii_count = listG.length;
      typeCount = g_index;
    }
    else if(typeOfWave.contains("Type1-Second Degree A-V Block")){
      onGoingWaveForm = "Type1-Second Degree A-V Block";
      ii_count = listH.length;
      typeCount = h_index;
    }
    else if(typeOfWave.contains("Third Degree A-V Block")){
      onGoingWaveForm = "Third Degree A-V Block";
      ii_count = listI.length;
      typeCount = i_index;
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

        if(indexoffset<100){
          dt = dt.subtract(Duration(milliseconds: 300));
          dt = dt.add(Duration(milliseconds: 700));
          widget.refreshParent();
        }else{
          dt = dt.add(Duration(milliseconds: 300));
          widget.refreshParent();
        }

      }
      print(" waveform is>>> ${typeOfWave}  Adding index is ${indexoffset} >>>>>>>>>>>>>>>>>> DATE >>>>>>>>>>>>>>>>>>>>>>>>>. ${dt}");

      if(indexoffset<100){
        Overseer.HR = heartRate;

        if(ii==typeCount) {
          print("FB heart rate 1 with normal ${ii} >> ${dt}   --E  data:${heartRate}");
          chartData!.add(new _ChartData(dt, heartRate));
        }else{
          if(listA.length==ii){
            ii=ii-1;
          }
          print("list length is ${listA.length}  and index is ${ii}");
      //    print("${typeOfWave} with normal ${ii} >> ${dt}   --  E data:${listA[ii]}");
          if(typeOfWave.contains("Sinus Rhythm")){
            print("YES YES----less 100---- Sinus Rhythm");
            chartData!.add(new _ChartData(dt, listA[ii]));
          }else if(typeOfWave.contains("Atrial Flutter")) {
            print("YES YES----less 100---- Atrial Flutter");
            chartData!.add(new _ChartData(dt, listB[ii]));
          }else if(typeOfWave.contains("Fibrillation")){
            chartData!.add(new _ChartData(dt, listC[ii]));
          }
          else if(typeOfWave.contains("AV Nodal Tachycardia")){
            chartData!.add(new _ChartData(dt, listD[ii]));
          }else if(typeOfWave.contains("Ventricular Tachycardia")){
            chartData!.add(new _ChartData(dt, listE[ii]));
          }
          else if(typeOfWave.contains("First Degree A-V Block")){
            chartData!.add(new _ChartData(dt, listF[ii]));
          }

          else if(typeOfWave.contains("Type2-Second Degree A-V Block")){
            chartData!.add(new _ChartData(dt, listG[ii]));
          }
      else if(typeOfWave.contains("Type1-Second Degree A-V Block")){
        chartData!.add(new _ChartData(dt, listH[ii]));
      }
          else if(typeOfWave.contains("Third Degree A-V Block")){
            chartData!.add(new _ChartData(dt, listI[ii]));
          }

        }

      }else{
        Overseer.HR = heartRate;
        if(ii==typeCount) {
          print(" FB heart rate 2 is ${heartRate}");
          chartData!.add(new _ChartData(dt, heartRate));
        }else{
          if(listA.length==ii){
            ii=ii-1;
          }
          print(" waveform is ${typeOfWave} ");
          if(typeOfWave.contains("Sinus Rhythm")){
            print("YES YES----less 100---- Sinus Rhythm");
            chartData!.add(new _ChartData(dt, listA[ii]));
          }else if(typeOfWave.contains("Atrial Flutter")) {
            print("YES YES----less 100---- Atrial Flutter");
            chartData!.add(new _ChartData(dt, listB[ii]));
          }else if(typeOfWave.contains("Fibrillation")){
            chartData!.add(new _ChartData(dt, listC[ii]));
          }
          else if(typeOfWave.contains("AV Nodal Tachycardia")){
            chartData!.add(new _ChartData(dt, listD[ii]));
          }else if(typeOfWave.contains("Ventricular Tachycardia")){
            chartData!.add(new _ChartData(dt, listE[ii]));
          }
          else if(typeOfWave.contains("First Degree A-V Block")){
            chartData!.add(new _ChartData(dt, listF[ii]));
          }
          else if(typeOfWave.contains("Type2-Second Degree A-V Block")){
            chartData!.add(new _ChartData(dt, listG[ii]));
          }
          else if(typeOfWave.contains("Type1-Second Degree A-V Block")){
            chartData!.add(new _ChartData(dt, listH[ii]));
          }
          else if(typeOfWave.contains("Third Degree A-V Block")){
            chartData!.add(new _ChartData(dt, listI[ii]));
          }

        }
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
      if (chartData!.length > 199) {
        print("***************************** yes *********************");
        print("index>  ${index} > ${time} £ is removing at ofo ${chartData!.length - 1}");
        chartData!.removeAt(0);
        _chartSeriesController?.updateDataSource(

          removedDataIndexes: <int>[0],
          addedDataIndexes: <int>[chartData!.length - 2],//
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
      if(!runningWaveForm.contains(onGoingWaveForm)) {
         print("YES CHANGED");
        ii = 0;
      }else {
        print("YES SAME ii=$ii   and j=$j");

        if(typeOfWave.contains("Sinus Rhythm")){
          print(" the real ii is ${ii+1}   real_count_a is ${a_count-1}");
          ii+1 == a_count-1 ? ii = 0 : ii = ii + 1;

        }else if(typeOfWave.contains("Atrial Flutter")) {
          print(" the real ii is ${ii+1}   real_count_b is ${b_count-1}");
          ii+1 == b_count-1 ? ii = 0 : ii = ii + 1;
        }else if(typeOfWave.contains("Fibrillation")){
          print(" the real ii is ${ii}   real_count_c is ${c_count-1}");
          ii+1 == c_count-1 ? ii = 0 : ii = ii + 1;
        }
        else if(typeOfWave.contains("AV Nodal Tachycardia")){
          print(" the real ii is ${ii}   real_count_d is ${d_count-1}");
          ii+1 == d_count-1 ? ii = 0 : ii = ii + 1;
        }else if(typeOfWave.contains("Ventricular Tachycardia")){
          print(" the real ii is ${ii}   real_count_e is ${e_count-1}");
          ii+1 == e_count-1 ? ii = 0 : ii = ii + 1;
        }
        else if(typeOfWave.contains("First Degree A-V Block")){
          print(" the real ii is ${ii}   real_count_f is ${f_count-1}");
          ii+1 == f_count-1 ? ii = 0 : ii = ii + 1;
        }
        else if(typeOfWave.contains("Type2-Second Degree A-V Block")){
          print(" the real ii is ${ii}   real_count_g is ${g_count-1}");
          ii+1 == g_count-1 ? ii = 0 : ii = ii + 1;
        }
        else if(typeOfWave.contains("Type1-Second Degree A-V Block")){
          print(" the real ii is ${ii}   real_count_h is ${h_count-1}");
          ii+1 == h_count-1 ? ii = 0 : ii = ii + 1;
        }
        else if(typeOfWave.contains("Third Degree A-V Block")){
          print(" the real ii is ${ii}   real_count_i is ${i_count-1}");
          ii+1 == i_count-1 ? ii = 0 : ii = ii + 1;
        }
      j=ii;
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
