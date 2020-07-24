import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pomodoro/components/app_bar.dart';
import 'package:pomodoro/models/user.dart';
import 'package:pomodoro/models/task.dart';
import 'package:pomodoro/models/category.dart';

class TasksAddPage extends StatefulWidget {
  User user;

  @override
  _TasksAddPageState createState() => _TasksAddPageState();
}

class _TasksAddPageState extends State<TasksAddPage> {
  final taskNameController = TextEditingController();
  final taskDurationWorkController = TextEditingController();
  final taskDurationBreakController = TextEditingController();
  final taskGoalTimeController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    taskNameController.dispose();
    super.dispose();
  }

  String dropdownValue = 'Category';
  List<Categories> categories;
  int workTime;
  int breakTime;
  int goalTime;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar('Add a Task', this.widget.user),
      body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextFormField(
                controller: taskNameController,
                autofocus: false,
                decoration: InputDecoration(
                    labelText: 'Task Name', border: OutlineInputBorder()),
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: taskDurationWorkController,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                autofocus: false,
                onChanged: (value) {
                  setState(() {
                    workTime = int.tryParse(value);
                  });
                },
                decoration: InputDecoration(
                    labelText: 'Task Duration (Minutes)',
                    border: OutlineInputBorder()),
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: taskDurationBreakController,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                autofocus: false,
                onChanged: (value) {
                  setState(() {
                    breakTime = int.tryParse(value);
                  });
                },
                decoration: InputDecoration(
                    labelText: 'Break Duration (Minutes)',
                    border: OutlineInputBorder()),
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: taskGoalTimeController,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                autofocus: false,
                onChanged: (value) {
                  setState(() {
                    goalTime = int.tryParse(value);
                  });
                },
                decoration: InputDecoration(
                    labelText: 'Goal (Minutes)', border: OutlineInputBorder()),
              ),
              SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.only(left: 12),
                alignment: Alignment.topLeft,
                child: DropdownButton<String>(
                  value: dropdownValue,
                  icon: Icon(Icons.arrow_downward),
                  iconSize: 21,
                  elevation: 16,
                  style: TextStyle(color: Colors.grey[700]),
                  onChanged: (String newValue) {
                    setState(() {
                      dropdownValue = newValue;
                    });
                  },
                  items: <String>[
                    'Category',
                    'School',
                    'Work',
                    'Exercise',
                    'Home',
                    'Family',
                    'Other'
                  ].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              )
            ],
          )),
      floatingActionButton: FloatingActionButton(
        // When the user presses the button, show an alert dialog containing
        // the text that the user has entered into the text field.
        onPressed: submit,
        tooltip: 'Submit',
        child: Icon(Icons.save),
      ),
    );
  }

  void submit() {
    this.widget.user = ModalRoute.of(context).settings.arguments;
    User user = this.widget.user;
    Task newTask = Task(
        name: taskNameController.text,
        durationWork: workTime,
        durationBreak: breakTime,
        goalTime: goalTime,
        category: dropdownValue);

    user.tasks.add(newTask);

    Navigator.of(context).pop();
  }
}
