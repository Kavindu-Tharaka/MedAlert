import 'package:MedAlert/db/database_helper.dart';
import 'package:MedAlert/model/diary.dart';
import 'package:MedAlert/model/reminder.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';

class HealthStatusTabScreen extends StatefulWidget {
  @override
  HealthStatusTabScreenState createState() => HealthStatusTabScreenState();
}

class HealthStatusTabScreenState extends State<HealthStatusTabScreen> {
  List<Diary> diaries;
  //List<HealthData> chartData;
  bool isLoading = false;

  List<ChartSampleData> chartData = <ChartSampleData>[
    ChartSampleData(x: DateTime(2015, 1, 1, 0), yValue: 3),
    ChartSampleData(x: DateTime(2015, 1, 2, 2), yValue: 3),
    ChartSampleData(x: DateTime(2015, 1, 3, 3), yValue: 4),
    ChartSampleData(x: DateTime(2015, 1, 4, 4), yValue: 5),
    ChartSampleData(x: DateTime(2015, 1, 5, 5), yValue: 5),
    ChartSampleData(x: DateTime(2015, 1, 6, 6), yValue: 4),
    ChartSampleData(x: DateTime(2015, 1, 7, 7), yValue: 3),
    ChartSampleData(x: DateTime(2015, 1, 8, 8), yValue: 5),
    ChartSampleData(x: DateTime(2015, 1, 9, 9), yValue: 5),
    ChartSampleData(x: DateTime(2015, 1, 10, 10), yValue: 5),
  ];

  @override
  void initState() {
    super.initState();
    refreshDiaries();
  }

  Future refreshDiaries() async {
    setState(() => isLoading = true);
    this.diaries = await MedicineDatabase.instance.readAllDiaries();
    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      //Initialize the chart widget
      child: Container(
          height: 500,
          width: 320,
          child: SfCartesianChart(
              backgroundColor: Colors.white,
              //Specifying date time interval type as hours
              primaryXAxis: DateTimeAxis(
                  majorGridLines: MajorGridLines(width: 0),
                  edgeLabelPlacement: EdgeLabelPlacement.shift,
                  intervalType: DateTimeIntervalType.hours),
              series: <ChartSeries<ChartSampleData, DateTime>>[
                SplineSeries<ChartSampleData, DateTime>(
                  dataSource: chartData,
                  xValueMapper: (ChartSampleData sales, _) => sales.x,
                  yValueMapper: (ChartSampleData sales, _) => sales.yValue,
                  name: 'Sales',
                )
              ])),
    ));
  }
}

class ChartSampleData {
  ChartSampleData({this.x, this.yValue});

  final DateTime x;
  final double yValue;
}
