import 'package:flutter/material.dart';

void main() => runApp(const QuizzlerApp());

class QuizQuestion {
  const QuizQuestion(this.text, this.answer);

  final String text;
  final bool answer;
}

class QuizzlerApp extends StatelessWidget {
  const QuizzlerApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
        title: 'Quizzler',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(useMaterial3: true),
        home: const QuizPage(),
      );
}

class QuizPage extends StatefulWidget {
  const QuizPage({super.key, this.questions = defaultQuestions});

  final List<QuizQuestion> questions;

  static const defaultQuestions = <QuizQuestion>[
    QuizQuestion('Some cats are actually allergic to humans.', true),
    QuizQuestion('You can lead a cow down stairs but not up stairs.', false),
    QuizQuestion(
        'Approximately one quarter of human bones are in the feet.', true),
    QuizQuestion("A slug's blood is green.", true),
    QuizQuestion('Buzz Aldrin’s mother’s maiden name was "Moon".', true),
    QuizQuestion('It is illegal to pee in the Ocean in Portugal.', true),
    QuizQuestion(
        'No piece of square dry paper can be folded in half more than 7 times.',
        false),
    QuizQuestion('Google was originally called "Backrub".', true),
  ];

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  var _questionIndex = 0;
  final List<bool> _answers = [];

  QuizQuestion get _question => widget.questions[_questionIndex];

  void _answer(bool answer) {
    final isCorrect = answer == _question.answer;
    setState(() {
      _answers.add(isCorrect);
      if (_questionIndex < widget.questions.length - 1) {
        _questionIndex++;
      } else {
        _showResult();
      }
    });
  }

  void _showResult() {
    final score = _answers.where((answer) => answer).length;
    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Hoàn thành!'),
        content:
            Text('Bạn trả lời đúng $score/${widget.questions.length} câu.'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              setState(() {
                _questionIndex = 0;
                _answers.clear();
              });
            },
            child: const Text('Làm lại'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Colors.grey.shade900,
        appBar: AppBar(
          toolbarHeight: 72,
          title: const Padding(
            padding: EdgeInsets.only(top: 16),
            child: Text('Quizzler'),
          ),
          centerTitle: true,
          backgroundColor: Colors.black,
          foregroundColor: Colors.white,
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 32, 20, 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Câu ${_questionIndex + 1}/${widget.questions.length}',
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.white70, fontSize: 16),
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: Center(
                    child: Text(
                      _question.text,
                      key: const Key('question-text'),
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: Colors.white, fontSize: 26),
                    ),
                  ),
                ),
                _AnswerButton(
                  key: const Key('true-button'),
                  label: 'ĐÚNG',
                  color: Colors.green,
                  onPressed: () => _answer(true),
                ),
                const SizedBox(height: 12),
                _AnswerButton(
                  key: const Key('false-button'),
                  label: 'SAI',
                  color: Colors.red,
                  onPressed: () => _answer(false),
                ),
                const SizedBox(height: 16),
                Wrap(
                  key: const Key('score-row'),
                  spacing: 4,
                  children: _answers
                      .map((correct) => Icon(
                            correct ? Icons.check : Icons.close,
                            color: correct ? Colors.green : Colors.red,
                          ))
                      .toList(),
                ),
              ],
            ),
          ),
        ),
      );
}

class _AnswerButton extends StatelessWidget {
  const _AnswerButton(
      {super.key,
      required this.label,
      required this.color,
      required this.onPressed});

  final String label;
  final Color color;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) => FilledButton(
        onPressed: onPressed,
        style: FilledButton.styleFrom(
          backgroundColor: color,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 18),
        ),
        child: Text(label, style: const TextStyle(fontSize: 18)),
      );
}
