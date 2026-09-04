import 'package:flutter/material.dart';
import '../models/learning_data.dart';

class QuizScreen extends StatefulWidget {
  final Subject subject;
  final Chapter chapter;

  const QuizScreen({
    super.key,
    required this.subject,
    required this.chapter,
  });

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int _currentQuestionIndex = 0;
  // Map storing {questionIndex: selectedOptionIndex}
  final Map<int, int> _selectedAnswers = {};
  bool _isSubmitted = false;

  void _selectOption(int optionIndex) {
    if (_isSubmitted) return; // Prevent changing after submission
    setState(() {
      _selectedAnswers[_currentQuestionIndex] = optionIndex;
    });
  }

  int _calculateScore() {
    int score = 0;
    for (int i = 0; i < widget.chapter.quiz.length; i++) {
      if (_selectedAnswers[i] == widget.chapter.quiz[i].correctOptionIndex) {
        score++;
      }
    }
    return score;
  }

  void _submitQuiz() {
    final score = _calculateScore();
    final total = widget.chapter.quiz.length;

    setState(() {
      _isSubmitted = true;
    });

    // Professor's rubric widget: AlertDialog
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        title: const Row(
          children: [
            Icon(Icons.emoji_events_outlined, color: Colors.amber, size: 28),
            SizedBox(width: 8),
            Text('Quiz Completed!'),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Your Score: $score / $total',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF0F172A),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              score == total
                  ? 'Excellent work! You mastered this chapter.'
                  : score >= total / 2
                      ? 'Good effort! Review the explanations to reinforce concepts.'
                      : 'Keep practicing! Review the study notes and try again.',
              style: const TextStyle(fontSize: 13, color: Color(0xFF64748B)),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Close dialog to review answers
            },
            child: const Text('Review Answers'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF1E293B),
              foregroundColor: Colors.white,
            ),
            onPressed: () {
              Navigator.pop(context); // Close dialog
              Navigator.pop(context); // Return to chapter study notes
            },
            child: const Text('Finish'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final quiz = widget.chapter.quiz;
    final currentQuestion = quiz[_currentQuestionIndex];
    final selectedOption = _selectedAnswers[_currentQuestionIndex];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Quiz: Ch ${widget.chapter.chapterNumber}',
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Progress Indicator & Question Counter
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Question ${_currentQuestionIndex + 1} of ${quiz.length}',
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF64748B),
                  ),
                ),
                Text(
                  '${_selectedAnswers.length}/${quiz.length} Answered',
                  style: const TextStyle(
                    fontSize: 12,
                    color: Color(0xFF94A3B8),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            LinearProgressIndicator(
              value: (_currentQuestionIndex + 1) / quiz.length,
              backgroundColor: const Color(0xFFE2E8F0),
              color: const Color(0xFF1E293B),
              minHeight: 6,
              borderRadius: BorderRadius.circular(3),
            ),

            const SizedBox(height: 18),

            // Question Card
            Card(
              elevation: 0,
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: const BorderSide(color: Color(0xFFE2E8F0)),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      currentQuestion.questionText,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF0F172A),
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Options List using Radio (Rubric Widget)
            Expanded(
              child: RadioGroup<int>(
                groupValue: selectedOption,
                onChanged: (int? value) {
                  if (!_isSubmitted && value != null) {
                    _selectOption(value);
                  }
                },
                child: ListView.builder(
                  itemCount: currentQuestion.options.length,
                  itemBuilder: (context, optIndex) {
                    final optionText = currentQuestion.options[optIndex];
                    final isSelected = selectedOption == optIndex;

                    // Styling if submitted
                    Color tileBorderColor = const Color(0xFFE2E8F0);
                    Color tileBgColor = Colors.white;

                    if (_isSubmitted) {
                      if (optIndex == currentQuestion.correctOptionIndex) {
                        tileBorderColor = Colors.green;
                        tileBgColor = Colors.green.withAlpha(25);
                      } else if (isSelected) {
                        tileBorderColor = Colors.red;
                        tileBgColor = Colors.red.withAlpha(25);
                      }
                    } else if (isSelected) {
                      tileBorderColor = const Color(0xFF1E293B);
                      tileBgColor = const Color(0xFFF1F5F9);
                    }

                    return Card(
                      margin: const EdgeInsets.only(bottom: 10.0),
                      color: tileBgColor,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                        side: BorderSide(color: tileBorderColor, width: 1.2),
                      ),
                      // Professor's rubric widget: Radio
                      child: RadioListTile<int>(
                        value: optIndex,
                        activeColor: const Color(0xFF1E293B),
                        title: Text(
                          optionText,
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                            color: const Color(0xFF1E293B),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),

            // Explanation Card (Visible during review)
            if (_isSubmitted) ...[
              Card(
                color: const Color(0xFFF8FAFC),
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                  side: const BorderSide(color: Color(0xFFCBD5E1)),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(Icons.info_outline, size: 18, color: Color(0xFF475569)),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          'Explanation: ${currentQuestion.explanation}',
                          style: const TextStyle(fontSize: 12, color: Color(0xFF334155)),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 12),
            ],

            // Navigation Controls: Previous / Next / Submit
            Row(
              children: [
                if (_currentQuestionIndex > 0)
                  Expanded(
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: () {
                        setState(() {
                          _currentQuestionIndex--;
                        });
                      },
                      child: const Text('Previous'),
                    ),
                  ),
                if (_currentQuestionIndex > 0) const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      backgroundColor: const Color(0xFF1E293B),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () {
                      if (_currentQuestionIndex < quiz.length - 1) {
                        setState(() {
                          _currentQuestionIndex++;
                        });
                      } else if (!_isSubmitted) {
                        _submitQuiz();
                      } else {
                        Navigator.pop(context);
                      }
                    },
                    child: Text(
                      _currentQuestionIndex < quiz.length - 1
                          ? 'Next'
                          : (_isSubmitted ? 'Done Reviewing' : 'Submit Quiz'),
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
