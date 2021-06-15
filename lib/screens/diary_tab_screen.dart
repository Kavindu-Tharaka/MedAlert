import 'package:MedAlert/model/medicine.dart';
import 'package:flutter/material.dart';

class DiaryTabScreen extends StatefulWidget {
  @override
  _DiaryTabScreenState createState() => _DiaryTabScreenState();
}

class _DiaryTabScreenState extends State<DiaryTabScreen> {
  List<Medicine> medicines;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Text('Diary Data Goes Here!'));
  }
}
