

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase/controller/auth_controller.dart';
import 'package:flutter_firebase/views/alert_dialog.dart';
import 'package:flutter_firebase/views/rounded_button.dart';
import 'package:get/get.dart';

import '../colors.dart';
import '../controller/todo_controller.dart';

class DashBoard extends StatelessWidget {

  TodoController todoController = Get.put(TodoController());


  DashBoard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Dashboard"),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: (){
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialogTask(id: "",taskName: "",taskDesc: "",);
              },
            );
          },
          backgroundColor: Colors.black,
          child: const Icon(Icons.add),
        ),
        body: Padding(
          padding: const EdgeInsets.only(left: 10,right: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              RoundedButton(
                colour: Colors.lightBlueAccent,
                title: 'Sign Out',
                onPressed: () {
                  AuthController.instance.signOut(context);
                },
              ),

              Obx(() =>
                  todoController.taskList.isNotEmpty ?
                  ListView.builder(
                shrinkWrap: true,
                itemCount: todoController.taskList.length,
                itemBuilder: (context, index) {
                   return Padding(
                     padding: const EdgeInsets.all(8.0),
                     child: Container(
                       decoration: BoxDecoration(
                         borderRadius: BorderRadius.circular(15.0),
                         color: Colors.white,
                         boxShadow: const [
                           BoxShadow(
                             color: AppColors.shadowColor,
                             blurRadius: 5.0,
                             offset: Offset(0, 5), // shadow direction: bottom right
                           ),
                         ],
                       ),
                       child: Padding(
                         padding: const EdgeInsets.all(15.0),
                         child: Row(
                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                           crossAxisAlignment: CrossAxisAlignment.center,
                           children: [
                             Column(
                               mainAxisAlignment: MainAxisAlignment.center,
                               crossAxisAlignment: CrossAxisAlignment.start,
                               children: [
                                 Row(
                                   children: [
                                     Text("Task Name:"),
                                     Text(todoController.taskList.elementAt(index).taskName.toString()),
                                   ],
                                 ),

                                 Row(
                                   children: [
                                     Text("Task Assigned:"),
                                     Text(todoController.taskList.elementAt(index).taskAssigned.toString()),
                                   ],
                                 ),
                               ],
                             ),

                             InkWell(
                               onTap: (){
                                 showDialog(
                                   context: context,
                                   builder: (context) {
                                  return AlertDialogTask(id: todoController.taskList.elementAt(index).docId.toString()
                                     ,taskName: todoController.taskList.elementAt(index).taskName.toString()
                                     ,taskDesc: todoController.taskList.elementAt(index).taskAssigned.toString(),);
                                 },);
                               },
                               child: const Icon(
                                 Icons.edit,
                                 size: 20,
                               ),
                             )
                           ],
                         ),
                       )
                     ),
                   );
                },
              ) :
                  Text('No tasks to display')

              )
            ],
          ),
        ),
    );
  }



}
