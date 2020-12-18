import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:medicare_superadmin/models/doctor.dart';
import 'package:medicare_superadmin/models/patient.dart';
import 'package:medicare_superadmin/ui/doctors/secondScreen.dart';
import 'package:medicare_superadmin/ui/rejected/detailRejectedScreen.dart';

TextStyle name = GoogleFonts.cairo(color: Colors.deepPurple,fontSize: 17,fontWeight: FontWeight.bold);
TextStyle sub = GoogleFonts.quicksand(color: Colors.black,fontSize: 15,fontWeight: FontWeight.bold);
TextStyle content = GoogleFonts.quicksand(color: Colors.black.withOpacity(0.7),fontSize: 14,fontWeight: FontWeight.bold);
TextStyle title = GoogleFonts.quicksand(color: Colors.black,fontSize: 18,fontWeight: FontWeight.bold);
TextStyle mainTitleDoctorTile = GoogleFonts.caladea(color: Colors.deepPurple,fontSize: 18,fontWeight: FontWeight.bold);
TextStyle subtitleDoctorTile = GoogleFonts.caladea(color: Colors.purpleAccent,fontSize: 16,fontWeight: FontWeight.w500);
TextStyle prefix = GoogleFonts.cairo(color: Colors.grey[700],fontSize: 20,fontWeight: FontWeight.w500);
TextStyle suffix = GoogleFonts.cairo(color: Colors.pink,fontSize: 22,fontWeight: FontWeight.w700);

Widget buildPatientCard(BuildContext context, DocumentSnapshot document) {

  TextStyle title = TextStyle(color: Colors.black,fontFamily: "CairoBold",fontSize: 18);
  TextStyle subtitle = TextStyle(color: Colors.grey,fontFamily: "CairoBold",fontSize: 16);
  final patient = PatientRecords.fromSnapshot(document);

  return new Container(
    padding: EdgeInsets.symmetric(horizontal: 12),
    child: Card(
      shadowColor: Colors.deepPurple,
      borderOnForeground: true,
      elevation: 3,
      child: InkWell(
        onTap: (){
         // Navigator.of(context).push(CupertinoPageRoute(builder: (context)=>DetailPatientMobile(patientDetails: patient)));
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                child: Row(
                  children: [
                    Image.network(patient.img,fit: BoxFit.fill,width: 50,height: 50,),
                    Expanded(
                      flex: 3,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AutoSizeText(
                              patient.name,
                              maxLines: 2,
                              maxFontSize: 17,
                              style: title,overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              patient.id,
                              style: subtitle,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Icon(Icons.navigate_next,color: Colors.deepPurple,size: 35,),
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

Widget buildDoctorCard(BuildContext context, DocumentSnapshot document) {

  final doctor = DoctorRecords.fromSnapshot(document);

  return new Container(
    child: Card(
      child: InkWell(
        onTap: (){
          doctor.status == "approved" ? Navigator.of(context).push(CupertinoPageRoute(builder: (context)=>DisplayDetails(doctorRecords: doctor,)))
              :Navigator.of(context).push(CupertinoPageRoute(builder: (context)=>RejectedDoctorDetails(doctorRecords: doctor,)));
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                child: Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AutoSizeText(
                              doctor.name,
                              maxLines: 2,
                              maxFontSize: 17,
                              style: mainTitleDoctorTile,overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              doctor.docIdNo,
                              style: subtitleDoctorTile,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Icon(Icons.description,size: 24,color: Colors.indigo,),
                    Icon(Icons.navigate_next,color: Colors.deepPurple,size: 35,),
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


