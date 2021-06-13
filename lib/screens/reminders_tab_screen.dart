import 'package:MedAlert/db/database_helper.dart';
import 'package:MedAlert/model/reminder.dart';
import 'package:flutter/material.dart';

class RemindersTabScreen extends StatefulWidget {
  @override
  ReminderseTabScreenState createState() => ReminderseTabScreenState();
}

class ReminderseTabScreenState extends State<RemindersTabScreen> {
  List<Reminder> reminders;
  List<Reminder> todayRemindersList = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    refreshReminders();
  }

  Future refreshReminders() async {
    setState(() => isLoading = true);

    this.reminders = await MedicineDatabase.instance.readAllReminders();

    reminders.forEach((reminder) {
      if (reminder.monday && DateTime.now().weekday == DateTime.monday) {
        if (reminder.hour > DateTime.now().hour) {
          todayRemindersList.add(reminder);
        } else if (reminder.hour == DateTime.now().hour &&
            reminder.minute >= DateTime.now().minute) {
          todayRemindersList.add(reminder);
        }
      }
      if (reminder.tuesday && DateTime.now().weekday == DateTime.tuesday) {
        if (reminder.hour > DateTime.now().hour) {
          todayRemindersList.add(reminder);
        } else if (reminder.hour == DateTime.now().hour &&
            reminder.minute >= DateTime.now().minute) {
          todayRemindersList.add(reminder);
        }
      }
      if (reminder.wednesday && DateTime.now().weekday == DateTime.wednesday) {
        if (reminder.hour > DateTime.now().hour) {
          todayRemindersList.add(reminder);
        } else if (reminder.hour == DateTime.now().hour &&
            reminder.minute >= DateTime.now().minute) {
          todayRemindersList.add(reminder);
        }
      }
      if (reminder.thursday && DateTime.now().weekday == DateTime.thursday) {
        if (reminder.hour > DateTime.now().hour) {
          todayRemindersList.add(reminder);
        } else if (reminder.hour == DateTime.now().hour &&
            reminder.minute >= DateTime.now().minute) {
          todayRemindersList.add(reminder);
        }
      }
      if (reminder.friday && DateTime.now().weekday == DateTime.friday) {
        if (reminder.hour > DateTime.now().hour) {
          todayRemindersList.add(reminder);
        } else if (reminder.hour == DateTime.now().hour &&
            reminder.minute >= DateTime.now().minute) {
          todayRemindersList.add(reminder);
        }
      }
      if (reminder.saturday && DateTime.now().weekday == DateTime.saturday) {
        if (reminder.hour > DateTime.now().hour) {
          todayRemindersList.add(reminder);
        } else if (reminder.hour == DateTime.now().hour &&
            reminder.minute >= DateTime.now().minute) {
          todayRemindersList.add(reminder);
        }
      }
      if (reminder.sunday && DateTime.now().weekday == DateTime.sunday) {
        if (reminder.hour > DateTime.now().hour) {
          todayRemindersList.add(reminder);
        } else if (reminder.hour == DateTime.now().hour &&
            reminder.minute >= DateTime.now().minute) {
          todayRemindersList.add(reminder);
        }
      }
    });

    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.fromLTRB(10, 15, 10, 0),
        child: Center(
          child: isLoading
              ? CircularProgressIndicator()
              : todayRemindersList.isEmpty
                  ? Text(
                      'No More Reminders For Today',
                      style: TextStyle(color: Colors.black, fontSize: 24),
                    )
                  : ListView(
                      children: todayRemindersList
                          .map((reminder) => ReminderTile(
                              medicineName: reminder.medicineName,
                              hour: reminder.hour,
                              minute: reminder.minute,
                              isBefore: reminder.isBefore))
                          .toList(),
                    ),
        ));
  }
}

class ReminderTile extends StatelessWidget {
  final String medicineName;
  final int hour;
  final int minute;
  final bool isBefore;

  ReminderTile({this.medicineName, this.hour, this.minute, this.isBefore});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
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
                      '${this.hour > 9 ? this.hour : '0${this.hour}'}:${this.minute > 9 ? this.minute : '0${this.minute}'}',
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
                            this.medicineName,
                            style: TextStyle(fontSize: 20),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 5, vertical: 3),
                            child: Text(
                              this.isBefore ? 'Before Meal' : 'After Meal',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 12),
                            ),
                            decoration: BoxDecoration(
                                color: this.isBefore
                                    ? Colors.teal
                                    : Colors.blueAccent,
                                borderRadius: BorderRadius.circular(10)),
                          )
                        ],
                      ),
                    )),
              ],
            )),
      ),
    );
  }
}
