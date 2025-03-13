import 'package:flutter/material.dart';
import 'package:schedule_generator/services/gemini_service.dart';
import 'package:schedule_generator/ui/components/error_message_card.dart';
import 'package:schedule_generator/ui/components/generate_schedule_button.dart';
import 'package:schedule_generator/ui/components/loading_shimmer.dart';
import 'package:schedule_generator/ui/components/schedule_result.dart';
import 'package:schedule_generator/ui/components/task_list.dart';
import 'package:schedule_generator/ui/components/text_input_field.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  final List<Map<String, dynamic>> tasks = [];
  final TextEditingController taskController = TextEditingController();
  final TextEditingController durationController = TextEditingController();
  String? deadline;
  String? priority;
  String scheduleResult = "";
  bool isLoading = false;

  List<Map<String, dynamic>> morningTasks = [];
  List<Map<String, dynamic>> afternoonTasks = [];
  List<Map<String, dynamic>> eveningTasks = [];
  List<String> suggestions = [];

  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _addTask() {
    if (taskController.text.isNotEmpty &&
        durationController.text.isNotEmpty &&
        priority != null) {
      setState(() {
        tasks.add({
          "name": taskController.text,
          "priority": priority,
          "duration": int.tryParse(durationController.text) ?? 30,
          "deadline": deadline,
        });
      });
      taskController.clear();
      durationController.clear();
    }
  }

  Future<void> _generateSchedule() async {
    setState(() => isLoading = true);
    try {
      final result = await GeminiService.generateSchedule(tasks);
      if (result.containsKey('error')) {
        setState(() {
          scheduleResult = result['error'];
          morningTasks.clear();
          afternoonTasks.clear();
          eveningTasks.clear();
        });
        setState(() => isLoading = false);
        return;
      }
      setState(() {
        morningTasks = List<Map<String, dynamic>>.from(result['morning'] ?? []);
        afternoonTasks =
            List<Map<String, dynamic>>.from(result['afternoon'] ?? []);
        eveningTasks = List<Map<String, dynamic>>.from(result['evening'] ?? []);
        suggestions = List<String>.from(result['suggestions'] ?? []);
        scheduleResult = "";
      });
      _animationController.forward(from: 0.0);
    } catch (e) {
      setState(() {
        scheduleResult = "Gagal menghasilkan jadwal. Error: $e";
        morningTasks.clear();
        afternoonTasks.clear();
        eveningTasks.clear();
      });
    }
    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Schedule Generator"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Input fields
              TaskInputFields(
                taskController: taskController,
                durationController: durationController,
                priority: priority,
                onPriorityChanged: (value) => setState(() => priority = value),
                deadline: deadline,
                onDeadlineChanged: (value) => setState(() => deadline = value!),
                onAddTask: _addTask,
              ),
              const SizedBox(height: 16),
              if (tasks.isNotEmpty)
                // Task list
                TaskList(
                    tasks: tasks,
                    onRemoveTask: (task) {
                      setState(() {
                        tasks.remove(task);
                      });
                    }),
              const SizedBox(height: 16),
              if (tasks.isNotEmpty)
                // Generate schedule button
                GenerateScheduleButton(
                  isLoading: isLoading,
                  onPressed: _generateSchedule,
                ),
              const SizedBox(height: 20),
              // Schedule result
              if (scheduleResult.isNotEmpty && !isLoading)
                ErrorMessageCard(scheduleResult: scheduleResult),
              if (isLoading) LoadingShimmer(),
              if (!isLoading &&
                  scheduleResult.isEmpty &&
                  (morningTasks.isNotEmpty ||
                      afternoonTasks.isNotEmpty ||
                      eveningTasks.isNotEmpty))
                ScheduleResult(
                  morningTasks: morningTasks,
                  afternoonTasks: afternoonTasks,
                  eveningTasks: eveningTasks,
                  suggestions: suggestions,
                  animationController: _animationController,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
