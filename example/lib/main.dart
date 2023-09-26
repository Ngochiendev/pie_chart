import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:pie_chart_flutter/pie_chart.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Pie Chart Demo',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      darkTheme: ThemeData(
        primarySwatch: Colors.blueGrey,
        brightness: Brightness.dark,
      ),
      home: const HomePage(),
    );
  }
}

enum LegendShape { circle, rectangle }

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  final dataMap = <String, double>{
    "Flutter": 25,
    "React": 3,
    "Xamarin": 2,
    "Ionic": 2,
  };

  final colorList = <Color>[
    const Color(0xfffdcb6e),
    const Color(0xff0984e3),
    const Color(0xfffd79a8),
    const Color(0xffe17055),
    const Color(0xff6c5ce7),
  ];

  final ChartType _chartType = ChartType.disc;
  final double _ringStrokeWidth = 32;
  final double _chartLegendSpacing = 32;

  final bool _showLegendsInRow = true;
  final bool _showLegends = true;

  final bool _showChartValueBackground = true;
  final bool _showChartValues = true;
  final bool _showChartValuesInPercentage = false;
  final bool _showChartValuesOutside = false;

  final LegendPosition _legendPosition = LegendPosition.bottom;

  int key = 0;

  @override
  Widget build(BuildContext context) {
    final chart = PieChart(
      key: ValueKey(key),
      dataMap: dataMap,
      animationDuration: const Duration(milliseconds: 1000),
      chartLegendSpacing: _chartLegendSpacing,
      chartRadius: math.min(MediaQuery.of(context).size.width / 2.5, 500),
      colorList: colorList,
      initialAngleInDegree: 0,
      chartType: _chartType,
      legendOptions: LegendOptions(
        showLegendsInRow: _showLegendsInRow,
        legendPosition: _legendPosition,
        showLegends: _showLegends,
        legendShape: BoxShape.circle,
        legendTextStyle: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      chartValuesOptions: ChartValuesOptions(
        showChartValueBackground: _showChartValueBackground,
        showChartValues: _showChartValues,
        showChartValuesInPercentage: _showChartValuesInPercentage,
        showChartValuesOutside: _showChartValuesOutside,
      ),
      ringStrokeWidth: _ringStrokeWidth,
      emptyColor: Colors.grey,
      baseChartColor: Colors.transparent,
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text("Pie Chart"),
        // actions: [
        //   ElevatedButton(
        //     onPressed: () {
        //       setState(() {
        //         key = key + 1;
        //       });
        //     },
        //     child: Text("Reload".toUpperCase()),
        //   ),
        // ],
      ),
      body: LayoutBuilder(
        builder: (_, constraints) {
          if (constraints.maxWidth >= 800) {
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flexible(
                  flex: 3,
                  fit: FlexFit.tight,
                  child: chart,
                ),
              ],
            );
          } else {
            return SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(
                      vertical: 32,
                    ),
                    child: chart,
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
