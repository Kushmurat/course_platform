import 'package:flutter/material.dart';
import '../../data/models/course.dart';

class CourseTestScreen extends StatefulWidget {
  final List<Question> questions;
  final String courseTitle;

  const CourseTestScreen({
    super.key,
    required this.questions,
    required this.courseTitle,
  });

  @override
  State<CourseTestScreen> createState() => _CourseTestScreenState();
}

class _CourseTestScreenState extends State<CourseTestScreen> {
  int _currentIndex = 0;
  // Track selected option index for the current question
  int? _selectedOptionIndex;
  // Track if the answer has been checked (submitted)
  bool _isAnswerChecked = false;
  // Store results: true for correct, false for incorrect
  final List<bool> _results = [];

  bool get _isLastQuestion => _currentIndex == widget.questions.length - 1;
  bool get _isFinished => _results.length == widget.questions.length;

  void _checkAnswer() {
    if (_selectedOptionIndex == null) return;

    final currentQuestion = widget.questions[_currentIndex];
    final isCorrect = currentQuestion.options[_selectedOptionIndex!].right;

    setState(() {
      _isAnswerChecked = true;
      _results.add(isCorrect);
    });
  }

  void _nextQuestion() {
    if (_isLastQuestion) {
      // Logic handled in build (showing result screen)
      return;
    }

    setState(() {
      _currentIndex++;
      _selectedOptionIndex = null;
      _isAnswerChecked = false;
    });
  }

  void _restartTest() {
    setState(() {
      _currentIndex = 0;
      _selectedOptionIndex = null;
      _isAnswerChecked = false;
      _results.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isFinished && _isAnswerChecked) {
      return _buildResultScreen();
    }

    final currentQuestion = widget.questions[_currentIndex];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Тестирование',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFF1E73FF),
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundColor: Colors.white,
            child: BackButton(color: Colors.black),
          ),
        ),
      ),
      body: Column(
        children: [
          // Blue header curve background
          Container(
            height: 20,
            decoration: const BoxDecoration(
              color: Color(0xFF1E73FF),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),
          ),

          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Progress Bar (1 2 3 4 ...)
                  SizedBox(
                    height: 50,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: widget.questions.length,
                      separatorBuilder: (context, index) =>
                          const SizedBox(width: 12),
                      itemBuilder: (context, index) {
                        bool isActive = index == _currentIndex;
                        bool isPassed = index < _currentIndex;

                        Color bgColor = Colors.grey.shade300;
                        Color textColor = Colors.white;

                        if (isActive) {
                          bgColor = const Color(0xFF1E73FF); // Current
                        } else if (isPassed) {
                          // Past questions green or red? Usually just green for passed progress
                          // Or we can color by result if we want
                          bgColor = const Color(0xFF2ECC71);
                        }

                        return Container(
                          width: 40,
                          height: 40,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: bgColor,
                          ),
                          child: Text(
                            '${index + 1}',
                            style: TextStyle(
                              color: textColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Question Category/Title (optional, using course title or question title)
                  Text(
                    widget.courseTitle,
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 8),

                  // Question Text
                  Text(
                    currentQuestion.title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Options
                  ...List.generate(currentQuestion.options.length, (index) {
                    final option = currentQuestion.options[index];
                    return _buildOptionItem(index, option);
                  }),

                  const SizedBox(height: 24),

                  // Feedback Message
                  if (_isAnswerChecked)
                    Row(
                      children: [
                        Icon(
                          _results.last ? Icons.check : Icons.close,
                          color: _results.last
                              ? const Color(0xFF2ECC71)
                              : const Color(0xFFFF6B61),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            _results.last
                                ? 'Правильно!'
                                : 'Неправильно! Правильный ответ: ${currentQuestion.options.firstWhere((o) => o.right).answerName}',
                            style: TextStyle(
                              color: _results.last
                                  ? const Color(0xFF2ECC71)
                                  : const Color(0xFFFF6B61),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                ],
              ),
            ),
          ),

          // Bottom Navigation Buttons
          Container(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Previous Button (Circular)
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.grey.shade100,
                  ),
                  child: IconButton(
                    onPressed: _currentIndex > 0 && !_isAnswerChecked
                        ? () => setState(() {
                            _currentIndex--;
                            _selectedOptionIndex = null;
                          })
                        : null, // Disable go back for now to simplify logic or enable implementations
                    icon: const Icon(Icons.chevron_left),
                    color: Colors.black,
                  ),
                ),

                // Action Button (Check or Next)
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: ElevatedButton(
                      onPressed: _selectedOptionIndex == null
                          ? null
                          : (_isAnswerChecked ? _nextQuestion : _checkAnswer),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF1E73FF),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        disabledBackgroundColor: Colors.grey.shade300,
                      ),
                      child: Text(
                        _isAnswerChecked
                            ? (_isLastQuestion ? 'Завершить' : 'Следующий')
                            : 'Ответить',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),

                // Next Button (Circular) - Optional redundant next
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.grey.shade100,
                  ),
                  child: IconButton(
                    onPressed: _isAnswerChecked ? _nextQuestion : null,
                    icon: const Icon(Icons.chevron_right),
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOptionItem(int index, Option option) {
    bool isSelected = _selectedOptionIndex == index;

    // Logic for coloring options after check
    Color borderColor = Colors.grey.shade300;
    Color iconColor = Colors.grey.shade400;
    IconData iconData = Icons.circle_outlined;

    if (_isAnswerChecked) {
      if (option.right) {
        // Correct answer always green
        borderColor = const Color(0xFF2ECC71); // Green
        iconColor = const Color(0xFF2ECC71);
        iconData = Icons.check_circle_outline;
      } else if (isSelected && !option.right) {
        // Selected wrong answer red
        borderColor = const Color(0xFFFF6B61); // Red
        iconColor = const Color(0xFFFF6B61);
        iconData = Icons.cancel_outlined;
      }
    } else {
      if (isSelected) {
        borderColor = const Color(0xFF1E73FF);
        iconColor = const Color(0xFF1E73FF);
        iconData = Icons.radio_button_checked;
      }
    }

    return GestureDetector(
      onTap: _isAnswerChecked
          ? null
          : () {
              setState(() {
                _selectedOptionIndex = index;
              });
            },
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: borderColor, width: 1.5),
        ),
        child: Row(
          children: [
            Icon(iconData, color: iconColor, size: 24),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                option.answerName,
                style: const TextStyle(fontSize: 16, color: Colors.black87),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildResultScreen() {
    int correctCount = _results.where((r) => r).length;
    int total = _results.length;
    int percentage = ((correctCount / total) * 100).round();

    bool isSuccess = percentage >= 70; // 70% passing grade

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Тестирование',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFF1E73FF),
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundColor: Colors.white,
            child: BackButton(color: Colors.black),
          ),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Illustration placeholder (using Icon for now as detailed in plan)
              Icon(
                isSuccess ? Icons.school : Icons.sentiment_dissatisfied,
                size: 120,
                color: isSuccess ? const Color(0xFF1E73FF) : Colors.grey,
              ),
              const SizedBox(height: 32),
              Text(
                isSuccess
                    ? 'Поздравляем!\nВы прошли тестирование'
                    : 'Вы не прошли\nтестирование :(',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Ваш результат - $percentage%',
                style: TextStyle(
                  fontSize: 18,
                  color: isSuccess
                      ? const Color(0xFF2ECC71)
                      : const Color(0xFFFF6B61),
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 48),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _restartTest,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1E73FF),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: const Text(
                    'Пройти заново',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () => Navigator.of(context).pop(),
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Color(0xFF1E73FF)),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: const Text(
                    'На главную',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1E73FF),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
