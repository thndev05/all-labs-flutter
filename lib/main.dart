import 'dart:math';

import 'package:flutter/material.dart';

void main() => runApp(const Magic8BallApp());

class Magic8BallApp extends StatelessWidget {
  const Magic8BallApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
    title: 'Magic 8 Ball',
    debugShowCheckedModeBanner: false,
    theme: ThemeData(useMaterial3: true),
    home: const BallPage(),
  );
}

class BallPage extends StatefulWidget {
  const BallPage({super.key, Random? random}) : _random = random;

  final Random? _random;

  @override
  State<BallPage> createState() => _BallPageState();
}

class _BallPageState extends State<BallPage> {
  late final Random _random;
  var _ballNumber = 1;

  @override
  void initState() {
    super.initState();
    _random = widget._random ?? Random();
  }

  void _askQuestion() {
    setState(() {
      _ballNumber = _random.nextInt(5) + 1;
    });
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: Colors.blue,
    appBar: AppBar(
      toolbarHeight: 72,
      title: const Padding(
        padding: EdgeInsets.only(top: 16),
        child: Text('Ask Me Anything'),
      ),
      centerTitle: true,
      backgroundColor: Colors.blue.shade900,
      foregroundColor: Colors.white,
    ),
    body: SafeArea(
      child: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(24, 40, 24, 24),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 560),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Hãy đặt một câu hỏi',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 24),
                Semantics(
                  button: true,
                  label: 'Quả bóng Magic 8 Ball, câu trả lời số $_ballNumber',
                  child: InkWell(
                    key: const Key('magic-ball'),
                    onTap: _askQuestion,
                    borderRadius: BorderRadius.circular(220),
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Image.asset(
                        'images/ball$_ballNumber.png',
                        key: ValueKey('ball-$_ballNumber'),
                        width: 320,
                        height: 320,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                FilledButton.icon(
                  key: const Key('ask-button'),
                  onPressed: _askQuestion,
                  style: FilledButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.blue.shade900,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 28,
                      vertical: 16,
                    ),
                  ),
                  icon: const Icon(Icons.help_outline),
                  label: const Text('HỎI MAGIC 8 BALL'),
                ),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}
