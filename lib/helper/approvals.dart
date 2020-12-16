
import 'package:cloud_firestore/cloud_firestore.dart';

class RequestApprovals{
  final db = FirebaseFirestore.instance;
  deleteRequest(docRef) async {
    await db.collection("requestdoctor").doc(docRef).delete().catchError((e){
      print(e);
    });
    await db.collection("requestdoctor").doc(docRef).collection("image").doc().delete().catchError((e){
      print(e);
    });
    await db.collection("requestdoctor").doc(docRef).collection("license").doc().delete().catchError((e){
      print(e);
    });
    await db.collection("requestdoctor").doc(docRef).collection("qualification").doc().delete().catchError((e){
      print(e);
    });
  }

  addUser(docRef,data) async{
    await db.collection("users").doc(docRef).collection("profile").doc().set(data).catchError((e){
      print(e);
    });
  }

}