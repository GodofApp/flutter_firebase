/*


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_firebase/constants.dart';
import 'package:flutter_firebase/controller/auth_controller.dart';
import 'package:flutter_firebase/model/task_model.dart';

class FirestoreDb {

  static addTodo(TaskModel taskModel) async {
    await Constants().firebaseFirestore
        .collection('tasks')
        .doc(AuthController.instance.auth.currentUser!.uid)
        .collection('tasks')
        .add({
      'task_assigned': taskModel.taskAssigned,
      'task_name': taskModel.taskName,
    });
  }

  static Stream<List<TaskModel>> todoStream() {
    return firebaseFirestore
        .collection('users')
        .doc(auth.currentUser!.uid)
        .collection('todos')
        .snapshots()
        .map((QuerySnapshot query) {
      List<TodoModel> todos = [];
      for (var todo in query.docs) {
        final todoModel =
        TodoModel.fromDocumentSnapshot(documentSnapshot: todo);
        todos.add(todoModel);
      }
      return todos;
    });
  }

  static updateStatus(bool isDone, documentId) {
    firebaseFirestore
        .collection('users')
        .doc(auth.currentUser!.uid)
        .collection('todos')
        .doc(documentId)
        .update(
      {
        'isDone': isDone,
      },
    );
  }
  static deleteTodo(String documentId) {
    firebaseFirestore
        .collection('users')
        .doc(auth.currentUser!.uid)
        .collection('todos')
        .doc(documentId)
        .delete();
  }
}*/
