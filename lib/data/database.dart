import 'package:hive/hive.dart';

class ToDoDatabase {
  List toDoList = [];

  //reference the box

  final _myBox = Hive.box("myBox");

  // run this method first time ever opening the app
  void createInitialData() {
    toDoList = [
      ["Make tutorial", false],
      ["Do Exercise", false],
    ];
  }

  //load data from database
  void loadData() {
    toDoList = _myBox.get("TODOLIST");
  }

  //update databse
  void updateData() {
    _myBox.put("TODOLIST", toDoList);
  }
}
