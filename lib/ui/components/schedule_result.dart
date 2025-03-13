import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ScheduleResult extends StatelessWidget {
  final List<Map<String, dynamic>> morningTasks;
  final List<Map<String, dynamic>> afternoonTasks;
  final List<Map<String, dynamic>> eveningTasks;
  final List<String> suggestions;
  final AnimationController animationController;

  const ScheduleResult({
    required this.morningTasks,
    required this.afternoonTasks,
    required this.eveningTasks,
    required this.suggestions,
    required this.animationController,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        buildTaskList("Pagi", morningTasks, animationController),
        buildTaskList("Siang", afternoonTasks, animationController),
        buildTaskList("Malam", eveningTasks, animationController),
        Padding(
          padding: const EdgeInsets.only(top: 16),
          child: Text(
            "Saran:",
            style:
                GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        ...suggestions.map((saran) => ListTile(
              leading: Icon(Icons.lightbulb, color: Colors.amber),
              title: Text(saran, style: GoogleFonts.poppins()),
            )),
      ],
    );
  }
}

Widget buildTaskList(String title, List<Map<String, dynamic>> taskList,
    AnimationController animationController) {
  return SizeTransition(
    sizeFactor: animationController,
    child: Card(
      color: Colors.blueAccent.shade100,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            const SizedBox(height: 8),
            if (taskList.isEmpty)
              Text("Tidak ada tugas.",
                  style: GoogleFonts.poppins(color: Colors.white)),
            ...taskList.map((task) => ListTile(
                  title: Text(task['task'] ?? 'Task',
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      )),
                  subtitle: Text("Waktu: ${task['time'] ?? 'Tidak ditentukan'}",
                      style: GoogleFonts.poppins(color: Colors.white70)),
                )),
          ],
        ),
      ),
    ),
  );
}
