import 'package:MedAlert/db/database_helper.dart';
import 'package:flutter/material.dart';
import '../widgets/member.dart';
import '../screens/tabs_screen.dart';
import '../screens/new_member_screen.dart';
import '../model/member.dart';

class MemberList extends StatefulWidget {
  @override
  _MemberListState createState() => _MemberListState();
}

class _MemberListState extends State<MemberList> {
  bool isLoading = false;
  List<Member> members = [];

  @override
  void initState() {
    super.initState();
    getAllMembers();
  }

  Future getAllMembers() async {
    print('here');
    setState(() => isLoading = true);
    this.members = await MedicineDatabase.instance.readAllMembers();
    print(this.members);
    this.members.map((e) => print(e.name));
    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: refreshList,
      child: Column(
        children: <Widget>[
          Container(
            child: SingleChildScrollView(
              child: isLoading ? Center(child: CircularProgressIndicator()) : this.members.isEmpty
                  ? Center(
                      child: Image.asset(
                        'assets\\images\\no_member.png',
                        height: 175,
                      ),
                    )
                  : Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        SizedBox(
                          height: 120.0,
                          child: ListView(
                            physics: ClampingScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            children: this
                                .members
                                .map((member) => MemberProfile(member))
                                .toList(),
                          ),
                        ),
                      ],
                    ),
            ),
          )
        ],
      ),
    );
  }

  int r = 0;
  add() {
    setState(() {
      r = r + 1;

      getAllMembers();
    });
  }

  Future<Null> refreshList() async {
    await Future.delayed(Duration(seconds: 0));
    add();
    return null;
  }
}
