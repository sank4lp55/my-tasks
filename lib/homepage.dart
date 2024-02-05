import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:to_do_hive/data/database.dart';
import 'package:to_do_hive/utils/dialog_box.dart';
import 'package:to_do_hive/utils/to_do_tile.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  //reference the hive box
  final _myBox = Hive.box("myBox");

  ToDoDatabase db = ToDoDatabase();

  @override
  void initState() {
    // TODO: implement initState
    //check if this is the first time opening the app
    if (_myBox.get("TODOLIST") == null) {
      db.createInitialData();
    } else {
      //already exist data
      db.loadData();
    }

    super.initState();
  }

  //text controller
  final _controller = TextEditingController();

  //checkbox was tapped

  void checkBoxTapped(bool value, int index) {
    setState(() {
      db.toDoList[index][1] = !db.toDoList[index][1];
    });
    db.updateData();
  }

  void onSave() {
    setState(() {
      db.toDoList.add([_controller.text, false]);
    });
    _controller.clear();
    Navigator.of(context).pop();
    db.updateData();
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
      db.toDoList.removeAt(index);
    });
    db.updateData();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.yellow[200],
          appBar: AppBar(
            backgroundColor: Colors.yellow,
            elevation: 0,
            title: const Text(
              "MY TASKS",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
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
            itemCount: db.toDoList.length,
            itemBuilder: (context, index) {
              return ToDoTile(
                taskName: db.toDoList[index][0],
                taskCompleted: db.toDoList[index][1],
                onChanged: (value) =>
                    checkBoxTapped(db.toDoList[index][1], index),
                deleteFunction: (context) => deleteTask(index),
              );
            },
          )),
    );
  }
}
