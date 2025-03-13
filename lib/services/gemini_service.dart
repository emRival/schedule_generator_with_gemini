import 'dart:convert';
import 'dart:developer';

import 'package:google_generative_ai/google_generative_ai.dart';

class GeminiService {
  static const String apiKey =
      "AIzaSyCLHw1rGWVddWKFQxwALfaMZ3oFxBK6Mi0"; // Ganti dengan API key Anda

  static Future<Map<String, dynamic>> generateSchedule(
      List<Map<String, dynamic>> tasks) async {
    final prompt = _buildPrompt(tasks);

    final model = GenerativeModel(
      model: 'gemini-1.5-flash',
      apiKey: apiKey,
      generationConfig: GenerationConfig(
        temperature: 1,
        topK: 40,
        topP: 0.95,
        maxOutputTokens: 8192,
        responseMimeType: 'text/plain',
      ),
    );

    final chat = model.startChat(history: [
      Content.multi([
        TextPart(
            'You are a student creating a realistic daily schedule. Consider task priority, duration, breaks, and energy levels throughout the day. Ensure tasks are balanced and practical. Provide output in JSON format with "morning", "afternoon", and "evening" sections. Each task should have "task" and "time" fields. Always include a schedule recommendation section titled "suggestions". add more emoticon and Do not include any additional text outside the JSON structure.')
      ]),
    ]);

    final content = Content.text(prompt);

    try {
      final response = await chat.sendMessage(content);
      final responseText =
          (response.candidates.first.content.parts.first as TextPart).text;

      if (responseText.isEmpty) {
        return {'error': 'No response from Gemini'};
      }

      // Ambil hanya JSON dari teks Gemini (jika ada tambahan teks lain)
      RegExp jsonPattern = RegExp(r'\{.*\}', dotAll: true);
      Match? match = jsonPattern.firstMatch(responseText);

      if (match != null) {
        return json.decode(match.group(0)!);
      }

      return json.decode(responseText);
    } catch (e) {
      log('Error generating schedule: $e');
      return {'error': 'Failed to generate schedule\n$e'};
    }
  }

  static String _buildPrompt(List<Map<String, dynamic>> tasks) {
    String taskList = tasks
        .map((task) =>
            "- ${task['name']} (Prioritas: ${task['priority']}, Durasi: ${task['duration']} menit, Deadline: ${task['deadline']})")
        .join("\n");

    return "Buatkan jadwal harian yang optimal untuk tugas-tugas berikut: \n$taskList\nSusun jadwal dari pagi hingga malam dengan efisien dan berikan output dalam format JSON.";
  }
}
