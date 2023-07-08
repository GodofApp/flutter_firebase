

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase/controller/auth_controller.dart';
import 'package:flutter_firebase/views/rounded_button.dart';
import 'package:get/get.dart';

class MobileNumber extends StatelessWidget {

  TextEditingController phoneController = TextEditingController();

  MobileNumber ({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Mobile Number"),
      ),
      body: Container(
        margin: const EdgeInsets.only(left: 20, right: 20),
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                "Phone Login",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                height: 55,
                padding: const EdgeInsets.only(left: 10.0,right: 10.0),
                decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Colors.grey),
                    borderRadius: BorderRadius.circular(10)),
                child:  TextField(
                  controller: phoneController,
                  keyboardType:TextInputType.phone,
                  decoration: const InputDecoration(
                    counterText: "",
                    prefixText: '+91',
                    border: InputBorder.none,
                    hintText:" Enter Mobile Number",
                  ),
                  maxLength:10,

                ),
              ),

              const SizedBox(
                height: 20,
              ),


              RoundedButton(
                colour: Colors.lightBlueAccent,
                title: 'Submit',
                onPressed: () {
                  if(phoneController.text.isNotEmpty){
                    if(AuthController.instance.checkMobileNumber(phoneController.text)){
                      Get.toNamed("/otpScreen");
                    }else{
                      AuthController.instance.showSnackbar("Enter valid mobile number");
                    }
                  }else{
                    AuthController.instance.showSnackbar("Field must not be empty");
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
