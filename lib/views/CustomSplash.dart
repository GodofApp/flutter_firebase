

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase/views/dashboard.dart';
import 'package:flutter_firebase/views/home_screen.dart';

class CustomSplash extends StatelessWidget {
  const CustomSplash ({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if(snapshot.hasData){
            return  DashBoard();
          }else{
            return const HomeScreen();
          }
        });
  }
}
