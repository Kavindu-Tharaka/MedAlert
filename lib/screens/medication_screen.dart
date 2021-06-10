import 'package:MedAlert/screens/medicine_tab_screen.dart';
import 'package:MedAlert/screens/reminders_tab_screen.dart';
import 'package:flutter/material.dart';

class MedicationScreen extends StatefulWidget {
  @override
  _MedicationScreenState createState() => _MedicationScreenState();
}

class _MedicationScreenState extends State<MedicationScreen> {
  final tab = TabBar(tabs: <Tab>[
    Tab(
      child: Text(
        'Upcoming Reminders',
        style: TextStyle(color: Colors.grey[700]),
      ),
    ),
    Tab(
      child: Text(
        'My Medicines',
        style: TextStyle(color: Colors.grey[700]),
      ),
    ),
  ]);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(50.0),
            child: AppBar(
              bottom: tab,
            ),
          ),
          body: TabBarView(
            children: [RemindersTabScreen(), MedicinesTabScreen()],
          ),
        ));
  }
}
