import 'package:MedAlert/screens/diary_tab_screen.dart';
import 'package:MedAlert/screens/health_status_tab_screen.dart';
import 'package:flutter/material.dart';

class DiaryScreen extends StatefulWidget {
  @override
  _DiaryScreenState createState() => _DiaryScreenState();
}

class _DiaryScreenState extends State<DiaryScreen> {
  final tab = TabBar(tabs: <Tab>[
    Tab(
      child: Text(
        'Diary',
        style: TextStyle(color: Colors.grey[700]),
      ),
    ),
    Tab(
      child: Text(
        'My Health',
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
            children: [DiaryTabScreen(), HealthStatusTabScreen()],
          ),
        ));
  }
}
