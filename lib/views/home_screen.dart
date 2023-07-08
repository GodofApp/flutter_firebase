 import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase/controller/auth_controller.dart';
import 'package:flutter_firebase/views/rounded_button.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {

   const HomeScreen({Key? key}) : super(key: key);

   @override
   Widget build(BuildContext context) {
     return Scaffold(
       appBar: AppBar(
         title: Text("Firebase"),
       ),
       backgroundColor: Colors.white,
       body: Padding(
         padding: const EdgeInsets.symmetric(horizontal: 24.0),
         child: Column(
           mainAxisAlignment: MainAxisAlignment.center,
           crossAxisAlignment: CrossAxisAlignment.stretch,
           children: [
             Visibility(
               visible: false,
               child: RoundedButton(
                 colour: Colors.lightBlueAccent,
                 title: 'Login with phone',
                 onPressed: () {
                   Get.toNamed("/mobileNumber");
                 },
               ),
             ),

             RoundedButton(
               colour: Colors.lightBlueAccent,
               title: 'Log In With Google',
               onPressed: () {
                 AuthController.instance.signInWithGoogle();
               },
             ),

             RoundedButton(
               colour: Colors.lightBlueAccent,
               title: 'Log In',
               onPressed: () {
                 Get.toNamed("/loginScreen");
               },
             ),

             RoundedButton(
               colour: Colors.lightBlueAccent,
               title: 'Register',
               onPressed: () {
                 Get.toNamed("/registerScreen");
               },
             ),
           ],
         ),
       ),
     );
   }
 }
