import 'package:MedAlert/model/medicine.dart';
import 'package:MedAlert/screens/add_diary.dart';
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
    return Scaffold(
      body: Text('Diary Data Goes Here!'),
            floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => AddDiary()),
          );

        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
