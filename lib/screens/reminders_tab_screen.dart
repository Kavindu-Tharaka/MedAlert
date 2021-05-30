import 'package:flutter/material.dart';
import 'package:health_care_application/widgets/reminder_tile.dart';

class RemindersTabScreen extends StatefulWidget {
  @override
  ReminderseTabScreenState createState() => ReminderseTabScreenState();
}

class ReminderseTabScreenState extends State<RemindersTabScreen> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 15, 10, 0),
      child: ListView(
        children: [
          ReminderTile('Kalzana', '11:40', 'Before Meal'),
          ReminderTile('Vitamin C', '15:40', 'Before Meal'),
          ReminderTile('Domperidone', '20:20', 'Before Meal'),
          ReminderTile('Metphomine', '08:30', 'Before Meal'),
          ReminderTile('Amoxyline', '11:40', 'Before Meal'),
          ReminderTile('Glymperide', '11:40', 'Before Meal'),
          ReminderTile('Albandozole', '11:40', 'Before Meal'),
          ReminderTile('Piriton', '11:40', 'Before Meal'),
        ],
      ),
    );
  }
}

// class ReminderTile extends StatelessWidget {

//   const ReminderTile(
//     String medicineName, {
//     Key key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: ;
//   }
// }
