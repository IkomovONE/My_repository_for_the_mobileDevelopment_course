import 'package:chumtalk/main_page.dart';
import 'package:chumtalk/groups.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();


    if (FirebaseAuth.instance.currentUser != null) {

      runApp(MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Groups(),
      ),);
    }
    else {
      runApp(MainPage());
    }



}






