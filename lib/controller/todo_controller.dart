import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase/controller/auth_controller.dart';
import 'package:flutter_firebase/model/task_model.dart';
import 'package:get/get.dart';

class TodoController extends GetxController{
  // final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  late CollectionReference collectionReference;

  var taskList = List<TaskModel>.empty(growable: true).obs;

  final TextEditingController taskNameController = TextEditingController();
  final TextEditingController taskDescController = TextEditingController();

  @override
  void onReady() {
    super.onReady();
    taskList.bindStream(todoStream());
  }


  Future<void> addTodo(TaskModel taskModel,BuildContext buildContext) async {
    // formKey.currentState!.save();
    await firebaseFirestore
        .collection('users')
        .doc(AuthController.instance.auth.currentUser!.uid)
        .collection('tasks')
        .add({
      'task_assigned': taskModel.taskAssigned,
      'task_name': taskModel.taskName,
    });
  }

  Stream<List<TaskModel>> todoStream() {
    return firebaseFirestore
        .collection('users')
        .doc(AuthController.instance.auth.currentUser?.uid)
        .collection('tasks')
        .snapshots()
        .map((QuerySnapshot query) {
      List<TaskModel> todos = [];
      for (var todo in query.docs) {
        final todoModel =
        TaskModel.fromDocumentSnapshot(documentSnapshot: todo);
        todos.add(todoModel);
      }
      return todos;
    });
  }

  Future<void> updateStatus(TaskModel taskModel, documentId,BuildContext context) async {
    firebaseFirestore
        .collection('users')
        .doc(AuthController.instance.auth.currentUser!.uid)
        .collection('tasks')
        .doc(documentId)
        .update(
      {
        'task_assigned': taskModel.taskAssigned,
        'task_name': taskModel.taskName,
      },
    );
  }

  void clearAll(){
    taskNameController.text = "";
    taskDescController.text = "";
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