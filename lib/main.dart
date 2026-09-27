import 'package:flutter/material.dart';

void main() {
  runApp(const IAmRichApp());
}

/// Lab 1's root widget. The app intentionally stays small so the basic
/// Flutter building blocks are easy to identify while learning.
class IAmRichApp extends StatelessWidget {
  const IAmRichApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'I Am Rich',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueGrey),
      ),
      home: const IAmRichPage(),
    );
  }
}

class IAmRichPage extends StatelessWidget {
  const IAmRichPage({super.key});

  static const _backgroundColor = Color(0xFF607D8B);
  static const _appBarColor = Color(0xFF263238);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _backgroundColor,
      appBar: AppBar(
        title: const Text('I Am Rich'),
        backgroundColor: _appBarColor,
        foregroundColor: Colors.white,
        centerTitle: false,
      ),
      body: Center(
        child: Image.asset(
          'images/diamond.png',
          semanticLabel: 'A diamond representing wealth',
          width: 220,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
