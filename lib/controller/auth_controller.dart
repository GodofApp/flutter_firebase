

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_firebase/views/dashboard.dart';
import 'package:flutter_firebase/views/home_screen.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../views/login_screen.dart';

class AuthController extends GetxController{

  static AuthController instance = Get.find<AuthController>();
  late Rx<User?> firebaseUser;
  FirebaseAuth auth = FirebaseAuth.instance;

  late UserCredential userCredential;

  String? verificationCode;

  late Rx<GoogleSignInAccount?> googleSignInAccount;
  GoogleSignIn googleSign = GoogleSignIn();

  @override
  void onInit() {
    super.onInit();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      firebaseUser = Rx<User?>(auth.currentUser);
      googleSignInAccount = Rx<GoogleSignInAccount?>(googleSign.currentUser);

      firebaseUser.bindStream(auth.userChanges());
      // ever(firebaseUser,_initialScreen);
      // _initialScreen(firebaseUser);


      googleSignInAccount.bindStream(googleSign.onCurrentUserChanged);
      // ever(googleSignInAccount, _setInitialScreenGoogle);
      // _setInitialScreenGoogle(googleSignInAccount);
    });
  }

  _initialScreen(Rx<User?> user){
    if(user.value == null){
      Get.offAll(const HomeScreen());
    }else{
      Get.offAll(DashBoard());
    }
  }

  _setInitialScreenGoogle(Rx<GoogleSignInAccount?> googleSignInAccount) {
    print(googleSignInAccount);
    if (googleSignInAccount == null && googleSignInAccount.value == null) {
      // if the user is not found then the user is navigated to the Register Screen
      Get.offAll(const HomeScreen());
    } else {
      // if the user exists and logged in the the user is navigated to the Home Screen
      Get.offAll(DashBoard());
    }
  }

  Future signInWithGoogle() async {
    try {
      await googleSign.signOut();
      GoogleSignInAccount? googleSignInAccount = await googleSign.signIn();

      if (googleSignInAccount != null) {
        GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;

        AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken,
        );

        await auth.signInWithCredential(credential).then((value) => {
              if(value.user != null){
                   Get.offAll(DashBoard()),
              }
        });
      }
    } catch (e) {
      Get.snackbar(
        "Error",
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
      print(e.toString());
    }
  }

  bool checkMobileNumber(String mobileNumber){
    if(mobileNumber.isNotEmpty){
      bool value = mobileNumber.startsWith(RegExp("[6-9]"));
      // print(value);
      // print(mobileNumber);
      if(value){
        bool isValid = isPhoneNoValid(mobileNumber);
        if (!isValid) {
          return false;
        } else {
          return true;
        }
      }else{
        return false;
      }
    }else{
      return false;
    }
    // else{
    //   errfnd(true);
    // }
  }

  bool isPhoneNoValid(String phoneNo) {
    final regExp =
    RegExp(r'^(?:(?:\+|0{0,2})91(\s*[\-]\s*)?|[0]?)?[6789]\d{9}$');
    return regExp.hasMatch(phoneNo);
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

  Future signOut(BuildContext context) async {
    await auth.signOut().then((value) => {
      SystemNavigator.pop()
    });
  }

  void getOpt(String phone,BuildContext context) async {
    try {
      await FirebaseAuth.instance.verifyPhoneNumber(
          phoneNumber: '+91$phone',
          verificationCompleted: (PhoneAuthCredential credential) async {},
          verificationFailed: (FirebaseAuthException e) {
            ScaffoldMessenger.of(context).showSnackBar( SnackBar(content: Text(e.toString())));
            print(e.toString());
          },
          codeSent: (String? verficationID, int? resendToken) {
            verificationCode = verficationID!;
          },
          codeAutoRetrievalTimeout: (String verificationID) {
            verificationCode = verificationID;

          },
          timeout: const Duration(seconds: 120));
    } on FirebaseAuthException catch (error) {
      ScaffoldMessenger.of(context).showSnackBar( SnackBar(content: Text(error.toString())));
    }
  }

  void showSnackbar(String message, [int seconds = 2]) {
    GetSnackBar(
        messageText: Text(
          message,
          style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w500,
              fontFamily: "Roboto",
              fontStyle: FontStyle.normal,
              fontSize: 11.5),
        ),
        duration: Duration(seconds: seconds),
        backgroundColor: Colors.green,
        snackPosition: SnackPosition.BOTTOM)
        .show();
  }

}