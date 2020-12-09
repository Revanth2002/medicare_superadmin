import 'package:flutter/material.dart';
import 'package:medicare_superadmin/services/auth_service.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink,
      body: RaisedButton(
       onPressed: (){
          AuthHelper.logOut();
       },
        child: Text("Log Out"),
      ),
    );
  }
}
