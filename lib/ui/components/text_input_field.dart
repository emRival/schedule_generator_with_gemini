import 'package:flutter/material.dart';

class TaskInputFields extends StatelessWidget {
  final TextEditingController taskController;
  final TextEditingController durationController;
  final String? priority;
  final String? deadline;
  final ValueChanged<String?> onPriorityChanged;
  final ValueChanged<String?> onDeadlineChanged;
  final VoidCallback onAddTask;

  const TaskInputFields({
    required this.taskController,
    required this.durationController,
    required this.priority,
    required this.onPriorityChanged,
    required this.onAddTask,
    required this.deadline,
    required this.onDeadlineChanged,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          controller: taskController,
          decoration: InputDecoration(
            labelText: "Nama Tugas",
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          ),
        ),
        const SizedBox(height: 10),
        TextField(
          controller: durationController,
          decoration: InputDecoration(
            labelText: "Durasi (menit)",
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          ),
          keyboardType: TextInputType.number,
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  label: const Text("Prioritas"),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
                value: priority,
                hint: const Text("Pilih Prioritas"),
                onChanged: onPriorityChanged,
                items: ["Tinggi", "Sedang", "Rendah"]
                    .map((priorityMember) => DropdownMenuItem(
                          value: priorityMember,
                          child: Text(priorityMember),
                        ))
                    .toList(),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    label: const Text("Deadline"),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                  value: deadline,
                  hint: const Text("Pilih Deadline"),
                  items: ["Hari ini", "Besok", "Lusa"]
                      .map((deadlineMember) => DropdownMenuItem(
                          value: deadlineMember, child: Text(deadlineMember)))
                      .toList(),
                  onChanged: onDeadlineChanged),
            ),
          ],
        ),
        const SizedBox(height: 10),
        ElevatedButton.icon(
          onPressed: onAddTask,
          icon: const Icon(Icons.add, color: Colors.white),
          label: const Text("Tambahkan Tugas",
              style: TextStyle(color: Colors.white)),
          style: ElevatedButton.styleFrom(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            backgroundColor: Colors.blueAccent,
          ),
        ),
      ],
    );
  }
}
