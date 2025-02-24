import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../models/question_dto.dart';
import '../../models/test_submission_dto.dart';
import '../../providers/api_question_provider.dart';
import '../../providers/api_test_provider.dart';
import 'api_question_tile.dart';
import 'api_quiz_completete.dart';

final selectedAnswersProvider = StateProvider.autoDispose<Map<int, List<int>>>((ref) => {});
final currentPageIndexProvider = StateProvider.autoDispose<int>((ref) => 0);

class ApiQuizScreen extends ConsumerStatefulWidget {
  final int courseId;
  final int studentId;
  final int testId;

  const ApiQuizScreen({super.key, required this.courseId, required this.studentId, required this.testId});

  @override
  ConsumerState<ApiQuizScreen> createState() => _ApiQuizScreenState();
}

class _ApiQuizScreenState extends ConsumerState<ApiQuizScreen> {
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    final questions = ref.watch(questionsByTestProvider(widget.courseId));

    return Scaffold(
      appBar: AppBar(
        title: const Text("Test"),
      ),
      body: questions.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) => Center(child: Text('Error: $error')),
        data: (questions) {
          return Column(
            children: [
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: questions.length,
                  onPageChanged: (index) {
                    ref.read(currentPageIndexProvider.notifier).state = index;
                  },
                  itemBuilder: (context, index) {
                    final question = questions[index];
                    return ApiQuestionTile(
                      question: question,
                      questionIndex: index,
                      totalQuestions: questions.length,
                      selectedOptionIds: ref.watch(selectedAnswersProvider)[question.id] ?? [],
                      onAnswerSelected: (selectedOptionIds) {
                        _updateAnswer(question.id, selectedOptionIds);
                      },
                    );
                  },
                ),
              ),
              _buildNavigationButtons(context, questions.length, questions),
            ],
          );
        },
      ),
    );
  }

  Widget _buildNavigationButtons(BuildContext context, int totalQuestions, List<QuestionDTO> questions) {
    final currentPageIndex = ref.watch(currentPageIndexProvider);
    final selectedAnswers = ref.watch(selectedAnswersProvider);

    bool isAnswered = selectedAnswers.containsKey(questions[currentPageIndex].id) &&
        selectedAnswers[questions[currentPageIndex].id]!.isNotEmpty;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (currentPageIndex > 0)
            ElevatedButton(
              onPressed: () {
                _pageController.previousPage(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.ease,
                );
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                backgroundColor: Colors.blueAccent,
              ),
              child: const Text("Previous", style: TextStyle(fontSize: 16, color: Colors.white)),
            )
          else
            const SizedBox(width: 100),

          ElevatedButton(
            onPressed: isAnswered
                ? () {
              if (currentPageIndex < totalQuestions - 1) {
                _pageController.nextPage(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.ease,
                );
              } else {
                _submitTest();
              }
            }
                : null,
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              backgroundColor: isAnswered ? Colors.blueAccent : Colors.grey,
            ),
            child: Text(
              currentPageIndex < totalQuestions - 1 ? "Next" : "Submit",
              style: const TextStyle(fontSize: 16, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  void _updateAnswer(int questionId, List<int> selectedOptionIds) {
    ref.read(selectedAnswersProvider.notifier).update((state) {
      final newState = Map<int, List<int>>.from(state);
      newState[questionId] = selectedOptionIds;
      return newState;
    });
  }

  void _submitTest() {
    final submission = TestSubmissionDTO(
      testId: widget.testId,
      studentId: widget.studentId,
      answers: ref.read(selectedAnswersProvider).entries
          .map((entry) => StudentAnswerDTO(questionId: entry.key, selectedOptionIds: entry.value))
          .toList(),
    );

    ref.read(testSubmissionProvider(submission).future).then((result) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => ApiQuizComplete(
            score: result['marksObtained'],
            passed: result['passed'],
          ),
        ),
      );
    }).catchError((error) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Error: $error")));
    });
  }
}