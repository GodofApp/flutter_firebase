

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase/views/dashboard.dart';
import 'package:flutter_firebase/views/home_screen.dart';
import 'package:get/get.dart';

import '../views/login_screen.dart';

class AuthController extends GetxController{

  static AuthController instance = Get.find();
  late Rx<User?> firebaseUser;
  FirebaseAuth auth = FirebaseAuth.instance;

  late UserCredential userCredential;

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();

    firebaseUser = Rx<User?>(auth.currentUser);
    firebaseUser.bindStream(auth.userChanges());
    ever(firebaseUser,_initialScreen);

  }

  _initialScreen(User? user){
    if(user == null){
      Get.offAllNamed("/homeScreen");
    }else{
      Get.offAllNamed("/dashboard");
    }
  }

  bool isEmailVerified(String emailId) {
    // Null or empty string is invalid
    if (emailId == null || emailId.isEmpty) {
      return false;
      // isEmailVerify(false);
    }

    const pattern = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
    final regExp = RegExp(pattern);

    if (regExp.hasMatch(emailId)) {
      return true;
    } else {
      return false;
    }
  }


  Future<UserCredential> register(String email,password) async{
    try {
      userCredential = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
    } catch (firebaseAuthException) {
        Get.snackbar("User", "User message",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          titleText: const Text(
              "Account creation failed",
               style: TextStyle(
              color: Colors.white
          ),
          )
        );
    }

    return userCredential;
  }

  Future<UserCredential> login(String email, password) async {
    try {
      userCredential = await auth.signInWithEmailAndPassword(email: email, password: password);
    } catch (firebaseAuthException) {
      Get.snackbar("User", "User message",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          titleText: const Text(
            "User Not found",
            style: TextStyle(
                color: Colors.white
            ),
          )
      );
    }

    return userCredential;
  }

  Future<void> signOut() async {
    await auth.signOut();
  }

}