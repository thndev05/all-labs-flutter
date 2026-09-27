import 'package:flutter/material.dart';

import 'story_brain.dart';

void main() => runApp(const DestiniApp());

class DestiniApp extends StatelessWidget {
  const DestiniApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
        title: 'Destini',
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark(useMaterial3: true),
        home: const StoryPage(),
      );
}

class StoryPage extends StatefulWidget {
  const StoryPage({super.key, this.storyBrain});

  final StoryBrain? storyBrain;

  @override
  State<StoryPage> createState() => _StoryPageState();
}

class _StoryPageState extends State<StoryPage> {
  late final StoryBrain _storyBrain;

  @override
  void initState() {
    super.initState();
    _storyBrain = widget.storyBrain ?? StoryBrain();
  }

  void _choose(int choice) {
    setState(() => _storyBrain.choose(choice));
  }

  @override
  Widget build(BuildContext context) {
    final story = _storyBrain.currentStory;

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 72,
        title: const Padding(
          padding: EdgeInsets.only(top: 16),
          child: Text('Destini'),
        ),
        centerTitle: true,
        backgroundColor: Colors.black87,
        foregroundColor: Colors.white,
      ),
      body: DecoratedBox(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/background.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Container(
            width: double.infinity,
            height: double.infinity,
            color: Colors.black.withValues(alpha: 0.32),
            padding: const EdgeInsets.fromLTRB(20, 32, 20, 24),
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 720),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                      child: Center(
                        child: SingleChildScrollView(
                          child: Text(
                            story.title,
                            key: const Key('story-text'),
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 25,
                              height: 1.45,
                              fontWeight: FontWeight.w500,
                              shadows: [
                                Shadow(blurRadius: 8, color: Colors.black)
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    _ChoiceButton(
                      key: const Key('choice-1'),
                      label: story.firstChoice,
                      color:
                          story.isEnding ? Colors.green : Colors.red.shade700,
                      onPressed: () => _choose(1),
                    ),
                    if (story.secondChoice != null) ...[
                      const SizedBox(height: 16),
                      _ChoiceButton(
                        key: const Key('choice-2'),
                        label: story.secondChoice!,
                        color: Colors.blue.shade700,
                        onPressed: () => _choose(2),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _ChoiceButton extends StatelessWidget {
  const _ChoiceButton({
    super.key,
    required this.label,
    required this.color,
    required this.onPressed,
  });

  final String label;
  final Color color;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) => FilledButton(
        onPressed: onPressed,
        style: FilledButton.styleFrom(
          backgroundColor: color,
          foregroundColor: Colors.white,
          minimumSize: const Size.fromHeight(72),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        ),
        child: Text(label,
            textAlign: TextAlign.center, style: const TextStyle(fontSize: 17)),
      );
}
