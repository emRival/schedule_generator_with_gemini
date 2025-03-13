
import 'package:flutter/material.dart';

class GenerateScheduleButton extends StatelessWidget {
  final bool isLoading;
  final VoidCallback onPressed;

  const GenerateScheduleButton({
    required this.isLoading,
    required this.onPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: isLoading
          ? SizedBox(
              width: 20,
              height: 20,
              child: const CircularProgressIndicator(
                strokeWidth: 1,
                color: Colors.amber,
              ),
            )
          : const Icon(
              Icons.schedule,
              color: Colors.white,
            ),
      label: isLoading
          ? const Text(
              "Generating...",
              style: TextStyle(color: Colors.white),
            )
          : const Text(
              "Generate Schedule",
              style: TextStyle(color: Colors.white),
            ),
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        backgroundColor: Colors.green,
      ),
    );
  }
}
