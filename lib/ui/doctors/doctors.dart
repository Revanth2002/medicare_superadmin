import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:medicare_superadmin/models/doctor.dart';
import 'package:medicare_superadmin/services/database_services.dart';

import '../../widgets.dart';

class Doctor extends StatefulWidget {
  @override
  _DoctorState createState() => _DoctorState();
}

class _DoctorState extends State<Doctor> {
  TextEditingController _searchController = new TextEditingController();

  final doctorRetrieve = db.collection("users").where("status",isEqualTo: "approved").snapshots();

  bool hoveredCount = false;

  Future resultsLoaded;
  List _allResults= [];
  List _resultList =[];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose(){
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();

  }

  @override
  void didChangeDependencies(){
    super.didChangeDependencies();
    resultsLoaded = getDoctorDetails();
  }

  _onSearchChanged(){
    searchResultList();
  }

  searchResultList(){
    var  showResults = [];
    if(_searchController.text!=""){
      for(var doctorSnapshot in _allResults){
        var doctorId = DoctorRecords.fromSnapshot(doctorSnapshot).docIdNo.toLowerCase();
        var name = DoctorRecords.fromSnapshot(doctorSnapshot).name.toLowerCase();
        if(doctorId.contains(_searchController.text.toLowerCase())){
          showResults.add(doctorSnapshot);
          print(showResults);
        }
        if(name.contains(_searchController.text.toLowerCase())){
          showResults.add(doctorSnapshot);
          print(showResults);
        }
      }
    }else{
      showResults = List.from(_allResults);
    }
    setState(() {
      _resultList = showResults;
    });
  }

  getDoctorDetails()async{
    var data = await db.collection("users").where("status",isEqualTo: "approved").get();
    setState(() {
      _allResults = data.docs;
    });
    searchResultList();
    return "complete";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white70,
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 30,top: 15),
                    child: Text("Doctors",style: title,),
                  ),
                  SizedBox(height: 10,),
                  StreamBuilder(
                    stream: db.collection("users").where("status",isEqualTo: "approved").snapshots(),
                    builder: (BuildContext context,AsyncSnapshot<QuerySnapshot>snapshot){
                      if(!snapshot.hasData){
                        return Container(
                            width: double.infinity,
                            height: 90,
                            color: Colors.grey[50],
                            child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 30,vertical: 15),
                                child:  MouseRegion(
                                  onEnter: (value){
                                    setState(() {
                                      hoveredCount= true;
                                    });
                                  },
                                  onExit: (value){
                                    setState(() {
                                      hoveredCount= false;
                                    });
                                  },
                                  child: AnimatedContainer(
                                    duration: Duration(milliseconds: 275),
                                    height: hoveredCount ? 58.0 : 55.0,
                                    width: hoveredCount ? double.infinity+10 : double.infinity-10,
                                    decoration: BoxDecoration(
                                        color: hoveredCount ? Colors.deepPurple : Colors.white,
                                        borderRadius: BorderRadius.circular(15.0),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.black12,
                                            blurRadius: 20.0,
                                            spreadRadius: 5.0,
                                          ),
                                        ]),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          flex: 6,
                                          child: Padding(
                                            padding: const EdgeInsets.only(left: 20),
                                            child: Text("Service Doctor Count ",style: hoveredCount ? title.copyWith(color: Colors.white,fontSize: 16):title.copyWith(color: Colors.pink,fontSize: 16),),
                                          ),
                                        ),
                                        Expanded(
                                            flex: 1,
                                            child: Center(child: CircularProgressIndicator.adaptive(backgroundColor: Colors.deepPurple))

                                        )
                                      ],
                                    ),
                                  ),
                                )
                            )
                        );
                      }
                      return Container(
                          width: double.infinity,
                          height: 90,
                          color: Colors.grey[50],
                          child: FutureBuilder(
                            builder: (context, index){
                              return Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 30,vertical: 15),
                                  child:  MouseRegion(
                                    onEnter: (value){
                                      setState(() {
                                        hoveredCount= true;
                                      });
                                    },
                                    onExit: (value){
                                      setState(() {
                                        hoveredCount= false;
                                      });
                                    },
                                    child: AnimatedContainer(
                                      duration: Duration(milliseconds: 275),
                                      height: hoveredCount ? 58.0 : 55.0,
                                      width: hoveredCount ? double.infinity+10 : double.infinity-10,
                                      decoration: BoxDecoration(
                                          color: hoveredCount ? Colors.deepPurple : Colors.white,
                                          borderRadius: BorderRadius.circular(15.0),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.black12,
                                              blurRadius: 20.0,
                                              spreadRadius: 5.0,
                                            ),
                                          ]),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                            flex: 6,
                                            child: Padding(
                                              padding: const EdgeInsets.only(left: 20),
                                              child: Text("Service Doctor Count",style: hoveredCount ? title.copyWith(color: Colors.white,fontSize: 16):title.copyWith(color: Colors.pink,fontSize: 16),),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: Text(snapshot.data.docs.length.toString(),style: hoveredCount ? title.copyWith(color: Colors.white,fontSize: 30):title.copyWith(color: Colors.pink,fontSize: 22)),

                                          )
                                        ],
                                      ),
                                    ),
                                  )
                              );
                            },
                          )
                      );
                    },
                  ),
                  SizedBox(height: 10,),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40,vertical: 5),
                    child: Center(
                      child: Container(
                        height: 50,
                        child: TextField(
                          controller: _searchController,
                          textInputAction: TextInputAction.search,
                          cursorColor: Colors.grey,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.only(left: 20,top: 10),
                            fillColor: Colors.grey.withOpacity(0.1),
                            filled: true,
                            border: InputBorder.none,
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                              new BorderSide(color: Colors.grey),
                              borderRadius: new BorderRadius.circular(5),
                            ),
                            hintText: "Search by Doctor ID/Name",
                            hintStyle: TextStyle(color: Colors.grey,fontSize: 20),
                            suffixIcon: Icon(
                              Icons.search,
                              size: 25,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10,),
                  Expanded(
                    child: ListView.builder(
                        itemCount: _resultList.length,
                        itemBuilder: (BuildContext context,int index){
                          return buildDoctorCard(context,_resultList[index]);
                        }
                    ),
                  ),

                    ],
                    ),
            )
          ],
        ),
      ),
    );
  }
}
