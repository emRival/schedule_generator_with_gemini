
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ErrorMessageCard extends StatelessWidget {
  final String scheduleResult;

  const ErrorMessageCard({
    required this.scheduleResult,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.redAccent,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Icon(Icons.dangerous, color: Colors.white),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                scheduleResult,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.poppins(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
