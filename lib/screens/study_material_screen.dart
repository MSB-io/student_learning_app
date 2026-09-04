import 'package:flutter/material.dart';
import '../models/learning_data.dart';
import 'quiz_screen.dart';

class StudyMaterialScreen extends StatefulWidget {
  final Subject subject;
  final Chapter chapter;

  const StudyMaterialScreen({
    super.key,
    required this.subject,
    required this.chapter,
  });

  @override
  State<StudyMaterialScreen> createState() => _StudyMaterialScreenState();
}

class _StudyMaterialScreenState extends State<StudyMaterialScreen> {
  // Simple state tracking for Checkbox from professor's rubric
  bool _isMarkedAsRead = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Chapter ${widget.chapter.chapterNumber}',
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Chapter Title Header
            Text(
              widget.chapter.title,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF0F172A),
              ),
            ),
            const SizedBox(height: 6),
            Row(
              children: [
                Chip(
                  label: Text(widget.subject.code),
                  backgroundColor: widget.subject.color.withAlpha(20),
                  labelStyle: TextStyle(
                    color: widget.subject.color,
                    fontWeight: FontWeight.bold,
                    fontSize: 11,
                  ),
                  visualDensity: VisualDensity.compact,
                ),
                const SizedBox(width: 8),
                Text(
                  'Reading time: ${widget.chapter.duration}',
                  style: const TextStyle(
                    fontSize: 12,
                    color: Color(0xFF64748B),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            // Summary Section Card
            Card(
              elevation: 1,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: const BorderSide(color: Color(0xFFE2E8F0)),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      children: [
                        Icon(
                          Icons.article_outlined,
                          size: 18,
                          color: Color(0xFF1E293B),
                        ),
                        SizedBox(width: 8),
                        Text(
                          'Chapter Overview',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1E293B),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Text(
                      widget.chapter.summary,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Color(0xFF334155),
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Key Study Notes Card
            Card(
              elevation: 1,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: const BorderSide(color: Color(0xFFE2E8F0)),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      children: [
                        Icon(
                          Icons.lightbulb_outline,
                          size: 18,
                          color: Color(0xFF1E293B),
                        ),
                        SizedBox(width: 8),
                        Text(
                          'Key Concepts & Definitions',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1E293B),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    ...widget.chapter.keyPoints.map(
                      (point) => Padding(
                        padding: const EdgeInsets.only(bottom: 10.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              '• ',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF1E293B),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                point,
                                style: const TextStyle(
                                  fontSize: 13,
                                  color: Color(0xFF334155),
                                  height: 1.4,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Mark as completed checkbox (Rubric Widget)
            Card(
              elevation: 0,
              color: const Color(0xFFF8FAFC),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
                side: const BorderSide(color: Color(0xFFE2E8F0)),
              ),
              child: CheckboxListTile(
                value: _isMarkedAsRead,
                title: const Text(
                  'Mark module as completed',
                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
                ),
                subtitle: const Text(
                  'Track your progress through this chapter',
                  style: TextStyle(fontSize: 11),
                ),
                controlAffinity: ListTileControlAffinity.leading,
                onChanged: (bool? value) {
                  setState(() {
                    _isMarkedAsRead = value ?? false;
                  });
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        _isMarkedAsRead
                            ? 'Chapter marked as completed! 🎉'
                            : 'Chapter progress unmarked.',
                      ),
                      duration: const Duration(seconds: 1),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 24),

            // Action Button to Start Quiz (Rubric Widget: ElevatedButton)
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1E293B),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                icon: const Icon(Icons.quiz_outlined),
                label: Text(
                  'Take Chapter Quiz (${widget.chapter.quiz.length} Questions)',
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => QuizScreen(
                        subject: widget.subject,
                        chapter: widget.chapter,
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
