import 'package:flutter/material.dart';
import 'package:to_do_hive/utils/dialog_box.dart';
import 'package:to_do_hive/utils/to_do_tile.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
//text controller

  final _controller = TextEditingController();

  List toDoList = [
    ["Make tutorial", false],
    ["Do Exercise", false],
  ];

  //checkbox was tapped

  void checkBoxTapped(bool value, int index) {
    setState(() {
      toDoList[index][1] = !toDoList[index][1];
    });
  }

  void onSave() {
    setState(() {
      toDoList.add([_controller.text, false]);
    });
    _controller.clear();
    Navigator.of(context).pop();
  }

  void createNewTask() {
    showDialog(
        context: context,
        builder: (context) {
          return DialogBox(
            controller: _controller,
            onSave: onSave,
            onCancel: () => Navigator.of(context).pop(),
          );
        });
  }

  void deleteTask(int index) {
    setState(() {
      toDoList.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.yellow[200],
          appBar: AppBar(
            backgroundColor: Colors.yellow,
            elevation: 0,
            title: const Text("MY TASKS"),
            centerTitle: true,
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              createNewTask();
            },
            child: const Icon(Icons.add),
            backgroundColor: Colors.yellow,
            shape: const CircleBorder(),
          ),
          body: ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemCount: toDoList.length,
            itemBuilder: (context, index) {
              return ToDoTile(
                taskName: toDoList[index][0],
                taskCompleted: toDoList[index][1],
                onChanged: (value) => checkBoxTapped(toDoList[index][1], index),
                deleteFunction: (context) => deleteTask(index),
              );
            },
          )),
    );
  }
}
