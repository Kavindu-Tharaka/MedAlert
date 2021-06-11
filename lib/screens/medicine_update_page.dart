import 'package:MedAlert/db/database_helper.dart';
import 'package:MedAlert/model/medicine.dart';
import 'package:MedAlert/model/reminder.dart';
import 'package:MedAlert/notifications/local_notification.dart';
import 'package:colorlizer/colorlizer.dart';
import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';

class MedicineUpdatePage extends StatefulWidget {
  static const routeName = '/update-medicine';

  @override
  _MedicineUpdatePageState createState() => _MedicineUpdatePageState();
}

class _MedicineUpdatePageState extends State<MedicineUpdatePage> {
  // int id;
  // String name;
  // int amount;
  // int dosageAmount;
  // String amountUnit;
  // bool isBefore;
  // int timesPerDay;

  @override
  Widget build(BuildContext context) {
    // final List args = ModalRoute.of(context).settings.arguments;

    // id = args[0];
    // name = args[1];
    // amount = args[2];
    // dosageAmount = args[3];
    // amountUnit = args[4];
    // isBefore = args[5];
    // timesPerDay = args[6];

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          Image.asset(
            'assets\\images\\MedAlert_Logo.png',
            height: 20,
          ),
        ],
      ),
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
  int id1;

  final _formKey = GlobalKey<FormState>();
  int numOfVisibileReminders;
  bool isBefore;
  int temp = 1;

  int hourOne = 13;
  int minuteOne = 30;
  bool isAllDaysCheckedOne = false;
  bool isMondayCheckedOne = false;
  bool isTuesdayCheckedOne = false;
  bool isWednesdayCheckedOne = false;
  bool isThursdayCheckedOne = false;
  bool isFridayCheckedOne = false;
  bool isSaturdaydayCheckedOne = false;
  bool isSundayCheckedOne = false;
  bool isReminderOneVisible = true;

  int hourTwo = 13;
  int minuteTwo = 30;
  bool isAllDaysCheckedTwo = false;
  bool isMondayCheckedTwo = false;
  bool isTuesdayCheckedTwo = false;
  bool isWednesdayCheckedTwo = false;
  bool isThursdayCheckedTwo = false;
  bool isFridayCheckedTwo = false;
  bool isSaturdaydayCheckedTwo = false;
  bool isSundayCheckedTwo = false;
  bool isReminderTwoVisible = false;

  int hourThree = 13;
  int minuteThree = 30;
  bool isAllDaysCheckedThree = false;
  bool isMondayCheckedThree = false;
  bool isTuesdayCheckedThree = false;
  bool isWednesdayCheckedThree = false;
  bool isThursdayCheckedThree = false;
  bool isFridayCheckedThree = false;
  bool isSaturdaydayCheckedThree = false;
  bool isSundayCheckedThree = false;
  bool isReminderThreeVisible = false;

  int hourFour = 13;
  int minuteFour = 30;
  bool isAllDaysCheckedFour = false;
  bool isMondayCheckedFour = false;
  bool isTuesdayCheckedFour = false;
  bool isWednesdayCheckedFour = false;
  bool isThursdayCheckedFour = false;
  bool isFridayCheckedFour = false;
  bool isSaturdaydayCheckedFour = false;
  bool isSundayCheckedFour = false;
  bool isReminderFourVisible = false;

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
    super.initState();
  }

  @override
  void didChangeDependencies() {
    final List args = ModalRoute.of(context).settings.arguments;

    id1 = args[0];

    medicineNameController.text = args[1];
    amountController.text = args[2].toString();
    dosageAmountController.text = args[3].toString();
    amountUnitController.text = args[4];
    isBefore = args[5];
    numOfVisibileReminders = args[6];

    if (numOfVisibileReminders == 1) {
      isReminderOneVisible = true;
      isReminderTwoVisible = false;
      isReminderThreeVisible = false;
      isReminderFourVisible = false;
    } else if (numOfVisibileReminders == 2) {
      isReminderOneVisible = true;
      isReminderTwoVisible = true;
      isReminderThreeVisible = false;
      isReminderFourVisible = false;
    } else if (numOfVisibileReminders == 3) {
      isReminderOneVisible = true;
      isReminderTwoVisible = true;
      isReminderThreeVisible = true;
      isReminderFourVisible = false;
    } else if (numOfVisibileReminders == 4) {
      isReminderOneVisible = true;
      isReminderTwoVisible = true;
      isReminderThreeVisible = true;
      isReminderFourVisible = true;
    }

    super.didChangeDependencies();
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
    // final List args = ModalRoute.of(context).settings.arguments;

    // id1 = args[0];

    // medicineNameController.text = args[1];
    // amountController.text = args[2].toString();
    // dosageAmountController.text = args[3].toString();
    // amountUnitController.text = args[4];
    // isBefore = args[5];
    // numOfVisibileReminders = args[6];

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
          buildReminderCardList(),
          SizedBox(height: 20),
          SizedBox(
            width: 150,
            child: ElevatedButton(
                style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                  )),
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Color(0XFF008bb0)),
                ),
                onPressed: () {
                  addMedicineWrapper();
                },
                child: Text('ADD')),
          ),
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
                value: amountUnitController.text,
                onChanged: (String values) {
                  setState(() {
                    amountUnitController.text = values;
                  });
                },
                items: ['ml', 'count']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem(
                    value: value,
                    child: Text(
                      value,
                      style: TextStyle(
                          color: Colors.black54, fontWeight: FontWeight.w600),
                    ),
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
          // Expanded(
          //     flex: 5,
          //     child: SizedBox(
          //       width: 1,
          //     )),
          // Expanded(flex: 30, child: Text(''))
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
                            style: TextStyle(
                                fontSize: 15,
                                color: Colors.black54,
                                fontWeight: FontWeight.w600),
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
                            style: TextStyle(
                                fontSize: 15,
                                color: Colors.black54,
                                fontWeight: FontWeight.w600),
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
              child: Text(
                'Times per Day',
                style: TextStyle(
                    color: Colors.black54, fontWeight: FontWeight.w600),
              ),
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
                          title: Text("1",
                              style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.black54,
                                  fontWeight: FontWeight.w600)),
                          onChanged: (int value) {
                            numOfVisibileReminders = value;

                            isReminderOneVisible = true;
                            isReminderTwoVisible = false;
                            isReminderThreeVisible = false;
                            isReminderFourVisible = false;
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
                          title: Text("2",
                              style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.black54,
                                  fontWeight: FontWeight.w600)),
                          onChanged: (int value) {
                            numOfVisibileReminders = value;

                            isReminderOneVisible = true;
                            isReminderTwoVisible = true;
                            isReminderThreeVisible = false;
                            isReminderFourVisible = false;
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
                          title: Text("3",
                              style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.black54,
                                  fontWeight: FontWeight.w600)),
                          onChanged: (int value) {
                            numOfVisibileReminders = value;

                            isReminderOneVisible = true;
                            isReminderTwoVisible = true;
                            isReminderThreeVisible = true;
                            isReminderFourVisible = false;
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
                          title: Text("4",
                              style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.black54,
                                  fontWeight: FontWeight.w600)),
                          onChanged: (int value) {
                            numOfVisibileReminders = value;

                            isReminderOneVisible = true;
                            isReminderTwoVisible = true;
                            isReminderThreeVisible = true;
                            isReminderFourVisible = true;
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

  Widget buildReminderCardList() => ListView(
        shrinkWrap: true,
        children: [
          Visibility(
            visible: isReminderOneVisible,
            child: Container(
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          NumberPicker(
                            textStyle: TextStyle(color: Colors.black38),
                            selectedTextStyle: TextStyle(
                                fontSize: 30, color: Color(0XFF008bb0)),
                            itemHeight: 40,
                            itemWidth: 35,
                            value: hourOne,
                            minValue: 00,
                            maxValue: 23,
                            onChanged: (value) =>
                                setState(() => hourOne = value),
                          ),
                          Text(
                            ' : ',
                            style: TextStyle(
                                fontSize: 30, color: Color(0XFF008bb0)),
                          ),
                          NumberPicker(
                            textStyle: TextStyle(color: Colors.black38),
                            selectedTextStyle: TextStyle(
                                fontSize: 30, color: Color(0XFF008bb0)),
                            itemHeight: 40,
                            itemWidth: 35,
                            value: minuteOne,
                            minValue: 00,
                            maxValue: 59,
                            onChanged: (value) =>
                                setState(() => minuteOne = value),
                          ),
                        ],
                      ),
                      Divider(),
                      Column(
                        children: [
                          CheckboxListTile(
                            title: Text('All Days'),
                            value: isAllDaysCheckedOne,
                            onChanged: (bool value) {
                              setState(() {
                                isAllDaysCheckedOne = value;
                                isMondayCheckedOne = value;
                                isTuesdayCheckedOne = value;
                                isWednesdayCheckedOne = value;
                                isThursdayCheckedOne = value;
                                isFridayCheckedOne = value;
                                isSaturdaydayCheckedOne = value;
                                isSundayCheckedOne = value;
                              });
                            },
                          ),
                          CheckboxListTile(
                            title: Text('Monday'),
                            value: isMondayCheckedOne,
                            onChanged: (bool value) {
                              setState(() {
                                isMondayCheckedOne = value;
                              });
                            },
                          ),
                          CheckboxListTile(
                            title: Text('Tuesday'),
                            value: isTuesdayCheckedOne,
                            onChanged: (bool value) {
                              setState(() {
                                isTuesdayCheckedOne = value;
                              });
                            },
                          ),
                          CheckboxListTile(
                            title: Text('Wednesday'),
                            value: isWednesdayCheckedOne,
                            onChanged: (bool value) {
                              setState(() {
                                isWednesdayCheckedOne = value;
                              });
                            },
                          ),
                          CheckboxListTile(
                            title: Text('Thursday'),
                            value: isThursdayCheckedOne,
                            onChanged: (bool value) {
                              setState(() {
                                isThursdayCheckedOne = value;
                              });
                            },
                          ),
                          CheckboxListTile(
                            title: Text('Friday'),
                            value: isFridayCheckedOne,
                            onChanged: (bool value) {
                              setState(() {
                                isFridayCheckedOne = value;
                              });
                            },
                          ),
                          CheckboxListTile(
                            title: Text('Saturday'),
                            value: isSaturdaydayCheckedOne,
                            onChanged: (bool value) {
                              setState(() {
                                isSaturdaydayCheckedOne = value;
                              });
                            },
                          ),
                          CheckboxListTile(
                            title: Text('Sunday'),
                            value: isSundayCheckedOne,
                            onChanged: (bool value) {
                              setState(() {
                                isSundayCheckedOne = value;
                              });
                            },
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
          Visibility(
            visible: isReminderTwoVisible,
            child: Container(
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          NumberPicker(
                            textStyle: TextStyle(color: Colors.black38),
                            selectedTextStyle: TextStyle(
                                fontSize: 30, color: Color(0XFF008bb0)),
                            itemHeight: 40,
                            itemWidth: 35,
                            value: hourTwo,
                            minValue: 00,
                            maxValue: 23,
                            onChanged: (value) =>
                                setState(() => hourTwo = value),
                          ),
                          Text(
                            ' : ',
                            style: TextStyle(
                                fontSize: 30, color: Color(0XFF008bb0)),
                          ),
                          NumberPicker(
                            textStyle: TextStyle(color: Colors.black38),
                            selectedTextStyle: TextStyle(
                                fontSize: 30, color: Color(0XFF008bb0)),
                            itemHeight: 40,
                            itemWidth: 35,
                            value: minuteTwo,
                            minValue: 00,
                            maxValue: 59,
                            onChanged: (value) =>
                                setState(() => minuteTwo = value),
                          ),
                        ],
                      ),
                      Divider(),
                      Column(
                        children: [
                          CheckboxListTile(
                            title: Text('All Days'),
                            value: isAllDaysCheckedTwo,
                            onChanged: (bool value) {
                              setState(() {
                                isAllDaysCheckedTwo = value;
                                isMondayCheckedTwo = value;
                                isTuesdayCheckedTwo = value;
                                isWednesdayCheckedTwo = value;
                                isThursdayCheckedTwo = value;
                                isFridayCheckedTwo = value;
                                isSaturdaydayCheckedTwo = value;
                                isSundayCheckedTwo = value;
                              });
                            },
                          ),
                          CheckboxListTile(
                            title: Text('Monday'),
                            value: isMondayCheckedTwo,
                            onChanged: (bool value) {
                              setState(() {
                                isMondayCheckedTwo = value;
                              });
                            },
                          ),
                          CheckboxListTile(
                            title: Text('Tuesday'),
                            value: isTuesdayCheckedTwo,
                            onChanged: (bool value) {
                              setState(() {
                                isTuesdayCheckedTwo = value;
                              });
                            },
                          ),
                          CheckboxListTile(
                            title: Text('Wednesday'),
                            value: isWednesdayCheckedTwo,
                            onChanged: (bool value) {
                              setState(() {
                                isWednesdayCheckedTwo = value;
                              });
                            },
                          ),
                          CheckboxListTile(
                            title: Text('Thursday'),
                            value: isThursdayCheckedTwo,
                            onChanged: (bool value) {
                              setState(() {
                                isThursdayCheckedTwo = value;
                              });
                            },
                          ),
                          CheckboxListTile(
                            title: Text('Friday'),
                            value: isFridayCheckedTwo,
                            onChanged: (bool value) {
                              setState(() {
                                isFridayCheckedTwo = value;
                              });
                            },
                          ),
                          CheckboxListTile(
                            title: Text('Saturday'),
                            value: isSaturdaydayCheckedTwo,
                            onChanged: (bool value) {
                              setState(() {
                                isSaturdaydayCheckedTwo = value;
                              });
                            },
                          ),
                          CheckboxListTile(
                            title: Text('Sunday'),
                            value: isSundayCheckedTwo,
                            onChanged: (bool value) {
                              setState(() {
                                isSundayCheckedTwo = value;
                              });
                            },
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
          Visibility(
            visible: isReminderThreeVisible,
            child: Container(
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          NumberPicker(
                            textStyle: TextStyle(color: Colors.black38),
                            selectedTextStyle: TextStyle(
                                fontSize: 30, color: Color(0XFF008bb0)),
                            itemHeight: 40,
                            itemWidth: 35,
                            value: hourThree,
                            minValue: 00,
                            maxValue: 23,
                            onChanged: (value) =>
                                setState(() => hourThree = value),
                          ),
                          Text(
                            ' : ',
                            style: TextStyle(
                                fontSize: 30, color: Color(0XFF008bb0)),
                          ),
                          NumberPicker(
                            textStyle: TextStyle(color: Colors.black38),
                            selectedTextStyle: TextStyle(
                                fontSize: 30, color: Color(0XFF008bb0)),
                            itemHeight: 40,
                            itemWidth: 35,
                            value: minuteThree,
                            minValue: 00,
                            maxValue: 59,
                            onChanged: (value) =>
                                setState(() => minuteThree = value),
                          ),
                        ],
                      ),
                      Divider(),
                      Column(
                        children: [
                          CheckboxListTile(
                            title: Text('All Days'),
                            value: isAllDaysCheckedThree,
                            onChanged: (bool value) {
                              setState(() {
                                isAllDaysCheckedThree = value;
                                isMondayCheckedThree = value;
                                isTuesdayCheckedThree = value;
                                isWednesdayCheckedThree = value;
                                isThursdayCheckedThree = value;
                                isFridayCheckedThree = value;
                                isSaturdaydayCheckedThree = value;
                                isSundayCheckedThree = value;
                              });
                            },
                          ),
                          CheckboxListTile(
                            title: Text('Monday'),
                            value: isMondayCheckedThree,
                            onChanged: (bool value) {
                              setState(() {
                                isMondayCheckedThree = value;
                              });
                            },
                          ),
                          CheckboxListTile(
                            title: Text('Tuesday'),
                            value: isTuesdayCheckedThree,
                            onChanged: (bool value) {
                              setState(() {
                                isTuesdayCheckedThree = value;
                              });
                            },
                          ),
                          CheckboxListTile(
                            title: Text('Wednesday'),
                            value: isWednesdayCheckedThree,
                            onChanged: (bool value) {
                              setState(() {
                                isWednesdayCheckedThree = value;
                              });
                            },
                          ),
                          CheckboxListTile(
                            title: Text('Thursday'),
                            value: isThursdayCheckedThree,
                            onChanged: (bool value) {
                              setState(() {
                                isThursdayCheckedThree = value;
                              });
                            },
                          ),
                          CheckboxListTile(
                            title: Text('Friday'),
                            value: isFridayCheckedThree,
                            onChanged: (bool value) {
                              setState(() {
                                isFridayCheckedThree = value;
                              });
                            },
                          ),
                          CheckboxListTile(
                            title: Text('Saturday'),
                            value: isSaturdaydayCheckedThree,
                            onChanged: (bool value) {
                              setState(() {
                                isSaturdaydayCheckedThree = value;
                              });
                            },
                          ),
                          CheckboxListTile(
                            title: Text('Sunday'),
                            value: isSundayCheckedThree,
                            onChanged: (bool value) {
                              setState(() {
                                isSundayCheckedThree = value;
                              });
                            },
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
          Visibility(
            visible: isReminderFourVisible,
            child: Container(
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          NumberPicker(
                            textStyle: TextStyle(color: Colors.black38),
                            selectedTextStyle: TextStyle(
                                fontSize: 30, color: Color(0XFF008bb0)),
                            itemHeight: 40,
                            itemWidth: 35,
                            value: hourFour,
                            minValue: 00,
                            maxValue: 23,
                            onChanged: (value) =>
                                setState(() => hourFour = value),
                          ),
                          Text(
                            ' : ',
                            style: TextStyle(
                                fontSize: 30, color: Color(0XFF008bb0)),
                          ),
                          NumberPicker(
                            textStyle: TextStyle(color: Colors.black38),
                            selectedTextStyle: TextStyle(
                                fontSize: 30, color: Color(0XFF008bb0)),
                            itemHeight: 40,
                            itemWidth: 35,
                            value: minuteFour,
                            minValue: 00,
                            maxValue: 59,
                            onChanged: (value) =>
                                setState(() => minuteFour = value),
                          ),
                        ],
                      ),
                      Divider(),
                      Column(
                        children: [
                          CheckboxListTile(
                            title: Text('All Days'),
                            value: isAllDaysCheckedFour,
                            onChanged: (bool value) {
                              setState(() {
                                isAllDaysCheckedFour = value;
                                isMondayCheckedFour = value;
                                isTuesdayCheckedFour = value;
                                isWednesdayCheckedFour = value;
                                isThursdayCheckedFour = value;
                                isFridayCheckedFour = value;
                                isSaturdaydayCheckedFour = value;
                                isSundayCheckedFour = value;
                              });
                            },
                          ),
                          CheckboxListTile(
                            title: Text('Monday'),
                            value: isMondayCheckedFour,
                            onChanged: (bool value) {
                              setState(() {
                                isMondayCheckedFour = value;
                              });
                            },
                          ),
                          CheckboxListTile(
                            title: Text('Tuesday'),
                            value: isTuesdayCheckedFour,
                            onChanged: (bool value) {
                              setState(() {
                                isTuesdayCheckedFour = value;
                              });
                            },
                          ),
                          CheckboxListTile(
                            title: Text('Wednesday'),
                            value: isWednesdayCheckedFour,
                            onChanged: (bool value) {
                              setState(() {
                                isWednesdayCheckedFour = value;
                              });
                            },
                          ),
                          CheckboxListTile(
                            title: Text('Thursday'),
                            value: isThursdayCheckedFour,
                            onChanged: (bool value) {
                              setState(() {
                                isThursdayCheckedFour = value;
                              });
                            },
                          ),
                          CheckboxListTile(
                            title: Text('Friday'),
                            value: isFridayCheckedFour,
                            onChanged: (bool value) {
                              setState(() {
                                isFridayCheckedFour = value;
                              });
                            },
                          ),
                          CheckboxListTile(
                            title: Text('Saturday'),
                            value: isSaturdaydayCheckedFour,
                            onChanged: (bool value) {
                              setState(() {
                                isSaturdaydayCheckedFour = value;
                              });
                            },
                          ),
                          CheckboxListTile(
                            title: Text('Sunday'),
                            value: isSundayCheckedFour,
                            onChanged: (bool value) {
                              setState(() {
                                isSundayCheckedFour = value;
                              });
                            },
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      );

  void addMedicineWrapper() async {
    // await localNotification.deleteAllNotifications();

    final isValid = _formKey.currentState.validate();

    if (isValid) {
      int medicineId = await addMedicine();

      if (numOfVisibileReminders == 1) {
        String title = medicineNameController.text;
        String body =
            'Take ${dosageAmountController.text} ${amountUnitController.text == 'ml' ? 'ml' : 'pills'} of ${medicineNameController.text} ${isBefore == true ? 'before meal' : 'after meal'}.';

        addReminderToDB(
            medicineId,
            hourOne,
            minuteOne,
            isMondayCheckedOne,
            isTuesdayCheckedOne,
            isWednesdayCheckedOne,
            isThursdayCheckedOne,
            isFridayCheckedOne,
            isSaturdaydayCheckedOne,
            isSundayCheckedOne,
            medicineNameController.text,
            isBefore);

        if (isMondayCheckedOne) {
          addReminderToNotifications(medicineId + 1, medicineId, title, body,
              DateTime.monday, hourOne, minuteOne);
        }
        if (isTuesdayCheckedOne) {
          addReminderToNotifications(medicineId + 2, medicineId, title, body,
              DateTime.tuesday, hourOne, minuteOne);
        }
        if (isWednesdayCheckedOne) {
          addReminderToNotifications(medicineId + 3, medicineId, title, body,
              DateTime.wednesday, hourOne, minuteOne);
        }
        if (isThursdayCheckedOne) {
          addReminderToNotifications(medicineId + 4, medicineId, title, body,
              DateTime.thursday, hourOne, minuteOne);
        }
        if (isFridayCheckedOne) {
          addReminderToNotifications(medicineId + 5, medicineId, title, body,
              DateTime.friday, hourOne, minuteOne);
        }
        if (isSaturdaydayCheckedOne) {
          addReminderToNotifications(medicineId + 6, medicineId, title, body,
              DateTime.saturday, hourOne, minuteOne);
        }
        if (isSundayCheckedOne) {
          addReminderToNotifications(medicineId + 7, medicineId, title, body,
              DateTime.sunday, hourOne, minuteOne);
        }
      } else if (numOfVisibileReminders == 2) {
        String title = medicineNameController.text;
        String body =
            'Take ${dosageAmountController.text} ${amountUnitController.text == 'ml' ? 'ml' : 'pills'} of ${medicineNameController.text} ${isBefore == true ? 'before meal' : 'after meal'}.';

        addReminderToDB(
            medicineId,
            hourOne,
            minuteOne,
            isMondayCheckedOne,
            isTuesdayCheckedOne,
            isWednesdayCheckedOne,
            isThursdayCheckedOne,
            isFridayCheckedOne,
            isSaturdaydayCheckedOne,
            isSundayCheckedOne,
            medicineNameController.text,
            isBefore);

        if (isMondayCheckedOne) {
          addReminderToNotifications(medicineId + 1, medicineId, title, body,
              DateTime.monday, hourOne, minuteOne);
        }
        if (isTuesdayCheckedOne) {
          addReminderToNotifications(medicineId + 2, medicineId, title, body,
              DateTime.tuesday, hourOne, minuteOne);
        }
        if (isWednesdayCheckedOne) {
          addReminderToNotifications(medicineId + 3, medicineId, title, body,
              DateTime.wednesday, hourOne, minuteOne);
        }
        if (isThursdayCheckedOne) {
          addReminderToNotifications(medicineId + 4, medicineId, title, body,
              DateTime.thursday, hourOne, minuteOne);
        }
        if (isFridayCheckedOne) {
          addReminderToNotifications(medicineId + 5, medicineId, title, body,
              DateTime.friday, hourOne, minuteOne);
        }
        if (isSaturdaydayCheckedOne) {
          addReminderToNotifications(medicineId + 6, medicineId, title, body,
              DateTime.saturday, hourOne, minuteOne);
        }
        if (isSundayCheckedOne) {
          addReminderToNotifications(medicineId + 7, medicineId, title, body,
              DateTime.sunday, hourOne, minuteOne);
        }

        addReminderToDB(
            medicineId,
            hourTwo,
            minuteTwo,
            isMondayCheckedTwo,
            isTuesdayCheckedTwo,
            isWednesdayCheckedTwo,
            isThursdayCheckedTwo,
            isFridayCheckedTwo,
            isSaturdaydayCheckedTwo,
            isSundayCheckedTwo,
            medicineNameController.text,
            isBefore);

        if (isMondayCheckedTwo) {
          addReminderToNotifications(medicineId + 8, medicineId, title, body,
              DateTime.monday, hourTwo, minuteTwo);
        }
        if (isTuesdayCheckedTwo) {
          addReminderToNotifications(medicineId + 9, medicineId, title, body,
              DateTime.tuesday, hourTwo, minuteTwo);
        }
        if (isWednesdayCheckedTwo) {
          addReminderToNotifications(medicineId + 10, medicineId, title, body,
              DateTime.wednesday, hourTwo, minuteTwo);
        }
        if (isThursdayCheckedTwo) {
          addReminderToNotifications(medicineId + 11, medicineId, title, body,
              DateTime.thursday, hourTwo, minuteTwo);
        }
        if (isFridayCheckedTwo) {
          addReminderToNotifications(medicineId + 12, medicineId, title, body,
              DateTime.friday, hourTwo, minuteTwo);
        }
        if (isSaturdaydayCheckedTwo) {
          addReminderToNotifications(medicineId + 13, medicineId, title, body,
              DateTime.saturday, hourTwo, minuteTwo);
        }
        if (isSundayCheckedTwo) {
          addReminderToNotifications(medicineId + 14, medicineId, title, body,
              DateTime.sunday, hourTwo, minuteTwo);
        }
      } else if (numOfVisibileReminders == 3) {
        String title = medicineNameController.text;
        String body =
            'Take ${dosageAmountController.text} ${amountUnitController.text == 'ml' ? 'ml' : 'pills'} of ${medicineNameController.text} ${isBefore == true ? 'before meal' : 'after meal'}.';

        addReminderToDB(
            medicineId,
            hourOne,
            minuteOne,
            isMondayCheckedOne,
            isTuesdayCheckedOne,
            isWednesdayCheckedOne,
            isThursdayCheckedOne,
            isFridayCheckedOne,
            isSaturdaydayCheckedOne,
            isSundayCheckedOne,
            medicineNameController.text,
            isBefore);

        if (isMondayCheckedOne) {
          addReminderToNotifications(medicineId + 1, medicineId, title, body,
              DateTime.monday, hourOne, minuteOne);
        }
        if (isTuesdayCheckedOne) {
          addReminderToNotifications(medicineId + 2, medicineId, title, body,
              DateTime.tuesday, hourOne, minuteOne);
        }
        if (isWednesdayCheckedOne) {
          addReminderToNotifications(medicineId + 3, medicineId, title, body,
              DateTime.wednesday, hourOne, minuteOne);
        }
        if (isThursdayCheckedOne) {
          addReminderToNotifications(medicineId + 4, medicineId, title, body,
              DateTime.thursday, hourOne, minuteOne);
        }
        if (isFridayCheckedOne) {
          addReminderToNotifications(medicineId + 5, medicineId, title, body,
              DateTime.friday, hourOne, minuteOne);
        }
        if (isSaturdaydayCheckedOne) {
          addReminderToNotifications(medicineId + 6, medicineId, title, body,
              DateTime.saturday, hourOne, minuteOne);
        }
        if (isSundayCheckedOne) {
          addReminderToNotifications(medicineId + 7, medicineId, title, body,
              DateTime.sunday, hourOne, minuteOne);
        }

        addReminderToDB(
            medicineId,
            hourTwo,
            minuteTwo,
            isMondayCheckedTwo,
            isTuesdayCheckedTwo,
            isWednesdayCheckedTwo,
            isThursdayCheckedTwo,
            isFridayCheckedTwo,
            isSaturdaydayCheckedTwo,
            isSundayCheckedTwo,
            medicineNameController.text,
            isBefore);

        if (isMondayCheckedTwo) {
          addReminderToNotifications(medicineId + 8, medicineId, title, body,
              DateTime.monday, hourTwo, minuteTwo);
        }
        if (isTuesdayCheckedTwo) {
          addReminderToNotifications(medicineId + 9, medicineId, title, body,
              DateTime.tuesday, hourTwo, minuteTwo);
        }
        if (isWednesdayCheckedTwo) {
          addReminderToNotifications(medicineId + 10, medicineId, title, body,
              DateTime.wednesday, hourTwo, minuteTwo);
        }
        if (isThursdayCheckedTwo) {
          addReminderToNotifications(medicineId + 11, medicineId, title, body,
              DateTime.thursday, hourTwo, minuteTwo);
        }
        if (isFridayCheckedTwo) {
          addReminderToNotifications(medicineId + 12, medicineId, title, body,
              DateTime.friday, hourTwo, minuteTwo);
        }
        if (isSaturdaydayCheckedTwo) {
          addReminderToNotifications(medicineId + 13, medicineId, title, body,
              DateTime.saturday, hourTwo, minuteTwo);
        }
        if (isSundayCheckedTwo) {
          addReminderToNotifications(medicineId + 14, medicineId, title, body,
              DateTime.sunday, hourTwo, minuteTwo);
        }

        addReminderToDB(
            medicineId,
            hourThree,
            minuteThree,
            isMondayCheckedThree,
            isTuesdayCheckedThree,
            isWednesdayCheckedThree,
            isThursdayCheckedThree,
            isFridayCheckedThree,
            isSaturdaydayCheckedThree,
            isSundayCheckedThree,
            medicineNameController.text,
            isBefore);

        if (isMondayCheckedThree) {
          addReminderToNotifications(medicineId + 15, medicineId, title, body,
              DateTime.monday, hourThree, minuteThree);
        }
        if (isTuesdayCheckedThree) {
          addReminderToNotifications(medicineId + 16, medicineId, title, body,
              DateTime.tuesday, hourThree, minuteThree);
        }
        if (isWednesdayCheckedThree) {
          addReminderToNotifications(medicineId + 17, medicineId, title, body,
              DateTime.wednesday, hourThree, minuteThree);
        }
        if (isThursdayCheckedThree) {
          addReminderToNotifications(medicineId + 18, medicineId, title, body,
              DateTime.thursday, hourThree, minuteThree);
        }
        if (isFridayCheckedThree) {
          addReminderToNotifications(medicineId + 19, medicineId, title, body,
              DateTime.friday, hourThree, minuteThree);
        }
        if (isSaturdaydayCheckedThree) {
          addReminderToNotifications(medicineId + 20, medicineId, title, body,
              DateTime.saturday, hourThree, minuteThree);
        }
        if (isSundayCheckedThree) {
          addReminderToNotifications(medicineId + 21, medicineId, title, body,
              DateTime.sunday, hourThree, minuteThree);
        }
      } else if (numOfVisibileReminders == 4) {
        String title = medicineNameController.text;
        String body =
            'Take ${dosageAmountController.text} ${amountUnitController.text == 'ml' ? 'ml' : 'pills'} of ${medicineNameController.text} ${isBefore == true ? 'before meal' : 'after meal'}.';

        addReminderToDB(
            medicineId,
            hourOne,
            minuteOne,
            isMondayCheckedOne,
            isTuesdayCheckedOne,
            isWednesdayCheckedOne,
            isThursdayCheckedOne,
            isFridayCheckedOne,
            isSaturdaydayCheckedOne,
            isSundayCheckedOne,
            medicineNameController.text,
            isBefore);

        if (isMondayCheckedOne) {
          addReminderToNotifications(medicineId + 1, medicineId, title, body,
              DateTime.monday, hourOne, minuteOne);
        }
        if (isTuesdayCheckedOne) {
          addReminderToNotifications(medicineId + 2, medicineId, title, body,
              DateTime.tuesday, hourOne, minuteOne);
        }
        if (isWednesdayCheckedOne) {
          addReminderToNotifications(medicineId + 3, medicineId, title, body,
              DateTime.wednesday, hourOne, minuteOne);
        }
        if (isThursdayCheckedOne) {
          addReminderToNotifications(medicineId + 4, medicineId, title, body,
              DateTime.thursday, hourOne, minuteOne);
        }
        if (isFridayCheckedOne) {
          addReminderToNotifications(medicineId + 5, medicineId, title, body,
              DateTime.friday, hourOne, minuteOne);
        }
        if (isSaturdaydayCheckedOne) {
          addReminderToNotifications(medicineId + 6, medicineId, title, body,
              DateTime.saturday, hourOne, minuteOne);
        }
        if (isSundayCheckedOne) {
          addReminderToNotifications(medicineId + 7, medicineId, title, body,
              DateTime.sunday, hourOne, minuteOne);
        }

        addReminderToDB(
            medicineId,
            hourTwo,
            minuteTwo,
            isMondayCheckedTwo,
            isTuesdayCheckedTwo,
            isWednesdayCheckedTwo,
            isThursdayCheckedTwo,
            isFridayCheckedTwo,
            isSaturdaydayCheckedTwo,
            isSundayCheckedTwo,
            medicineNameController.text,
            isBefore);

        if (isMondayCheckedTwo) {
          addReminderToNotifications(medicineId + 8, medicineId, title, body,
              DateTime.monday, hourTwo, minuteTwo);
        }
        if (isTuesdayCheckedTwo) {
          addReminderToNotifications(medicineId + 9, medicineId, title, body,
              DateTime.tuesday, hourTwo, minuteTwo);
        }
        if (isWednesdayCheckedTwo) {
          addReminderToNotifications(medicineId + 10, medicineId, title, body,
              DateTime.wednesday, hourTwo, minuteTwo);
        }
        if (isThursdayCheckedTwo) {
          addReminderToNotifications(medicineId + 11, medicineId, title, body,
              DateTime.thursday, hourTwo, minuteTwo);
        }
        if (isFridayCheckedTwo) {
          addReminderToNotifications(medicineId + 12, medicineId, title, body,
              DateTime.friday, hourTwo, minuteTwo);
        }
        if (isSaturdaydayCheckedTwo) {
          addReminderToNotifications(medicineId + 13, medicineId, title, body,
              DateTime.saturday, hourTwo, minuteTwo);
        }
        if (isSundayCheckedTwo) {
          addReminderToNotifications(medicineId + 14, medicineId, title, body,
              DateTime.sunday, hourTwo, minuteTwo);
        }

        addReminderToDB(
            medicineId,
            hourThree,
            minuteThree,
            isMondayCheckedThree,
            isTuesdayCheckedThree,
            isWednesdayCheckedThree,
            isThursdayCheckedThree,
            isFridayCheckedThree,
            isSaturdaydayCheckedThree,
            isSundayCheckedThree,
            medicineNameController.text,
            isBefore);

        if (isMondayCheckedThree) {
          addReminderToNotifications(medicineId + 15, medicineId, title, body,
              DateTime.monday, hourThree, minuteThree);
        }
        if (isTuesdayCheckedThree) {
          addReminderToNotifications(medicineId + 16, medicineId, title, body,
              DateTime.tuesday, hourThree, minuteThree);
        }
        if (isWednesdayCheckedThree) {
          addReminderToNotifications(medicineId + 17, medicineId, title, body,
              DateTime.wednesday, hourThree, minuteThree);
        }
        if (isThursdayCheckedThree) {
          addReminderToNotifications(medicineId + 18, medicineId, title, body,
              DateTime.thursday, hourThree, minuteThree);
        }
        if (isFridayCheckedThree) {
          addReminderToNotifications(medicineId + 19, medicineId, title, body,
              DateTime.friday, hourThree, minuteThree);
        }
        if (isSaturdaydayCheckedThree) {
          addReminderToNotifications(medicineId + 20, medicineId, title, body,
              DateTime.saturday, hourThree, minuteThree);
        }
        if (isSundayCheckedThree) {
          addReminderToNotifications(medicineId + 21, medicineId, title, body,
              DateTime.sunday, hourThree, minuteThree);
        }

        addReminderToDB(
            medicineId,
            hourFour,
            minuteFour,
            isMondayCheckedFour,
            isTuesdayCheckedFour,
            isWednesdayCheckedFour,
            isThursdayCheckedFour,
            isFridayCheckedFour,
            isSaturdaydayCheckedFour,
            isSundayCheckedFour,
            medicineNameController.text,
            isBefore);

        if (isMondayCheckedFour) {
          addReminderToNotifications(medicineId + 22, medicineId, title, body,
              DateTime.monday, hourFour, minuteFour);
        }
        if (isTuesdayCheckedFour) {
          addReminderToNotifications(medicineId + 23, medicineId, title, body,
              DateTime.tuesday, hourFour, minuteFour);
        }
        if (isWednesdayCheckedFour) {
          addReminderToNotifications(medicineId + 24, medicineId, title, body,
              DateTime.wednesday, hourFour, minuteFour);
        }
        if (isThursdayCheckedFour) {
          addReminderToNotifications(medicineId + 25, medicineId, title, body,
              DateTime.thursday, hourFour, minuteFour);
        }
        if (isFridayCheckedFour) {
          addReminderToNotifications(medicineId + 26, medicineId, title, body,
              DateTime.friday, hourFour, minuteFour);
        }
        if (isSaturdaydayCheckedFour) {
          addReminderToNotifications(medicineId + 27, medicineId, title, body,
              DateTime.saturday, hourFour, minuteFour);
        }
        if (isSundayCheckedFour) {
          addReminderToNotifications(medicineId + 28, medicineId, title, body,
              DateTime.sunday, hourFour, minuteFour);
        }
      }

      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text('Medicine is added!'),
        duration: Duration(seconds: 3),
      ));

      //set for default values
      medicineNameController.text = '';
      amountController.text = '';
      dosageAmountController.text = '';
      amountUnitController.text = 'count';
      isBefore = false;
      timesPerDayController.text = '';

      numOfVisibileReminders = 1;

      hourOne = 10;
      minuteOne = 30;
      isAllDaysCheckedOne = false;
      isMondayCheckedOne = false;
      isTuesdayCheckedOne = false;
      isWednesdayCheckedOne = false;
      isThursdayCheckedOne = false;
      isFridayCheckedOne = false;
      isSaturdaydayCheckedOne = false;
      isSundayCheckedOne = false;
      isReminderOneVisible = true;

      hourTwo = 10;
      minuteTwo = 30;
      isAllDaysCheckedTwo = false;
      isMondayCheckedTwo = false;
      isTuesdayCheckedTwo = false;
      isWednesdayCheckedTwo = false;
      isThursdayCheckedTwo = false;
      isFridayCheckedTwo = false;
      isSaturdaydayCheckedTwo = false;
      isSundayCheckedTwo = false;
      isReminderTwoVisible = false;

      hourThree = 10;
      minuteThree = 30;
      isAllDaysCheckedThree = false;
      isMondayCheckedThree = false;
      isTuesdayCheckedThree = false;
      isWednesdayCheckedThree = false;
      isThursdayCheckedThree = false;
      isFridayCheckedThree = false;
      isSaturdaydayCheckedThree = false;
      isSundayCheckedThree = false;
      isReminderThreeVisible = false;

      hourFour = 10;
      minuteFour = 30;
      isAllDaysCheckedFour = false;
      isMondayCheckedFour = false;
      isTuesdayCheckedFour = false;
      isWednesdayCheckedFour = false;
      isThursdayCheckedFour = false;
      isFridayCheckedFour = false;
      isSaturdaydayCheckedFour = false;
      isSundayCheckedFour = false;
      isReminderFourVisible = false;

      setState(() => ++this.temp);
    }
  }

  Future<int> addMedicine() async {
    ColorLizer colorlizer = ColorLizer();
    Color color = colorlizer.getSpecialFiledColor([
      Colors.lightBlue,
      Colors.teal,
      Colors.red,
      Colors.indigo,
      Colors.lime,
    ]);

    final medicine = Medicine(
      name: medicineNameController.text,
      totalAmount: int.tryParse(amountController.text),
      currentAmount: int.tryParse(amountController.text),
      dosageAmount: int.tryParse(dosageAmountController.text),
      amountUnit: amountUnitController.text,
      isBefore: isBefore,
      timesPerDay: numOfVisibileReminders,
      color: color.toString().substring(35, 45),
    );

    final medicineObj =
        await MedicineDatabase.instance.createMedicine(medicine);

    return medicineObj.id;
  }

  Future addReminderToNotifications(int idForNotification, int medicineId,
      String title, String body, int day, int hour, int minute) async {
    await localNotification.configureLocalTimeZone();

    await localNotification.showWeeklyAtDayAndTimeNotification(
        idForNotification, medicineId, title, body, day, hour, minute);
  }

  Future addReminderToDB(
      int medicineId,
      int hour,
      int minute,
      bool monday,
      bool tuesday,
      bool wednesday,
      bool thursday,
      bool friday,
      bool saturday,
      bool sunday,
      String medicineName,
      bool isBefore) async {
    final reminder = Reminder(
      medicineId: medicineId,
      hour: hour,
      minute: minute,
      monday: monday,
      tuesday: tuesday,
      wednesday: wednesday,
      thursday: thursday,
      friday: friday,
      saturday: saturday,
      sunday: sunday,
      medicineName: medicineName,
      isBefore: isBefore,
    );

    await MedicineDatabase.instance.createReminder(reminder);
  }
}
