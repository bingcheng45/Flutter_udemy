import 'package:flutter/material.dart';

class TaskTile extends StatelessWidget {
  final bool isDone;
  final String title;
  final Function(bool?)? checkboxCallback;

  TaskTile(
      {required this.isDone,
      required this.title,
      required this.checkboxCallback});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        title,
        style: TextStyle(
          decoration: isDone ? TextDecoration.lineThrough : TextDecoration.none,
        ),
      ),
      trailing: Checkbox(
        activeColor: Colors.lightBlueAccent,
        value: isDone,
        onChanged: checkboxCallback,
      ),
    );
  }
}
