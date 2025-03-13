import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class TaskList extends StatelessWidget {
  final List<Map<String, dynamic>> tasks;
  final ValueChanged<Map<String, dynamic>> onRemoveTask;

  const TaskList({
    required this.tasks,
    required this.onRemoveTask,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: tasks
          .map((task) => Card(
                child: ListTile(
                  leading: const Icon(FontAwesomeIcons.listCheck,
                      color: Colors.blue),
                  title: Text(task['name']),
                  subtitle: Text(
                      "Prioritas: ${task['priority']} | Durasi: ${task['duration']} menit | deadline: ${task['deadline']}"),
                  trailing: IconButton(
                      onPressed: () => onRemoveTask(task),
                      icon: Icon(
                        Icons.delete,
                        color: Colors.red,
                      )),
                ),
              ))
          .toList(),
    );
  }
}
