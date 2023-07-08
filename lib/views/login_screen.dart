

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase/controller/auth_controller.dart';
import 'package:flutter_firebase/views/dashboard.dart';
import 'package:flutter_firebase/views/rounded_button.dart';
import 'package:get/get.dart';

class LoginScreen extends StatelessWidget {
  TextEditingController phoneMailEditingController = TextEditingController();
  TextEditingController passwordEditingController = TextEditingController();

  LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.only(left: 25, right: 25),
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Email/Password Login",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),

              const SizedBox(
                height: 25,
              ),

              Container(
                height: 55,
                padding: const EdgeInsets.only(left: 10.0,right: 10.0),
                decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Colors.grey),
                    borderRadius: BorderRadius.circular(10)),
                child:  TextField(
                  controller: phoneMailEditingController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    counterText: "",
                    border: InputBorder.none,
                    hintText: "Email",
                  ),
                  maxLength: 30,
                ),
              ),

              const SizedBox(
                height: 25,
              ),

              Container(
                height: 55,
                padding: const EdgeInsets.only(left: 10.0,right: 10.0),
                decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Colors.grey),
                    borderRadius:  BorderRadius.circular(10)),
                child:   TextField(
                  controller: passwordEditingController,
                  obscureText: true,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: "Password",
                  ),
                ),
              ),

              RoundedButton(
                colour: Colors.lightBlueAccent,
                title: 'Sign In',
                onPressed: () {
                   if(phoneMailEditingController.text.isNotEmpty && passwordEditingController.text.isNotEmpty){
                     if(AuthController.instance.isEmailVerified(phoneMailEditingController.text)){
                       AuthController.instance.login(phoneMailEditingController.text, passwordEditingController.text).then((value) => {
                         if(value.additionalUserInfo != null){
                            Get.offAll(DashBoard()),
                         }
                       });
                     }else{
                       ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Enter valid email")));
                     }
                   }else{
                     ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Fields must not be empty")));
                   }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
