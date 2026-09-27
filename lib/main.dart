import 'dart:math';

import 'package:flutter/material.dart';

void main() => runApp(const DiceeApp());

class DiceeApp extends StatelessWidget {
  const DiceeApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
        title: 'Dicee',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(useMaterial3: true),
        home: const DicePage(),
      );
}

class DicePage extends StatefulWidget {
  const DicePage({super.key, Random? random}) : _random = random;

  final Random? _random;

  @override
  State<DicePage> createState() => _DicePageState();
}

class _DicePageState extends State<DicePage> {
  late final Random _random;
  var _leftDice = 1;
  var _rightDice = 1;

  @override
  void initState() {
    super.initState();
    _random = widget._random ?? Random();
    _rollDice();
  }

  void _rollDice() {
    setState(() {
      _leftDice = _random.nextInt(6) + 1;
      _rightDice = _random.nextInt(6) + 1;
    });
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Colors.red,
        appBar: AppBar(
          toolbarHeight: 72,
          title: const Padding(
            padding: EdgeInsets.only(top: 16),
            child: Text('Dicee'),
          ),
          centerTitle: true,
          backgroundColor: Colors.red.shade700,
          foregroundColor: Colors.white,
        ),
        body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(24, 40, 24, 24),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 720),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: _DiceButton(
                            key: const Key('left-dice'),
                            value: _leftDice,
                            onPressed: _rollDice,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: _DiceButton(
                            key: const Key('right-dice'),
                            value: _rightDice,
                            onPressed: _rollDice,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 32),
                    FilledButton.icon(
                      key: const Key('roll-button'),
                      onPressed: _rollDice,
                      style: FilledButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.red.shade700,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 28,
                          vertical: 16,
                        ),
                      ),
                      icon: const Icon(Icons.casino),
                      label: const Text('LẮC XÚC XẮC'),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Tổng điểm: ${_leftDice + _rightDice}',
                      key: const Key('total-score'),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
}

class _DiceButton extends StatelessWidget {
  const _DiceButton({super.key, required this.value, required this.onPressed});

  final int value;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) => Semantics(
        button: true,
        label: 'Xúc xắc $value',
        child: IconButton(
          onPressed: onPressed,
          padding: const EdgeInsets.all(4),
          tooltip: 'Lắc xúc xắc',
          icon: Image.asset(
            'images/dice$value.png',
            key: ValueKey('dice-$value'),
            fit: BoxFit.contain,
          ),
        ),
      );
}
