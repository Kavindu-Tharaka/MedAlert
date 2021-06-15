import 'package:MedAlert/model/diary.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddDiary extends StatefulWidget {
  final DiaryFields diaryFields;

  final Function updateSugarReports;

  const AddDiary({
    this.updateSugarReports,
    Key key,
    this.diaryFields,
  }) : super(key: key);

  @override
  _AddDiaryState createState() => _AddDiaryState();
}

class _AddDiaryState extends State<AddDiary> {
  final _formKey = GlobalKey<FormState>();
  String _diaryFieldsLevelF = '';
  String _diaryFieldsLevelPP = '';
  DateTime _date = DateTime.now();
  TextEditingController _dateController = TextEditingController();

  final DateFormat _dateFormatter = DateFormat('MM dd, yyyy');

  @override
  void initState() {
    super.initState();
    _dateController.text = _dateFormatter.format(_date);
  }

  @override
  void dispose() {
    _dateController.dispose();
    super.dispose();
  }

  _handleDatePicker() async {
    final DateTime date = await showDatePicker(
        context: context,
        initialDate: _date,
        firstDate: DateTime(2010),
        lastDate: DateTime(2030));
    if (date != null && date != _date) {
      setState(() {
        _date = date;
      });
      _dateController.text = _dateFormatter.format(date);
    }
  }

  @override
  Widget build(BuildContext context) {
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
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  widget.diaryFields == null
                      ? 'How do you feel today?'
                      : 'Update Sugar Repport',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 40.0,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 10.0),
                        child: TextFormField(
                          autofocus: false,
                          controller: _dateController,
                          onTap: _handleDatePicker,
                          // keyboardType: TextInputType.number,
                          style: TextStyle(
                            color: Colors.black87,
                            fontWeight: FontWeight.normal,
                            fontSize: 20,
                          ),
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.all(10.0),
                            labelText: 'Date',
                            labelStyle: TextStyle(
                              fontSize: 18,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(40),
                              borderSide: BorderSide(
                                  color: Colors.black,
                                  style: BorderStyle.solid),
                            ),
                            hintStyle: TextStyle(color: Colors.white70),
                          ),
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Can not be empty!';
                            }
                            return null;
                          },
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 10.0),
                        child: TextFormField(
                          onEditingComplete: () {
                            FocusScope.of(context).nextFocus();
                          },
                          autofocus: true,
                          maxLines: null,
                          keyboardType: TextInputType.text,
                          style: TextStyle(
                            color: Colors.black87,
                            fontWeight: FontWeight.normal,
                            fontSize: 20,
                          ),
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.all(10.0),
                            labelText: 'Description',
                            labelStyle: TextStyle(
                              fontSize: 18,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(
                                  color: Colors.black,
                                  style: BorderStyle.solid),
                            ),
                            hintText: 'Description',
                            hintStyle: TextStyle(color: Colors.white70),
                          ),
                          onSaved: (input) => _diaryFieldsLevelF = input,
                          initialValue: _diaryFieldsLevelF,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Can not be empty!';
                            }
                            return null;
                          },
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 20.0),
                        height: 50.0,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            borderRadius: BorderRadius.circular(30.0)),
                        child: TextButton(
                          style: ButtonStyle(
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50.0),
                              )),
                              backgroundColor:
                                  MaterialStateProperty.all(Color(0XFF008bb0))),
                          child: Text(
                            widget.diaryFields == null
                                ? 'Add Entry'
                                : 'Update Diary',
                            style:
                                TextStyle(color: Colors.white, fontSize: 20.0),
                          ),
                          onPressed: null,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
