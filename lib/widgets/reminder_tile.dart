import 'package:flutter/material.dart';

class ReminderTile extends StatefulWidget {
  final String medicineName;
  final String meal;
  final String time;

  @override
  _ReminderTileState createState() => _ReminderTileState();

  const ReminderTile(this.medicineName, this.time, this.meal);
}

class _ReminderTileState extends State<ReminderTile> {
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      margin: EdgeInsets.all(5.0),
      child: InkWell(
          onTap: () {},
          child: Row(
            children: [
              Expanded(
                flex: 35,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(12),
                      bottomLeft: Radius.circular(12),
                    ),
                    color: Colors.teal[300],
                  ),
                  height: 70,
                  child: Center(
                      child: Text(
                    widget.time,
                    style: TextStyle(color: Colors.white, fontSize: 32),
                  )),
                ),
              ),
              Expanded(
                  flex: 65,
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.medicineName,
                          style: TextStyle(fontSize: 20),
                        ),
                        Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 5, vertical: 3),
                          child: Text(
                            widget.meal,
                            style: TextStyle(color: Colors.white, fontSize: 12),
                          ),
                          decoration: BoxDecoration(
                              color: Colors.teal,
                              borderRadius: BorderRadius.circular(10)),
                        )
                      ],
                    ),
                  )),
            ],
          )),
    );
  }
}
