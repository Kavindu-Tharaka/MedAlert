import 'package:MedAlert/db/database_helper.dart';
import 'package:MedAlert/model/report.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


class AddSugarReportScreen extends StatefulWidget {
  final Sugar sugar;

  final Function updateSugarReports;

  const AddSugarReportScreen({
    this.updateSugarReports,
    Key key,
    this.sugar,
  }) : super(key: key);

  @override
  _AddSugarReportScreenState createState() => _AddSugarReportScreenState();
}

class _AddSugarReportScreenState extends State<AddSugarReportScreen> {
  final _formKey = GlobalKey<FormState>();
  String _sugarLevelF = '';
  String _sugarLevelPP = '';
  DateTime _date = DateTime.now();
  TextEditingController _dateController = TextEditingController();

  final DateFormat _dateFormatter = DateFormat('MM dd, yyyy');

  @override
  void initState() {
    super.initState();

    if (widget.sugar != null) {
      _sugarLevelF = widget.sugar.sugarLevelF;
      _sugarLevelPP = widget.sugar.sugarLevelPP;
    }

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

  _submit() async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();

      //inset or update record on db

      final sugar = Sugar(
          sugarLevelF: _sugarLevelF,
          sugarLevelPP: _sugarLevelPP,
          reportDate: _date);

      //insert
      if (widget.sugar == null) {
        await MedicineDatabase.instance.create(sugar);
      } else {
        //update
        final updatedSugar = widget.sugar.copy(
            sugarLevelF: _sugarLevelF,
            sugarLevelPP: _sugarLevelPP,
            reportDate: _date);
        await MedicineDatabase.instance.update(updatedSugar);
      }
      //refresh screen
      widget.updateSugarReports();
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 80.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Icon(
                    Icons.arrow_back_ios,
                    size: 32,
                    color: Colors.black26,
                  ),
                ),
                SizedBox(height: 20.0),
                Text(
                  widget.sugar == null
                      ? 'Add Sugar Report'
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
//first input field
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 20.0),
                        child: TextFormField(
                          onEditingComplete: () {
                            FocusScope.of(context).nextFocus();
                          },
                          autofocus: false,
                          // controller: medicineNameController,
                          maxLines: 1,
                          keyboardType: TextInputType.number,
                          style: TextStyle(
                            color: Colors.black87,
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.all(10.0),
                            labelText: 'Sugar Level - Fasting',
                            labelStyle: TextStyle(
                              fontSize: 15,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(40),
                              borderSide: BorderSide(
                                  color: Colors.black,
                                  style: BorderStyle.solid),
                            ),
                            hintText: 'mgs/dl',
                            hintStyle: TextStyle(color: Colors.white70),
                          ),
                          onSaved: (input) => _sugarLevelF = input,
                          initialValue: _sugarLevelF,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Can not be empty!';
                            }
                            return null;
                          },
                        ),
                      ),

//second input
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 20.0),
                        child: TextFormField(
                          onEditingComplete: () {
                            FocusScope.of(context).nextFocus();
                          },
                          autofocus: false,
                          // controller: medicineNameController,
                          maxLines: 1,
                          keyboardType: TextInputType.number,
                          style: TextStyle(
                            color: Colors.black87,
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.all(10.0),
                            labelText: 'Sugar Level - Post Pradinal',
                            labelStyle: TextStyle(
                              fontSize: 15,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(40),
                              borderSide: BorderSide(
                                  color: Colors.black,
                                  style: BorderStyle.solid),
                            ),
                            hintText: 'mgs/dl',
                            hintStyle: TextStyle(color: Colors.white70),
                          ),
                          onSaved: (input) => _sugarLevelPP = input,
                          initialValue: _sugarLevelPP,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Can not be empty!';
                            }
                            return null;
                          },
                        ),
                      ),

                      // TextFormField(
                      //     style: TextStyle(fontSize: 18.0),
                      //     decoration: InputDecoration(
                      //         labelText: "Sugar level-post prandial",
                      //         labelStyle: TextStyle(fontSize: 18.0),
                      //         border: OutlineInputBorder(
                      //             borderRadius: BorderRadius.circular(10.0))),
                      //     validator: (input) => input.trim().isEmpty
                      //         ? 'Please enter sugat level post pradinal'
                      //         : null,
                      //     onSaved: (input) => _sugarLevelPP = input,
                      //     initialValue: _sugarLevelPP,
                      //   ),

//third input
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 20.0),
                        child: TextFormField(
                          autofocus: false,
                          controller: _dateController,
                          onTap: _handleDatePicker,
                          // keyboardType: TextInputType.number,
                          style: TextStyle(
                            color: Colors.black87,
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.all(10.0),
                            labelText: 'Report Date',
                            labelStyle: TextStyle(
                              fontSize: 15,
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

                      //  TextFormField(
                      //   readOnly: true,
                      //   controller: _dateController,
                      //   style: TextStyle(fontSize: 18.0),
                      //   onTap: _handleDatePicker,
                      //   decoration: InputDecoration(
                      //       labelText: "Date",
                      //       labelStyle: TextStyle(fontSize: 18.0),
                      //       border: OutlineInputBorder(
                      //           borderRadius: BorderRadius.circular(10.0))),
                      // ),

                      Container(
                        margin: EdgeInsets.symmetric(vertical: 20.0),
                        height: 60.0,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            borderRadius: BorderRadius.circular(30.0)),
                        child: TextButton(
                          style: ButtonStyle(
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                              )),
                              backgroundColor:
                                  MaterialStateProperty.all(Color(0XFF008bb0))),
                          child: Text(
                            widget.sugar == null
                                ? 'Add Sugar Report'
                                : 'Update Report',
                            style:
                                TextStyle(color: Colors.white, fontSize: 20.0),
                          ),
                          onPressed: _submit,
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
