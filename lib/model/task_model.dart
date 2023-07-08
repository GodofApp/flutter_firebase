

import 'package:cloud_firestore/cloud_firestore.dart';

class TaskModel {
  String? docId;
  String? taskName;
  String? taskAssigned;

  TaskModel({this.taskName, this.taskAssigned});

  TaskModel.fromDocumentSnapshot({required DocumentSnapshot documentSnapshot}) {
    docId = documentSnapshot.id;
    taskName = documentSnapshot["task_name"];
    taskAssigned = documentSnapshot["task_assigned"];
  }
}