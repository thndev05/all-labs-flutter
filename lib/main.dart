import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

void main() => runApp(const XylophoneApp());

class XylophoneApp extends StatelessWidget {
  const XylophoneApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
        title: 'Xylophone',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(useMaterial3: true),
        home: const XylophonePage(),
      );
}

class XylophonePage extends StatefulWidget {
  const XylophonePage({super.key, this.onPlayNote});

  final void Function(int note)? onPlayNote;

  @override
  State<XylophonePage> createState() => _XylophonePageState();
}

class _XylophonePageState extends State<XylophonePage> {
  static const _colors = [
    Colors.red,
    Colors.orange,
    Colors.yellow,
    Colors.green,
    Colors.teal,
    Colors.blue,
    Colors.purple,
  ];

  int? _lastPlayedNote;
  final AudioPlayer _audioPlayer = AudioPlayer();

  Future<void> _playNote(int note) async {
    setState(() => _lastPlayedNote = note);
    widget.onPlayNote?.call(note);
    await _audioPlayer.stop();
    await _audioPlayer.play(AssetSource('note$note.wav'));
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          toolbarHeight: 72,
          title: const Padding(
            padding: EdgeInsets.only(top: 16),
            child: Text('Xylophone'),
          ),
          centerTitle: true,
          backgroundColor: Colors.black,
          foregroundColor: Colors.white,
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(12, 24, 12, 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  'Chạm vào một phím để phát âm thanh',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white70, fontSize: 16),
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: List.generate(
                      _colors.length,
                      (index) => Expanded(
                        child: _NoteKey(
                          note: index + 1,
                          color: _colors[index],
                          isSelected: _lastPlayedNote == index + 1,
                          onPressed: _playNote,
                        ),
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

class _NoteKey extends StatelessWidget {
  const _NoteKey({
    required this.note,
    required this.color,
    required this.isSelected,
    required this.onPressed,
  });

  final int note;
  final Color color;
  final bool isSelected;
  final Future<void> Function(int note) onPressed;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 3),
        child: Semantics(
          button: true,
          label: 'Phím nhạc $note',
          child: Material(
            color: color,
            borderRadius: BorderRadius.circular(8),
            child: InkWell(
              key: Key('note-$note'),
              onTap: () => onPressed(note),
              borderRadius: BorderRadius.circular(8),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 120),
                alignment: Alignment.centerRight,
                padding: const EdgeInsets.only(right: 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: isSelected
                      ? Border.all(color: Colors.white, width: 3)
                      : null,
                ),
                child: Text(
                  '$note',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ),
      );
}
