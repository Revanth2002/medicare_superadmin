import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medicare_superadmin/services/auth_service.dart';
import 'package:medicare_superadmin/ui/approvals/requestAprrovals.dart';
import 'package:medicare_superadmin/ui/doctors/doctors.dart';
import 'package:medicare_superadmin/ui/patients/patients.dart';
import 'package:medicare_superadmin/ui/rejected/rejectedDoctors.dart';
import 'package:medicare_superadmin/utils/colors.dart';
import 'package:vertical_tabs/vertical_tabs.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> with SingleTickerProviderStateMixin {
  TextStyle style = GoogleFonts.getFont("Cairo",fontSize: 16,color: Colors.grey[700],fontWeight: FontWeight.bold);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: DashboardBar,
        title: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(left: 32),
                child: Text(
                  "Medicare Admin",
                  style: GoogleFonts.getFont('Cairo',
                      fontSize: 24,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,)
                ),
              ),
            ]),
        actions: [
          Container(
            child: IconButton(
              padding: EdgeInsets.only(right: 30),
              icon: Icon(Icons.exit_to_app),
              onPressed: () {
                print("Logged out");
                AuthHelper.logOut();
              },
            ),
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: Container(
        child: VerticalTabs(
            tabsWidth: 200,
            indicatorColor: Colors.deepOrange,
            contentScrollAxis: Axis.vertical,
            tabsShadowColor: Colors.red,
            indicatorSide: IndicatorSide.start,
            initialIndex: 0,
            changePageCurve: Curves.easeInToLinear,
            changePageDuration: Duration(microseconds: 1),
            selectedTabTextStyle: TextStyle(color: Colors.pink),
            tabs: <Tab>[
              Tab(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    children: [
                      Expanded(child: Icon(Icons.info,size: 20,color: Colors.deepPurple,)),
                      Expanded(flex:3,child: Text("Requests",style: style,)),
                    ],
                  ),
                ),
              ),
              Tab(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    children: [
                      Expanded(child: Icon(Icons.medical_services,size: 20,color: Colors.deepPurple)),
                      Expanded(flex:3,child: Text("Doctor",style: style,)),
                    ],
                  ),
                ),
              ),
              Tab(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    children: [
                      Expanded(child: Icon(Icons.cancel,size: 20,color: Colors.deepPurple)),
                      Expanded(flex:3,child: Text("Rejected",style: style,)),
                    ],
                  ),
                ),
              ),
              Tab(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    children: [
                      Expanded(child: Icon(Icons.person,size: 20,color: Colors.deepPurple)),
                      Expanded(flex:3,child: Text("Patient",style: style,)),
                    ],
                  ),
                ),
              ),
            ],
          contents: <Widget>[
            Requests(),
            Doctor(),
            RejectedDoctor(),
            Patients(),

            ],
        ),
      )
    );
  }
}
