import 'package:rating_bar/rating_bar.dart';
import 'package:MedAlert/db/database_helper.dart';
import 'package:MedAlert/model/diary.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddDiary extends StatefulWidget {
  final Diary diary;

  const AddDiary({
    Key key,
    this.diary,
  }) : super(key: key);

  @override
  _AddDiaryState createState() => _AddDiaryState();
}

class _AddDiaryState extends State<AddDiary> {
  double _ratingSmile = 1;
  var _ratingStatuses = [
    'Serious',
    'Bad Condition',
    'Satisfactory Condition',
    'Good Condition',
    'Excellent',
  ];
  String _ratingStatus;

  final snackBar = SnackBar(content: Text('New Entry Added'));

  final _formKey = GlobalKey<FormState>();
  DateTime _date = DateTime.now();
  String _description = '';
  TextEditingController _dateController = TextEditingController();

  final DateFormat _dateFormatter = DateFormat('MM dd, yyyy');

  Future _addNewEntry() async {
    if (_formKey.currentState.validate()) {
      final diary = Diary(
          date: _date.toString(),
          rate: _ratingSmile.toInt(),
          diary: _description);

      await MedicineDatabase.instance.creatDiary(diary);
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      Navigator.pop(context);
    }
  }

  void _changeRating(rating) {
    setState(() => {
          _ratingSmile = rating,
          _ratingStatus = _ratingStatuses.elementAt(_ratingSmile.toInt() - 1),
        });
  }

  @override
  void initState() {
    super.initState();
    _ratingSmile = 1;
    _ratingStatus = _ratingStatuses.elementAt(0);
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
                  'How do you feel today?',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 40.0,
                      fontWeight: FontWeight.bold),
                ),
                Divider(),
                SizedBox(
                  height: 10.0,
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 10.0),
                        child: RatingBar(
                          onRatingChanged: (rating) => _changeRating(rating),
                          filledIcon: Icons.sentiment_satisfied,
                          emptyIcon: Icons.sentiment_dissatisfied,
                          halfFilledIcon: Icons.sentiment_neutral,
                          isHalfAllowed: false,
                          filledColor: Colors.green,
                          emptyColor: Colors.redAccent,
                          halfFilledColor: Colors.amberAccent,
                          size: 60,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 10.0, bottom: 15.0),
                        child: Text(
                          _ratingStatus,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 14.0,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
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
                              return 'Please select a date';
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
                          textInputAction: TextInputAction.unspecified,
                          autofocus: true,
                          maxLines: null,
                          minLines: 3,
                          keyboardType: TextInputType.text,
                          style: TextStyle(
                            color: Colors.black87,
                            fontWeight: FontWeight.normal,
                            fontSize: 20,
                          ),
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.fromLTRB(
                                10.0, 20.0, 10.0, 20.0),
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
                          onChanged: (value) => _description = value,
                          initialValue: _description,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Plese add small description';
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
                            'Add Entry',
                            style:
                                TextStyle(color: Colors.white, fontSize: 20.0),
                          ),
                          onPressed: () {
                            _addNewEntry();
                            print('Date $_date');
                            print('Description $_description');
                          },
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
