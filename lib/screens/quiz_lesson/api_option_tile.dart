import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lms_app/screens/quiz_lesson/quiz_screen.dart';
import '../../models/question_dto.dart';

class ApiOptionTile extends ConsumerWidget {
  final QuestionDTO question;
  final int optionIndex;
  final int? selectedOption;

  const ApiOptionTile({
    super.key,
    required this.question,
    required this.optionIndex,
    required this.selectedOption,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final answerOption = question.answerOptions[optionIndex];
    final bool isSelected = selectedOption == optionIndex;

    return GestureDetector(
      onTap: () {
        ref.read(selectedOptionProvider.notifier).state = optionIndex;
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isSelected ? Colors.blueAccent : Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.blueAccent),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                answerOption.content,
                style: TextStyle(
                  color: isSelected ? Colors.white : Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            if (isSelected)
              const Icon(
                Icons.check_circle,
                color: Colors.white,
              ),
          ],
        ),
      ),
    );
  }
}