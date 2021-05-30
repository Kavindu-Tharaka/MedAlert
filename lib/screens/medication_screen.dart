import 'package:flutter/material.dart';
import 'package:health_care_application/screens/medicine_tab_screen.dart';
import 'package:health_care_application/screens/reminders_tab_screen.dart';

class MedicationScreen extends StatefulWidget {
  @override
  _MedicationScreenState createState() => _MedicationScreenState();
}

class _MedicationScreenState extends State<MedicationScreen> {
  final tab = TabBar(tabs: <Tab>[
    Tab(
      child: Text('Reminders'),
    ),
    Tab(
      child: Text('Medicines'),
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
