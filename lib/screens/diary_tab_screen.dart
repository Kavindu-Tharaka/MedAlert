import 'package:MedAlert/db/database_helper.dart';
import 'package:MedAlert/model/diary.dart';
import 'package:MedAlert/screens/add_diary.dart';
import 'package:flutter/material.dart';

class DiaryTabScreen extends StatefulWidget {
  @override
  _DiaryTabScreenState createState() => _DiaryTabScreenState();
}

class _DiaryTabScreenState extends State<DiaryTabScreen> {
  List<Diary> diaries;
  bool isLoading = false;

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
      body: Padding(
        padding: const EdgeInsets.fromLTRB(10, 15, 10, 0),
        child: Center(
          child: isLoading
              ? CircularProgressIndicator()
              : diaries.isEmpty
                  ? Image.asset(
                      'assets\\images\\no_diaries.png',
                      height: 200,
                    )
                  : RefreshIndicator(
                      onRefresh: refreshDiaries,
                      child: ListView(
                        children: diaries
                            .map((diary) => DiaryTile(diary, refreshDiaries))
                            .toList(),
                      ),
                    ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => AddDiary()),
          );

          refreshDiaries();
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}

class DiaryTile extends StatelessWidget {
  final Diary diary;
  final refreshMethod;

  DiaryTile(this.diary, this.refreshMethod);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onLongPress: () => showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Delete Member'),
          content: Text("Do you want to delete this record"),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context, 'Cancel'),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () async => {
                await MedicineDatabase.instance.deleteDiary(diary.id),
                refreshMethod(),
                Navigator.pop(context, "Delete")
              },
              child: const Text('Delete'),
            ),
          ],
        ),
      ),
      child: Card(
        child: InkWell(
          splashColor: Colors.blue.withAlpha(30),
          onTap: () {
            print('Card tapped.');
          },
          child: SizedBox(
            width: 300,
            height: 100,
            child: Text(diary.diary),
          ),
        ),
      ),
    );
  }
}
