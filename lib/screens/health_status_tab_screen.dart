import 'package:MedAlert/db/database_helper.dart';
import 'package:MedAlert/model/reminder.dart';
import 'package:flutter/material.dart';

class HealthStatusTabScreen extends StatefulWidget {
  @override
  ReminderseTabScreenState createState() => ReminderseTabScreenState();
}

class ReminderseTabScreenState extends State<HealthStatusTabScreen> {
  List<Reminder> reminders;
  List<Reminder> todayRemindersList = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Text('Health Data Goes Here!'));
  }


}
