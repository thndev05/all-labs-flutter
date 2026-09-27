import 'package:flutter/material.dart';

import 'bmi_calculator.dart';

void main() => runApp(const BmiApp());

class BmiApp extends StatelessWidget {
  const BmiApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
        title: 'BMI Calculator',
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark(useMaterial3: true).copyWith(
          scaffoldBackgroundColor: const Color(0xFF0A0E21),
          colorScheme: ColorScheme.fromSeed(
              seedColor: const Color(0xFFEB1555), brightness: Brightness.dark),
        ),
        home: const BmiPage(),
      );
}

class BmiPage extends StatefulWidget {
  const BmiPage({super.key});

  @override
  State<BmiPage> createState() => _BmiPageState();
}

class _BmiPageState extends State<BmiPage> {
  var _height = 170.0;
  var _weight = 65;
  var _age = 21;
  var _isMale = true;
  BmiResult? _result;

  void _calculate() => setState(() =>
      _result = calculateBmi(heightCm: _height.round(), weightKg: _weight));

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          toolbarHeight: 72,
          title: const Padding(
            padding: EdgeInsets.only(top: 16),
            child: Text('BMI CALCULATOR'),
          ),
          centerTitle: true,
          backgroundColor: Colors.transparent,
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 24, 16, 16),
            child: _result == null ? _buildInput() : _buildResult(),
          ),
        ),
      );

  Widget _buildInput() => Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Row(
              children: [
                Expanded(
                    child: _GenderCard(
                        label: 'NAM',
                        icon: Icons.male,
                        selected: _isMale,
                        onTap: () => setState(() => _isMale = true))),
                Expanded(
                    child: _GenderCard(
                        label: 'NỮ',
                        icon: Icons.female,
                        selected: !_isMale,
                        onTap: () => setState(() => _isMale = false))),
              ],
            ),
          ),
          Expanded(
            child: _Card(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('CHIỀU CAO',
                      style:
                          TextStyle(color: Colors.white70, letterSpacing: 1.2)),
                  Text('${_height.round()} cm',
                      style: const TextStyle(
                          fontSize: 34, fontWeight: FontWeight.bold)),
                  Slider(
                      value: _height,
                      min: 120,
                      max: 220,
                      activeColor: const Color(0xFFEB1555),
                      onChanged: (value) => setState(() => _height = value)),
                ],
              ),
            ),
          ),
          Expanded(
            child: Row(
              children: [
                Expanded(
                    child: _NumberCard(
                        label: 'CÂN NẶNG',
                        value: _weight,
                        onMinus: () => setState(
                            () => _weight = (_weight - 1).clamp(1, 300)),
                        onPlus: () => setState(
                            () => _weight = (_weight + 1).clamp(1, 300)))),
                Expanded(
                    child: _NumberCard(
                        label: 'TUỔI',
                        value: _age,
                        onMinus: () =>
                            setState(() => _age = (_age - 1).clamp(1, 120)),
                        onPlus: () =>
                            setState(() => _age = (_age + 1).clamp(1, 120)))),
              ],
            ),
          ),
          _BottomButton(label: 'TÍNH BMI', onPressed: _calculate),
        ],
      );

  Widget _buildResult() {
    final result = _result!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Text('KẾT QUẢ CỦA BẠN',
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
        const SizedBox(height: 24),
        Expanded(
            child: _Card(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
              Text(result.category,
                  style: const TextStyle(
                      color: Color(0xFF24D876),
                      fontSize: 22,
                      fontWeight: FontWeight.bold)),
              Text(result.value.toStringAsFixed(1),
                  style: const TextStyle(
                      fontSize: 86, fontWeight: FontWeight.bold)),
              Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(result.interpretation,
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 20)))
            ]))),
        _BottomButton(
            label: 'TÍNH LẠI', onPressed: () => setState(() => _result = null)),
      ],
    );
  }
}

class _Card extends StatelessWidget {
  const _Card({required this.child});
  final Widget child;
  @override
  Widget build(BuildContext context) => Card(
      color: const Color(0xFF1D1E33),
      margin: const EdgeInsets.all(6),
      child: child);
}

class _GenderCard extends StatelessWidget {
  const _GenderCard(
      {required this.label,
      required this.icon,
      required this.selected,
      required this.onTap});
  final String label;
  final IconData icon;
  final bool selected;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) => GestureDetector(
      onTap: onTap,
      child: _Card(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Icon(icon,
            size: 52,
            color: selected ? const Color(0xFFEB1555) : Colors.white70),
        Text(label, style: const TextStyle(fontSize: 18, color: Colors.white70))
      ])));
}

class _NumberCard extends StatelessWidget {
  const _NumberCard(
      {required this.label,
      required this.value,
      required this.onMinus,
      required this.onPlus});
  final String label;
  final int value;
  final VoidCallback onMinus;
  final VoidCallback onPlus;
  @override
  Widget build(BuildContext context) => _Card(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Text(label, style: const TextStyle(color: Colors.white70)),
        Text('$value',
            style: const TextStyle(fontSize: 36, fontWeight: FontWeight.bold)),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          IconButton.filled(
              visualDensity: VisualDensity.compact,
              onPressed: onMinus,
              icon: const Icon(Icons.remove)),
          const SizedBox(width: 4),
          IconButton.filled(
              visualDensity: VisualDensity.compact,
              onPressed: onPlus,
              icon: const Icon(Icons.add))
        ])
      ]));
}

class _BottomButton extends StatelessWidget {
  const _BottomButton({required this.label, required this.onPressed});
  final String label;
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) => Padding(
      padding: const EdgeInsets.only(top: 12),
      child: FilledButton(
          onPressed: onPressed,
          style: FilledButton.styleFrom(
              backgroundColor: const Color(0xFFEB1555),
              minimumSize: const Size.fromHeight(64)),
          child: Text(label,
              style:
                  const TextStyle(fontSize: 20, fontWeight: FontWeight.bold))));
}
