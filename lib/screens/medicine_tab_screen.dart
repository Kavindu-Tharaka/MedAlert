import 'package:MedAlert/model/medicine.dart';
import 'package:MedAlert/screens/add_medicine_page.dart';
import 'package:flutter/material.dart';

class MedicinesTabScreen extends StatefulWidget {
  @override
  _MedicineTabScsreenState createState() => _MedicineTabScsreenState();
}

class _MedicineTabScsreenState extends State<MedicinesTabScreen> {
  List<Medicine> medicines;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(10, 15, 10, 0),
        child: Center(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => AddMedicinePage()),
          );
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
