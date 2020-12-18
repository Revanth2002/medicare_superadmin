import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:medicare_superadmin/helper/approvals.dart';
import 'package:medicare_superadmin/services/database_services.dart';
import 'package:medicare_superadmin/widgets.dart';
import 'package:url_launcher/url_launcher.dart';

class Requests extends StatefulWidget {
  @override
  _RequestsState createState() => _RequestsState();
}

class _RequestsState extends State<Requests> {

  bool hoveredCount = false;

  var savedString = '';

  ScrollController _scrollController;



  RequestApprovals _requestApprovals = new RequestApprovals();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _scrollController = ScrollController();
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
                    child: Text("New Doctor Request",style: title,),
                  ),
                  SizedBox(height: 10,),
                  StreamBuilder(
                  stream: db.collection("users").where("status",isEqualTo: "waiting").snapshots(),
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
                                        child: Text("Requests Count ",style: hoveredCount ? title.copyWith(color: Colors.white,fontSize: 16):title.copyWith(color: Colors.pink,fontSize: 16),),
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
                                          child: Text("Requests Count ",style: hoveredCount ? title.copyWith(color: Colors.white,fontSize: 16):title.copyWith(color: Colors.pink,fontSize: 16),),
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
                  Expanded(
                    child: StreamBuilder(
                    stream: db.collection("requestdoctor").snapshots(),
                    builder: (BuildContext context,AsyncSnapshot<QuerySnapshot>snapshot) {
                      if(!snapshot.hasData){
                        return Center(
                          child: CircularProgressIndicator(
                            backgroundColor: Colors.deepPurple,
                          ),
                        );
                      }
                      return Scrollbar(
                        isAlwaysShown: true,
                        controller: _scrollController,
                        child: ListView.builder(
                          controller: _scrollController,
                          itemCount: snapshot.data.docs.length,
                          itemBuilder: (BuildContext context,int i){
                            final snap = snapshot.data.docs[i];
                            final docId = snapshot.data.docs[i].id;

                            return ExpansionTile(
                              subtitle:Text(snap['hospital'],style: sub.copyWith(color: Colors.grey[400],fontSize: 15),),
                              title: Row(
                                children: [
                                  Expanded(
                                      flex:3,
                                      child: Text(snap['name'],style: name,)),
                                ],
                              ),
                              children: [
                                Container(
                                  child: Card(
                                    clipBehavior: Clip.antiAlias,
                                    child: Padding(
                                      padding: EdgeInsets.all(16),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                           mainAxisAlignment: MainAxisAlignment.start,
                                         children: [
                                           Expanded(
                                               flex:1,
                                               child: Text("Name : ",style: content,)),
                                           Expanded(
                                               flex:2,
                                               child: Text(snap['name'],style: sub.copyWith(fontWeight: FontWeight.w500,color: Colors.purple),)),
                                         ],
                                         ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              Expanded(
                                                  flex:1,
                                                  child: Text("Specialist : ",style: content,)),
                                              Expanded(
                                                  flex:2,
                                                  child: Text(snap['specialist'],style: sub.copyWith(fontWeight: FontWeight.w500,color: Colors.purple),)),
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              Expanded(
                                                  flex:1,
                                                  child: Text("Hospital : ",style: content,)),
                                              Expanded(
                                                  flex:2,
                                                  child: Text(snap['hospital'],style: sub.copyWith(fontWeight: FontWeight.w500,color: Colors.purple),)),
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              Expanded(
                                                  flex:1,
                                                  child: Text("Experience : ",style: content,)),
                                              Expanded(
                                                  flex:2,
                                                  child: Text(snap['experience'],style: sub.copyWith(fontWeight: FontWeight.w500,color: Colors.purple),)),
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              Expanded(
                                                  flex:1,
                                                  child: Text("Qualification : ",style: content,)),
                                              Expanded(
                                                  flex:2,
                                                  child: Text(snap['qualification'],style: sub.copyWith(fontWeight: FontWeight.w500,color: Colors.purple),)),
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              Expanded(
                                                  flex:1,
                                                  child: Text("Contact : ",style: content,)),
                                              Expanded(
                                                  flex:2,
                                                  child: Text(snap['contact'],style: sub.copyWith(fontWeight: FontWeight.w500,color: Colors.purple),)),
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              Expanded(
                                                  flex:1,
                                                  child: Text("Mail : ",style: content,)),
                                              Expanded(
                                                  flex:2,
                                                  child: Text(snap['mail'],style: sub.copyWith(fontWeight: FontWeight.w500,color: Colors.purple),)),
                                            ],
                                          ),
                                          SizedBox(height: 5,),
                                          StreamBuilder(
                                            stream:db.collection("requestdoctor").doc(docId).collection("image").snapshots(),
                                            builder: (BuildContext context,AsyncSnapshot<QuerySnapshot>snapshot){
                                              if(!snapshot.hasData)return Container();
                                              return ListView.builder(
                                                  shrinkWrap: true,
                                                  itemCount: snapshot.data.docs.length,
                                                  itemBuilder: (BuildContext context, int i) {
                                                    return Container(
                                                        child: Row(
                                                          children: [
                                                            Expanded(
                                                                flex:1,
                                                                child: Text("Image",style: content,)),
                                                            Expanded(
                                                              flex:2,
                                                              child: RaisedButton(onPressed: () async {
                                                                final data = {"img": snapshot.data.docs[i]["img"]};
                                                                var url = snapshot.data.docs[i]["img"];
                                                                await db.collection("users").doc(docId).collection("profile").doc("image").set(data);
                                                                if (await canLaunch(url)) {
                                                                await launch(url);
                                                                } else {
                                                                throw 'Could not launch $url';
                                                                }
                                                              },
                                                                color: Colors.pinkAccent,
                                                                child: Text("Open Image ",style: title.copyWith(color: Colors.white,fontSize: 14),),splashColor: Colors.white,),
                                                            )
                                                          ],
                                                        ));
                                                  });
                                            },
                                          ),
                                          SizedBox(height: 5,),
                                          StreamBuilder(
                                            stream:db.collection("requestdoctor").doc(docId).collection("license").snapshots(),
                                            builder: (BuildContext context,AsyncSnapshot<QuerySnapshot>snapshot){
                                              if(!snapshot.hasData)return Container();
                                              return ListView.builder(
                                                  shrinkWrap: true,
                                                  itemCount: snapshot.data.docs.length,
                                                  itemBuilder: (BuildContext context, int i) {
                                                    return Container(
                                                        child: Row(
                                                          children: [
                                                            Expanded(
                                                                flex:1,
                                                                child: Text("Medical License",style: content,)),
                                                            Expanded(
                                                              flex:2,
                                                              child: RaisedButton(onPressed: () async {
                                                                final data = {"license": snapshot.data.docs[i]["license"]};
                                                                var url = snapshot.data.docs[i]["license"];
                                                                await db.collection("users").doc(docId).collection("profile").doc("license").set(data);
                                                                if (await canLaunch(url)) {
                                                                await launch(url);
                                                                } else {
                                                                throw 'Could not launch $url';
                                                                }
                                                              },
                                                                color: Colors.pinkAccent,
                                                                child: Text("Open License ",style: title.copyWith(color: Colors.white,fontSize: 14),),splashColor: Colors.white,),
                                                            )
                                                          ],
                                                        ));
                                                  });
                                            },
                                          ),
                                          SizedBox(height: 5,),
                                          StreamBuilder(
                                            stream:db.collection("requestdoctor").doc(docId).collection("qualification").snapshots(),
                                            builder: (BuildContext context,AsyncSnapshot<QuerySnapshot>snapshot){
                                              if(!snapshot.hasData)return Container();
                                              return ListView.builder(
                                                  shrinkWrap: true,
                                                  itemCount: snapshot.data.docs.length,
                                                  itemBuilder: (BuildContext context, int i) {
                                                    return Container(
                                                        child: Row(
                                                          children: [
                                                            Expanded(
                                                                flex:1,
                                                                child: Text("Qualification",style: content,)),
                                                            Expanded(
                                                              flex:2,
                                                              child: RaisedButton(onPressed: () async {
                                                                final data = {"qualification_file": snapshot.data.docs[i]["qualification"]};
                                                                var url = snapshot.data.docs[i]["qualification"];
                                                                await db.collection("users").doc(docId).collection("profile").doc("qualification").set(data);
                                                                if (await canLaunch(url)) {
                                                                await launch(url);
                                                                } else {
                                                                throw 'Could not launch $url';
                                                                }
                                                              },
                                                                color: Colors.pinkAccent,
                                                                child: Text("Open qualification ",style: title.copyWith(color: Colors.white,fontSize: 14),),splashColor: Colors.white,),
                                                            )
                                                          ],
                                                        ));
                                                  });
                                            },
                                          ),
                                          SizedBox(height: 15,),
                                          Row(
                                            children: [
                                              Expanded(
                                                child: InkWell(
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      border: Border.all(
                                                        color: Colors.red[200],
                                                        width: 1.5
                                                      ),
                                                      borderRadius: BorderRadius.circular(10)
                                                    ),
                                                    height: 40,
                                                  child: Center(
                                                    child: Text("Reject",style: title.copyWith(color: Colors.red[200],fontSize: 15),),
                                                  ),
                                                  ),
                                                  onTap:() async {
                                                    showDialog(
                                                        context: context,
                                                        builder: (content) =>AlertDialog(
                                                          content: Text("Are you sure ,you want to reject this doctor portfolio??",style: TextStyle(fontFamily: "Cairo",fontSize: 18),),
                                                          actions: [
                                                            FlatButton(
                                                                child: Text("Cancel"),
                                                                onPressed: () async {
                                                                  Navigator.pop(context);
                                                                }
                                                            ),
                                                            FlatButton(
                                                                child: Text("Reject",style: TextStyle(fontFamily: "CairoBold",color: Colors.red,fontWeight: FontWeight.bold),),
                                                                onPressed: () async {
                                                                  var docIdNo = DateTime.now().millisecondsSinceEpoch.toString();
                                                                  final details = {
                                                                    "docIdNo" : docIdNo,
                                                                    "contact": snap['contact'],
                                                                    "experience":snap['experience'],
                                                                    "hospital":snap['hospital'],
                                                                    "mail" : snap["mail"],
                                                                    "name" : snap["name"],
                                                                    "qualification" : snap["qualification"],
                                                                    "specialist" : snap["specialist"]
                                                                  };
                                                                  await _requestApprovals.addUser(docId, details);
                                                                  await db.collection("users").doc(docId).update({'name':snap["name"],"docIdNo" : docIdNo,});
                                                                  await db.collection("users").doc(docId).update({"status":"rejected"});
                                                                 await _requestApprovals.deleteRequest(docId);
                                                                  Navigator.pop(context);
                                                                  print("rejected");
                                                                }
                                                            ),
                                                          ],
                                                        )
                                                    );
                                                  },
                                                ),
                                              ),
                                              SizedBox(width: 40,),
                                              Expanded(
                                                child: InkWell(
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                        color: Colors.green[200],
                                                        borderRadius: BorderRadius.circular(10)
                                                    ),
                                                    height: 40,
                                                    child: Center(
                                                      child: Text("Accept",style: title.copyWith(color: Colors.white,fontSize: 15),),
                                                    ),
                                                  ),
                                                  onTap:() async {
                                                    showDialog(
                                                        context: context,
                                                        builder: (content) =>AlertDialog(
                                                          content: Text("Your are about to provide permission to this doctor!!",style: TextStyle(fontFamily: "Cairo",fontSize: 18),),
                                                          actions: [
                                                            FlatButton(
                                                                child: Text("Cancel"),
                                                                onPressed: () async {
                                                                  Navigator.pop(context);
                                                                }
                                                            ),
                                                            FlatButton(
                                                                child: Text("Approve",style: TextStyle(fontFamily: "CairoBold",color: Colors.green,fontWeight: FontWeight.bold),),
                                                                onPressed: () async {
                                                                  var docIdNo = DateTime.now().millisecondsSinceEpoch.toString();
                                                                  print(docIdNo);
                                                                  final details = {
                                                                    "docIdNo": docIdNo,
                                                                    "contact": snap['contact'],
                                                                    "experience":snap['experience'],
                                                                    "hospital":snap['hospital'],
                                                                    "mail" : snap["mail"],
                                                                    "name" : snap["name"],
                                                                    "qualification" : snap["qualification"],
                                                                    "specialist" : snap["specialist"]
                                                                  };
                                                                  await _requestApprovals.addUser(docId, details);
                                                                  await db.collection("users").doc(docId).update({'name':snap["name"],"docIdNo" : docIdNo,});
                                                                  await db.collection("users").doc(docId).update({"status":"approved"});
                                                                  await _requestApprovals.deleteRequest(docId);
                                                                  Navigator.pop(context);
                                                                  print("approved");
                                                                }
                                                            ),
                                                          ],
                                                        )
                                                    );
                                                  },
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      );
                    }
                    ),
                  ),
                  SizedBox(height: 60,),
                ],
                ),
              ),
            ],
          ),
        ));
  }
}
















