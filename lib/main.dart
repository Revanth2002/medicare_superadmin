import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:medicare_superadmin/services/auth_service.dart';
import 'package:medicare_superadmin/ui/dashboard.dart';
import 'package:medicare_superadmin/ui/login.dart';

//TODO adminhom ui/home ui/utlis authhelper/
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'User Based Auth',
      //home: AdminHomePageMQ(),
      home: MainScreen(),
    );
  }
}

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if(snapshot.hasData && snapshot.data != null) {
            return StreamBuilder<DocumentSnapshot>(
              stream: FirebaseFirestore.instance.collection("Admin").doc(snapshot.data.uid).snapshots() ,
              builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot){
                if(snapshot.hasData && snapshot.data != null) {
                  final userDoc = snapshot.data;
                  final user = userDoc.data();
                  if(user['role'] == 'superadmin') {
                    return Dashboard();
                  }
                  else{
                    return null;
                  }
                }
                else{
                  return Material(
                    child: Center(child: CircularProgressIndicator(),),
                  );
                }
              },
            );
          }
          return LoginPage();
        }
    );
  }
}

/*
*
//TODO adminhom ui/home ui/utlis authhelper/
void main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Medicare-SuperAdmin',
      //home: AdminHomePageMQ(),
      home: AuthService().handleAuth(),
    );
  }
}

*/







