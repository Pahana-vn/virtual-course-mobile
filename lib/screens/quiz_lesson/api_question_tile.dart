import 'package:flutter/material.dart';
import '../../models/question_dto.dart';

class ApiQuestionTile extends StatefulWidget {
  final QuestionDTO question;
  final int questionIndex;
  final int totalQuestions;
  final List<int> selectedOptionIds;
  final Function(List<int>) onAnswerSelected;

  const ApiQuestionTile({
    super.key,
    required this.question,
    required this.questionIndex,
    required this.totalQuestions,
    required this.selectedOptionIds,
    required this.onAnswerSelected,
  });

  @override
  State<ApiQuestionTile> createState() => _ApiQuestionTileState();
}

class _ApiQuestionTileState extends State<ApiQuestionTile> {
  late List<int> selectedOptionIds;

  @override
  void initState() {
    super.initState();
    selectedOptionIds = List<int>.from(widget.selectedOptionIds);
  }

  @override
  void didUpdateWidget(covariant ApiQuestionTile oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.selectedOptionIds != widget.selectedOptionIds) {
      setState(() {
        selectedOptionIds = List<int>.from(widget.selectedOptionIds);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Question ${widget.questionIndex + 1} of ${widget.totalQuestions}",
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 10),
            Text(
              widget.question.content,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            if (widget.question.type == "MULTIPLE")
              const Padding(
                padding: EdgeInsets.only(top: 8),
                child: Text(
                  "Chọn tất cả các đáp án đúng.",
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                ),
              ),
            const SizedBox(height: 20),

            Column(
              children: widget.question.answerOptions.map((option) {
                final isSelected = selectedOptionIds.contains(option.id);

                return GestureDetector(
                  onTap: () {
                    setState(() {
                      if (widget.question.type == "MULTIPLE") {
                        if (isSelected) {
                          selectedOptionIds.remove(option.id);
                        } else {
                          selectedOptionIds.add(option.id);
                        }
                      } else {
                        selectedOptionIds = [option.id];
                      }
                    });

                    widget.onAnswerSelected(selectedOptionIds);
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: isSelected ? Colors.blue : Colors.grey),
                      color: isSelected ? Colors.blueAccent.withOpacity(0.2) : Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            option.content,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: isSelected ? Colors.blueAccent : Colors.black,
                            ),
                          ),
                        ),
                        if (widget.question.type == "MULTIPLE")
                          Checkbox(
                            value: isSelected,
                            onChanged: (bool? value) {
                              setState(() {
                                if (value != null) {
                                  if (value) {
                                    selectedOptionIds.add(option.id);
                                  } else {
                                    selectedOptionIds.remove(option.id);
                                  }
                                }
                              });
                              widget.onAnswerSelected(selectedOptionIds);
                            },
                            activeColor: Colors.blueAccent,
                          ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}