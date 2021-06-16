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
          title: const Text('Delete Record'),
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
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Row(
            children: [
              Expanded(
                flex: 3,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(12),
                      bottomLeft: Radius.circular(12),
                    ),
                    color: Color(0XFF008bb0),
                  ),
                  height: 150,
                ),
              ),
              Expanded(
                  flex: 97,
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          diary.date.split(' ')[0],
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'RobotoCondensed-Bold'),
                        ),
                        Text(
                          diary.date.split(' ')[1].split('.')[0],
                          style: TextStyle(fontSize: 12),
                        ),
                        Divider(),
                        Container(
                          height: 75,
                          child: Text(
                            diary.diary,
                            style:
                                TextStyle(color: Colors.black54, fontSize: 14),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 4,
                          ),
                        )
                      ],
                    ),
                  )),
            ],
          )),
    );
  }
}
