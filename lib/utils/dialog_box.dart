import 'package:flutter/material.dart';
import 'package:to_do_hive/utils/my_button.dart';

class DialogBox extends StatelessWidget {
  final controller;

  VoidCallback onSave;
  VoidCallback onCancel;
  DialogBox(
      {super.key,
      required this.controller,
      required this.onSave,
      required this.onCancel});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.yellow[300],
      content: Container(
        height: 120,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            //get user input
            TextField(
              controller: controller,
              decoration: InputDecoration(
                  border: OutlineInputBorder(), hintText: "Add a new task"),
            ),

            //buttons->save+cancel

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                MyButton(
                  text: "Save",
                  onPressed: () => onSave(),
                  //onPressed : onSave     //above or this // onPressed: () => onSave,  //this wont work because we are not calling the fiunction just putting the fiunction as a whole there.
                ),
                MyButton(
                  text: "Cancel",
                  onPressed: () => onCancel(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
