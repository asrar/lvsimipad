import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lvsimipad/real_time_line_chart.dart';
import 'package:lvsimipad/real_time_line_chart2.dart';
import 'package:lvsimipad/real_time_line_chart3.dart';
import 'package:lvsimipad/real_time_line_chart4.dart';
import 'package:lvsimipad/real_time_line_chart5.dart';
import 'AppLayer/Overseer.dart';
import 'AppLayer/Provider.dart' as pro;
import 'Utils/AppImages.dart';
import 'animation_spline_chart.dart';
import 'animation_spline_chart_blue.dart';
import 'animation_spline_chart_yellow.dart';
import 'default_step_line_chart.dart';

 void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner:false,
      title: 'LVAD Simulator',

      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'LVAD Simulator'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return pro.Provider(
        data: Overseer(),
        child: Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
        titleSpacing: 10,
        backgroundColor: Colors.black,
        leadingWidth: 200,
        leading:Image.asset(AppImages.logo),
        actions: [Image.asset(AppImages.cmp_logo)],

      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
                height: 130,
                color: Colors.black,
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                          color: Colors.black, width: double.infinity, child: LiveLineChart(refreshParent: refresh)),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Container(
                        width: 70,
                        //   color: Colors.black,
                        child: Column(
                          children: [
                            const Text(
                              "HR",
                              style: (TextStyle(
                                  fontWeight: FontWeight.normal,

                                  fontSize: 16,
                                  color: Colors.yellow)),
                            ),
                            Text(
                              "${Overseer.HR}",
                              style: (const TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 36,
                                  color: Colors.green)),
                            ),
                            Text(
                              "${Overseer.HR_speedTime}",
                              style: (const TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 22,
                                  color: Colors.green)),
                            ),
                          ],
                        )),
                  ],
                )),
            Container(
                height: 130,
                color: Colors.black,
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                          color: Colors.black,
                          width: double.infinity,
                          child: LiveLineChart2(refreshParent: refresh2,)),
                    ),
                    const SizedBox(
                      width: 2,
                    ),
                    Container(
                        width: 80,
                        //   color: Colors.black,
                        child: Column(
                          children: [
                            Text(
                              "${Overseer.SPO2}",
                              style: (const TextStyle(
                                  fontWeight: FontWeight.normal,

                                  fontSize: 16,
                                  color: Colors.yellow)),
                            ),
                            Text(
                              "${Overseer.SPO2}",
                              style: (const TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 36,
                                  color: Colors.yellow)),
                            ),
                          ],
                        )),
                  ],
                )),
            Container(
                height: 130,
                color: Colors.black,
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                          color: Colors.black,
                          width: double.infinity,
                          child: LiveLineChart3(refreshParent: refresh3,)),
                    ),
                    const SizedBox(
                      width: 2,
                    ),
                    Container(
                        width: 90,
                        //   color: Colors.black,
                        child: Column(
                          children: [
                            Text(
                              "${Overseer.abdia}/${Overseer.absys} " ,
                              style: (const TextStyle(
                                  fontWeight: FontWeight.normal,
                                  fontSize: 16,
                                  color: Colors.yellow)),
                            ),
                            Text(
                              "${Overseer.abdia}/${Overseer.abdia}",
                              style: ( TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 26,
                                  color: Colors.red.shade400)),
                            ),
                          ],
                        )),
                  ],
                )
            ),
            Container(
                height: 130,
                color: Colors.black,
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                          color: Colors.black,
                          width: double.infinity,
                          child: LiveLineChart5(refreshParent: refresh5,)),
                    ),
                    const SizedBox(
                      width: 2,
                    ),
                    Container(
                        width: 90,
                        //   color: Colors.black,
                        child:  Column(
                          children: [
                            const Text(
                              'Lvp',
                              // "${Overseer.ABP_high}/${Overseer.ABP_low}",
                              style: (TextStyle(
                                  fontWeight: FontWeight.normal,

                                  fontSize: 16,
                                  color: Colors.yellow)),
                            ),
                            const Text('Lvp',
                              // "${Overseer.ABP_low}/${Overseer.ABP_high}",
                              style: (TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 30,
                                  color: Colors.green)),
                            ),
                          ],
                        )),
                  ],
                )),
            Container(
                height: 130,
                color: Colors.black,
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                          color: Colors.black,
                          width: double.infinity,
                          child: LiveLineChart4(refreshParent: refresh4,)),
                    ),
                    const SizedBox(
                      width: 2,
                    ),
                    Container(
                        width: 90,
                        //   color: Colors.black,
                        child: Column(
                          children: [
                            const Text(
                              "etCO2",
                              style: (TextStyle(
                                  fontWeight: FontWeight.normal,

                                  fontSize: 16,
                                  color: Colors.yellow)),
                            ),
                            Text(
                              "${Overseer.RESP}",
                              style: (const TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 36,
                                  color: Colors.white)),
                            ),
                          ],
                        )),
                  ],
                )),
          ],
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    ));
  }

  refresh() {
      print("setting state only for activity Log  at");
      setState(() {
        print("refresh 1 called");
      });
  }
  refresh2() {
    print("setting state only for activity Log  at");
    setState(() {
      print("refresh 2 called");
    });
  }
  refresh3() {
    print("setting state only for activity Log  at");
    setState(() {
      print("refresh 3 called");
    });
  }
  refresh5() {
    print("setting state only for activity Log  at");
    setState(() {
      print("refresh 5 called");
    });
  }
  refresh4() {
    print("setting state only for activity Log  at");
    setState(() {
      print("refresh 3 called");
    });
  }


  refreshStepLine() {
    print("setting state only for activity Log  at");
    setState(() {
      print("refreshStepLine  3 called");
    });
  }
}
