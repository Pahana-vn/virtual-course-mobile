import 'package:flutter/material.dart';

class ApiQuizComplete extends StatelessWidget {
  final int score;
  final bool passed;

  const ApiQuizComplete({super.key, required this.score, required this.passed});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Quiz Result")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              margin: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.grey.shade300),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(color: Colors.grey.shade200, spreadRadius: 2, blurRadius: 5),
                ],
              ),
              child: Column(
                children: [
                  const Text("Your Score:", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
                  const SizedBox(height: 10),
                  Text(
                    "$score out of 100",
                    style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: passed ? Colors.green : Colors.red),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    passed ? "🎉 Congratulations! You Passed!" : "❌ Unfortunately, You failed.",
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                backgroundColor: Colors.blueAccent,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              ),
              child: const Text("Try Again", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}
