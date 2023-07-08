

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase/controller/auth_controller.dart';
import 'package:flutter_firebase/views/rounded_button.dart';
import 'package:get/get.dart';

class RegisterScreen extends StatelessWidget {
  final TextEditingController fisrtName = TextEditingController();
  final TextEditingController passwordEditingController = TextEditingController();
  final TextEditingController phoneOrEmail = TextEditingController();

  RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Register"),
      ),
      body: Container(
        margin: const EdgeInsets.only(left: 25, right: 25),
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Column(
            children: [
             /* const Text(
                "Register",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),*/

              const SizedBox(
                height: 25,
              ),

              Container(
                height: 55,
                padding: const EdgeInsets.only(left: 10.0,right: 10.0),
                decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Colors.grey),
                    borderRadius: BorderRadius.circular(10)),
                child:   TextField(
                  controller: fisrtName,
                  decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: "First Name"
                  ),

                ),
              ),
              const SizedBox(height: 25,),

              Container(
                height: 55,
                padding: const EdgeInsets.only(left: 10.0,right: 10.0),
                decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Colors.grey),
                    borderRadius: BorderRadius.circular(10)),
                child:   TextField(
                  controller: phoneOrEmail,
                  decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: "Email Id"
                  ),

                ),
              ),
              const SizedBox(height: 25,),


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
                title: 'Sign Up',
                onPressed: () {
                  if(fisrtName.text.isNotEmpty && phoneOrEmail.text.isNotEmpty && passwordEditingController.text.isNotEmpty) {
                    if (AuthController.instance.isEmailVerified(
                        phoneOrEmail.text)) {
                      AuthController.instance.register(
                          phoneOrEmail.text, passwordEditingController.text).then((value) => {
                            if(value.additionalUserInfo != null){
                              Get.offAllNamed("/dashboard"),
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
