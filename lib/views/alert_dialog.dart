

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase/controller/todo_controller.dart';
import 'package:flutter_firebase/model/task_model.dart';
import 'package:get/get.dart';

class AlertDialogTask extends StatelessWidget {

  TodoController todoController = Get.find<TodoController>();
  String id,taskName,taskDesc;

  AlertDialogTask({Key? key,required this.id,required this.taskName,required this.taskDesc}) : super(key: key){
    todoController.taskNameController.text = taskName;
    todoController.taskDescController.text = taskDesc;
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return AlertDialog(
      scrollable: true,
      title: const Text(
        'New Task',
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 16, color: Colors.brown),
      ),
      content: SizedBox(
        height: height * 0.20,
        width: width,
        child: Form(
          child: Column(
            children: <Widget>[
              TextFormField(
                controller: todoController.taskNameController,
                style: const TextStyle(fontSize: 14),
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 20,
                  ),
                  hintText: 'Task',
                  hintStyle: const TextStyle(fontSize: 14),
                  icon: const Icon(CupertinoIcons.square_list, color: Colors.brown),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              TextFormField(
                controller: todoController.taskDescController,
                keyboardType: TextInputType.multiline,
                maxLines: null,
                style: const TextStyle(fontSize: 14),
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 20,
                  ),
                  hintText: 'Description',
                  hintStyle: const TextStyle(fontSize: 14),
                  icon: const Icon(CupertinoIcons.bubble_left_bubble_right, color: Colors.brown),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      actions: [
        ElevatedButton(
          onPressed: () {
            Navigator.of(context, rootNavigator: true).pop();
          },
          style: ElevatedButton.styleFrom(
            primary: Colors.grey,
          ),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            if(todoController.taskNameController.text.isNotEmpty && todoController.taskDescController.text.isNotEmpty) {
              final taskName = todoController.taskNameController.text;
              final taskDesc = todoController.taskDescController.text;
              TaskModel taskModel = TaskModel(taskName: taskName, taskAssigned: taskDesc);
              if(id.isNotEmpty) {
                todoController.updateStatus(taskModel,id, context).whenComplete(() =>
                  {
                    todoController.showSnackbar("Task updated"),
                    todoController.taskList.bindStream(todoController.todoStream()),
                    todoController.clearAll(),
                  }
                );
              }else{
                todoController.addTodo(taskModel, context).whenComplete(() => {
                  todoController.showSnackbar("Task created"),
                  todoController.taskList.bindStream(todoController.todoStream()),
                  todoController.clearAll(),
                });
              }
              Navigator.of(context, rootNavigator: true).pop();
            }else{
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Field must not be empty")));
            }
          },
          child: const Text('Save'),
        ),
      ],
    );
  }
}
