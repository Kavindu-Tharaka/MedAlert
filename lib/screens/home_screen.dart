import 'package:MedAlert/db/database_helper.dart';
import 'package:MedAlert/model/reminder.dart';
import 'package:MedAlert/screens/reminders_tab_screen.dart';
import 'package:flutter/material.dart';
import '../widgets/drawer.dart';
import './tabs_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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

    todayRemindersList.clear();

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
    return Scaffold(
      appBar: AppBar(
        actions: [
          Image.asset(
            'assets\\images\\MedAlert_Logo.png',
            height: 20,
          ),
        ],
      ),
      drawer: AppDrawer(),
      body: SingleChildScrollView(
        child: (Column(
          children: <Widget>[
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 40),
                    child: Column(
                      children: <Widget>[
                        CircleAvatar(
                          radius: 50,
                          backgroundColor: Colors.white,
                          child: Image.asset('assets\\images\\jona.png'),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 15),
                          child: Text("Ashley"),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Today\'s My Reminders',
                    style: TextStyle(
                        fontWeight: FontWeight.w600, color: Colors.black54),
                  ),
                  Divider(
                    thickness: 2,
                  ),
                  Center(
                    child: isLoading
                        ? CircularProgressIndicator()
                        : todayRemindersList.isEmpty
                            ? Image.asset(
                                'assets\\images\\no_notifications.png',
                                height: 175,
                              )
                            : RefreshIndicator(
                                onRefresh: refreshReminders,
                                child: ListView(
                                  shrinkWrap: true,
                                  children: todayRemindersList
                                      .map((reminder) => ReminderTile(
                                          medicineName: reminder.medicineName,
                                          hour: reminder.hour,
                                          minute: reminder.minute,
                                          isBefore: reminder.isBefore))
                                      .toList(),
                                ),
                              ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('My Members',
                      style: TextStyle(
                          fontWeight: FontWeight.w600, color: Colors.black54)),
                  Divider(
                    thickness: 2,
                  ),
                  InkWell(
                    onTap: () =>
                        Navigator.of(context).pushNamed(TabsScreen.routeName),
                    child: Column(
                      children: <Widget>[
                        CircleAvatar(
                          radius: 30,
                          backgroundColor: Colors.white,
                          child: Image.asset('assets\\images\\jona.png'),
                        ),
                        Text(
                          "Ashely Doe",
                          style: TextStyle(fontSize: 10),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        )),
      ),
    );
  }
}
