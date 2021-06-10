import 'package:MedAlert/db/database_helper.dart';
import 'package:MedAlert/model/medicine.dart';
import 'package:MedAlert/notifications/local_notification.dart';
import 'package:flutter/material.dart';


class AddMedicinePage extends StatefulWidget {
  final Medicine medicine;

  const AddMedicinePage({
    Key key,
    this.medicine,
  }) : super(key: key);

  @override
  _AddMedicinePageState createState() => _AddMedicinePageState();
}

class _AddMedicinePageState extends State<AddMedicinePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.fromLTRB(
                  MediaQuery.of(context).size.width / 15,
                  MediaQuery.of(context).size.height / 30,
                  MediaQuery.of(context).size.width / 15,
                  MediaQuery.of(context).size.height / 15),
              child: MyCustomForm(),
            ),
          ],
        ),
      ),
    );
  }
}

class MyCustomForm extends StatefulWidget {
  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}

class MyCustomFormState extends State<MyCustomForm> {
  final _formKey = GlobalKey<FormState>();

  int numOfVisibileReminders = 1;
  bool isBefore = false;
  int temp = 1;

  TextEditingController medicineNameController = TextEditingController();
  TextEditingController amountUnitController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  TextEditingController dosageAmountController = TextEditingController();
  TextEditingController isBeforeController = TextEditingController();
  TextEditingController timesPerDayController = TextEditingController();

  onNotificationReceive(ReceiveNotification notification) {
    print('Notification Received:  ${notification.id}');
  }

  onNotificationClick(String payload) async {
    print('Payload: $payload');

    final medicineObj =
        await MedicineDatabase.instance.readMedicine(int.tryParse(payload));

    int count =
        await MedicineDatabase.instance.reduceMedicineCount(medicineObj);

    if (count > 0) {
      print('reduced $count');
    }
  }

  @override
  void initState() {
    localNotification.setOnNotificationReceiveMethod(onNotificationReceive);
    localNotification.setOnNotificationClickMethod(onNotificationClick);

    isBefore = false;
    numOfVisibileReminders = 1;
    amountUnitController.text = 'count';

    //////////////////////////////
    medicineNameController.text = 'Kalzana';
    amountController.text = '35';
    dosageAmountController.text = '2';
    /////////////////////////////

    super.initState();
  }

  @override
  void dispose() {
    medicineNameController.dispose();
    amountController.dispose();
    dosageAmountController.dispose();
    amountUnitController.dispose();
    isBeforeController.dispose();
    timesPerDayController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          buildMedicineName(),
          SizedBox(height: 20),
          buildAmount(),
          SizedBox(height: 20),
          buildDosageAmount(),
          SizedBox(height: 10),
          buildBeforeAfter(),
          SizedBox(height: 10),
          buildNumbersPerDay(),
          SizedBox(height: 20),
          FlatButton(onPressed: () {}, child: Text('Add'))
        ],
      ),
    );
  }

  Widget buildMedicineName() => TextFormField(
        onEditingComplete: () {
          FocusScope.of(context).nextFocus();
        },
        autofocus: false,
        controller: medicineNameController,
        maxLines: 1,
        keyboardType: TextInputType.text,
        style: TextStyle(
          color: Colors.black87,
          fontWeight: FontWeight.bold,
          fontSize: 15,
        ),
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(10.0),
          labelText: 'Medicine Name',
          labelStyle: TextStyle(
            fontSize: 15,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(40),
            borderSide:
                BorderSide(color: Colors.black, style: BorderStyle.solid),
          ),
          hintText: 'Medicine Name',
          hintStyle: TextStyle(color: Colors.white70),
        ),
        validator: (value) {
          if (value.isEmpty) {
            return 'Can not be empty!';
          }
          return null;
        },
      );

  Widget buildAmount() => Row(
        children: [
          Expanded(
            flex: 65,
            child: TextFormField(
              onEditingComplete: () {
                FocusScope.of(context).nextFocus();
              },
              autofocus: false,
              controller: amountController,
              maxLines: 1,
              keyboardType: TextInputType.number,
              style: TextStyle(
                color: Colors.black87,
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.all(10.0),
                labelText: 'Total Amount',
                labelStyle: TextStyle(
                  fontSize: 15,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(40),
                  borderSide:
                      BorderSide(color: Colors.black, style: BorderStyle.solid),
                ),
                hintText: 'Total Amount',
                hintStyle: TextStyle(color: Colors.white70),
              ),
              validator: (value) {
                if (value.isEmpty) {
                  return 'Can not be empty or zero!';
                }
                return null;
              },
            ),
          ),
          Expanded(
              flex: 5,
              child: SizedBox(
                width: 1,
              )),
          Expanded(
              flex: 30,
              child: DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(10.0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(40),
                    borderSide: BorderSide(
                        color: Colors.black, style: BorderStyle.solid),
                  ),
                ),
                isExpanded: true,
                value: 'count',
                onChanged: (String values) {
                  setState(() {
                    amountUnitController.text = values;
                  });
                },
                items: ['ml', 'count']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ))
        ],
      );

  Widget buildDosageAmount() => Row(
        children: [
          Expanded(
            flex: 65,
            child: TextFormField(
              onEditingComplete: () {
                FocusScope.of(context).nextFocus();
              },
              autofocus: false,
              controller: dosageAmountController,
              maxLines: 1,
              keyboardType: TextInputType.number,
              style: TextStyle(
                color: Colors.black87,
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.all(10.0),
                labelText: 'Dosage Amount',
                labelStyle: TextStyle(
                  fontSize: 15,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(40),
                  borderSide:
                      BorderSide(color: Colors.black, style: BorderStyle.solid),
                ),
                hintText: 'Dosage Amount',
                hintStyle: TextStyle(color: Colors.white70),
              ),
              validator: (value) {
                if (value.isEmpty) {
                  return 'Can not be empty or zero!';
                }
                return null;
              },
            ),
          ),
          Expanded(
              flex: 5,
              child: SizedBox(
                width: 1,
              )),
          Expanded(
              flex: 30,
              child: DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(10.0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(40),
                    borderSide: BorderSide(
                        color: Colors.black, style: BorderStyle.solid),
                  ),
                ),
                isExpanded: true,
                value: 'count',
                onChanged: (String values) {
                  setState(() {
                    amountUnitController.text = values;
                  });
                },
                items: ['ml', 'count']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ))
        ],
      );

  Widget buildBeforeAfter() => Container(
        child: Column(
          children: <Widget>[
            Container(
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Expanded(
                        flex: 1,
                        child: RadioListTile(
                          contentPadding: EdgeInsets.all(0.1),
                          value: false,
                          groupValue: isBefore,
                          title: Text(
                            "After Meal",
                            style: TextStyle(fontSize: 15),
                          ),
                          onChanged: (bool value) {
                            setState(() {
                              isBefore = value;
                            });
                          },
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: RadioListTile(
                          contentPadding: EdgeInsets.all(0.1),
                          value: true,
                          groupValue: isBefore,
                          title: Text(
                            "Before Meal",
                            style: TextStyle(fontSize: 15),
                          ),
                          onChanged: (bool value) {
                            setState(() {
                              isBefore = value;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      );

  Widget buildNumbersPerDay() => Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 10, 0, 0),
              child: Text('Times per Day'),
            ),
            Container(
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Expanded(
                        flex: 1,
                        child: RadioListTile(
                          contentPadding: EdgeInsets.all(0.1),
                          value: 1,
                          groupValue: numOfVisibileReminders,
                          title: Text(
                            "1",
                            style: TextStyle(fontSize: 15),
                          ),
                          onChanged: (int value) {
                            numOfVisibileReminders = value;
                            setState(() {
                              ++temp;
                            });
                          },
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: RadioListTile(
                          contentPadding: EdgeInsets.all(0.1),
                          value: 2,
                          groupValue: numOfVisibileReminders,
                          title: Text(
                            "2",
                            style: TextStyle(fontSize: 15),
                          ),
                          onChanged: (int value) {
                            numOfVisibileReminders = value;
                            setState(() {
                              ++temp;
                            });
                          },
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: RadioListTile(
                          contentPadding: EdgeInsets.all(0.1),
                          value: 3,
                          groupValue: numOfVisibileReminders,
                          title: Text(
                            "3",
                            style: TextStyle(fontSize: 15),
                          ),
                          onChanged: (int value) {
                            numOfVisibileReminders = value;
                            setState(() {
                              ++temp;
                            });
                          },
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: RadioListTile(
                          contentPadding: EdgeInsets.all(0.1),
                          value: 4,
                          groupValue: numOfVisibileReminders,
                          title: Text(
                            "4",
                            style: TextStyle(fontSize: 15),
                          ),
                          onChanged: (int value) {
                            numOfVisibileReminders = value;
                            setState(() {
                              ++temp;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      );
}
