import 'package:MedAlert/db/database_helper.dart';
import 'package:MedAlert/model/medicine.dart';
import 'package:MedAlert/notifications/local_notification.dart';
import 'package:MedAlert/screens/add_medicine_page.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

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

    refreshMedicine();
  }

  Future refreshMedicine() async {
    setState(() => isLoading = true);

    this.medicines = await MedicineDatabase.instance.readAllMedicines();

    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(10, 15, 10, 0),
        child: Center(
          child: isLoading
              ? CircularProgressIndicator()
              : medicines.isEmpty
                  ? Image.asset(
                      'assets\\images\\no_medicines.png',
                      height: 200,
                    )
                  : RefreshIndicator(
                      onRefresh: refreshMedicine,
                      child: ListView(
                        children: medicines
                            .map((medicine) => MedicineTile(
                                medicine.id,
                                medicine.name,
                                medicine.totalAmount,
                                medicine.currentAmount,
                                medicine.color,
                                medicine.amountUnit,
                                this.refreshMedicine))
                            .toList(),
                      ),
                    ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => AddMedicinePage()),
          );

          refreshMedicine();
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}

class MedicineTile extends StatelessWidget {
  final int id;
  final String name;
  final int totalAmount;
  final int currentAmount;
  final String color;
  final String amountUnit;
  final refreshMethod;

  MedicineTile(this.id, this.name, this.totalAmount, this.currentAmount,
      this.color, this.amountUnit, this.refreshMethod);

  @override
  Widget build(BuildContext context) {
    double percentage = (this.currentAmount / this.totalAmount);

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
                  flex: 25,
                  child: Container(
                    height: 70,
                    child: Center(
                      child: CircularPercentIndicator(
                        radius: 55,
                        lineWidth: 5.0,
                        percent: double.parse(percentage.toStringAsFixed(1)),
                        center: new Text(
                          (percentage * 100).toStringAsFixed(1) + '%',
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 12,
                              color: Color(int.tryParse(color))),
                        ),
                        progressColor: Color(int.tryParse(color)),
                        circularStrokeCap: CircularStrokeCap.round,
                      ),
                    ),
                  ),
                ),
                Expanded(
                    flex: 60,
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            this.name,
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(vertical: 3),
                            child: Text(
                              'Available Quantity: ' +
                                  this.currentAmount.toString() + this.amountUnit == 'ml' ? this.amountUnit : 'pills',
                              style: TextStyle(
                                  color: Colors.grey[600], fontSize: 12),
                            ),
                            decoration: BoxDecoration(
                                color: Colors.transparent,
                                borderRadius: BorderRadius.circular(10)),
                          )
                        ],
                      ),
                    )),
                Expanded(
                    flex: 15,
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          PopupMenuButton(
                            icon: Icon(
                              Icons.more_vert,
                              color: Colors.black54,
                            ),
                            itemBuilder: (_) => [
                              PopupMenuItem(
                                  child: InkWell(
                                child: Text(
                                  'Update',
                                  style: TextStyle(color: Colors.black54),
                                ),
                                onTap: () {
                                  Navigator.pop(context);

                                  // Navigator.pushNamed(
                                  //     context, "/updateBeneficiary",
                                  //     arguments: BeneficiaryListItem(
                                  //         this.id,
                                  //         this.name,
                                  //         this.account,
                                  //         this.branch,
                                  //         this.image,
                                  //         this.intraORinter,
                                  //         this.contact,
                                  //         this.favouriteBeneficiaryList,
                                  //         this.refreshMeth));
                                },
                              )),
                              PopupMenuItem(
                                  child: InkWell(
                                child: Text(
                                  'Delete',
                                  style: TextStyle(color: Colors.black54),
                                ),
                                onTap: () => showDialog<String>(
                                  context: context,
                                  builder: (BuildContext context) =>
                                      AlertDialog(
                                    title:
                                        const Text('Are you sure to delete?'),
                                    content:
                                        const Text('This can not be reverted!'),
                                    actions: <Widget>[
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(context, 'Cancel');
                                          Navigator.pop(context);
                                        },
                                        child: const Text('Cancel'),
                                      ),
                                      TextButton(
                                        onPressed: () async {
                                          int deletedId = await MedicineDatabase
                                              .instance
                                              .deleteMedicine(id);
                                          print('deletedId $deletedId');

                                          MedicineDatabase.instance
                                              .deleteReminder(deletedId);

                                          for (int i = 1; i <= 28; i++) {
                                            await localNotification
                                                .deleteOneNotification(
                                                    deletedId + i);
                                          }

                                          refreshMethod();

                                          Navigator.pop(context, 'Delete');
                                          Navigator.pop(context);
                                        },
                                        child: const Text('Delete'),
                                      ),
                                    ],
                                  ),
                                ),
                              )),
                            ],
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
