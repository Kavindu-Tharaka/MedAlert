import 'package:MedAlert/db/reports_database.dart';
import 'package:MedAlert/model/sugar_report_database.dart';
import 'package:MedAlert/screens/report_screens/sugar_report_screen.dart';
import 'package:flutter/material.dart';

class ReportScreen extends StatefulWidget {
  @override
  _ReportScreenState createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  List<Sugar> sugar;

  @override
  void initState() {
    super.initState();
    refresReports();
  }

  refresReports() async {
    this.sugar = await ReportDatabase.instance.readAllSugar();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: ListView(
      padding: EdgeInsets.all(25.0),
      children: <Widget>[
        SizedBox(
            width: double.infinity,
            height: 400.0,
            child: Image.asset(
              'assets\\images\\MedAlert_Logo.png',
              width: 200,
              height: 200,
            )),
        Divider(
          thickness: 0,
          color: Colors.white,
        ),
        SizedBox(
          width: double.infinity,
          child: OutlinedButton(
            onPressed: () {
              print('Received click 11');
            },
            child: const Text('Blood Report'),
          ),
        ),
        Divider(
          thickness: 0,
          color: Colors.white,
        ),
        SizedBox(
          width: double.infinity,
          child: OutlinedButton(
            onPressed: () async {
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(builder: (context) => SugarReportScreen()),
              // );
              await Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => SugarReportScreen()),
              );

              refresReports();
            },
            child: const Text('Sugar Report'),
          ),
        ),
        Divider(
          thickness: 0,
          color: Colors.white,
        ),
        SizedBox(
          width: double.infinity,
          child: OutlinedButton(
            onPressed: () {},
            child: const Text('Colostrol Report'),
          ),
        ),
      ],
    ));
  }
}
