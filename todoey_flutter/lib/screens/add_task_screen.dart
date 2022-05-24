import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:todoey_flutter/models/task.dart';

class AddTaskScreen extends StatefulWidget {
  final List<Task> tasks;
  final Function onTap;

  AddTaskScreen({required this.tasks, required this.onTap});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xff757575),
        border: Border.all(
          color: Color(0xff757575),
          width: 0,
        ),
      ),
      child: Container(
        padding: EdgeInsets.zero,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: Color(0xff757575),
            width: 0,
          ),
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 50.0,
            vertical: 20.0,
          ),
          child: Column(
            children: [
              Text(
                'Add Task',
                style: TextStyle(
                  color: Colors.lightBlueAccent,
                  fontSize: 24.0,
                ),
              ),
              TextField(
                autofocus: true,
                textAlign: TextAlign.center,
                controller: textEditingController,
              ),
              SizedBox(
                height: 20.0,
              ),
              Container(
                width: double.infinity,
                height: 45,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.lightBlueAccent,
                    shape: RoundedRectangleBorder(),
                  ),
                  onPressed: () {
                    widget.onTap(textEditingController.text);
                    textEditingController.clear();
                  },
                  child: Text('Add'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
