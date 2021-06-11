import 'package:MedAlert/db/reports_database.dart';
import 'package:MedAlert/model/sugar_report_database.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'add_sugar_screen.dart';

class SugarReportScreen extends StatefulWidget {
  @override
  _SugarReportScreenState createState() => _SugarReportScreenState();
}

class _SugarReportScreenState extends State<SugarReportScreen> {
  final DateFormat _dateFormatter = DateFormat('MM dd, yyyy');

  List<Sugar> sugarList;

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _updateSugarReports();
  }

  // @override
  // void dispose() {
  //   ReportDatabase.instance.close();

  //   super.dispose();
  // }

  Future _updateSugarReports() async {
    setState(() => isLoading = true);
    this.sugarList = await ReportDatabase.instance.readAllSugar();
    setState(() => isLoading = false);
  }

  Widget _buildTask(int index) {
    final sugarItem = sugarList[index];

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 25.0),
      child: Column(
        children: [
          ListTile(
            title: Text(
                'Sugar Level Fasting           - ${sugarItem.sugarLevelF}  mgs/dl\nSugar Level Postprandial  - ${sugarItem.sugarLevelPP} mgs/dl'),
            subtitle: Text('${_dateFormatter.format(sugarItem.reportDate)}'),
            trailing: IconButton(
              icon: const Icon(Icons.delete),
              color: Theme.of(context).accentColor,
              onPressed: () {
                ReportDatabase.instance.delete(sugarItem.id);
                _updateSugarReports();
              },
            ),
            onTap: () => {
              //for update the current report
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => AddSugarReportScreen(
                            updateSugarReports: _updateSugarReports,
                            sugar: sugarItem,
                          )))
            },
          ),
          Divider(),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Sugar'),

        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Theme.of(context).accentColor,
          child: Icon(Icons.add),
          onPressed: () => {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => AddSugarReportScreen(
                    updateSugarReports: _updateSugarReports),
              ),
            )
          },
        ),
        body: isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : ListView.builder(
                padding: EdgeInsets.symmetric(vertical: 80.0),
                itemCount: sugarList.length + 1,
                itemBuilder: (BuildContext context, int index) {
                  if (index == 0) {
                    return Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 40.0, vertical: 20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'My Blood Sugar Reports',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 40.0,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 10.0),
                          Text(
                            '${sugarList.length} total records are available',
                            style: TextStyle(
                                color: Colors.grey,
                                fontSize: 20.0,
                                fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    );
                  }
                  return _buildTask(index - 1);
                },
              ));
  }
}
