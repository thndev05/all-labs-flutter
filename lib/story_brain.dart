import 'story.dart';

class StoryBrain {
  StoryBrain({List<Story>? stories}) : _stories = stories ?? _defaultStories;

  static const _defaultStories = <Story>[
    Story(
      title:
          'Your car has blown a tire on a winding road in the middle of nowhere with no cell phone reception. A rusty pickup truck stops beside you. A man opens the passenger door and asks: “Need a ride?”',
      firstChoice: 'I’ll hop in. Thanks for the help!',
      secondChoice: 'Better ask him if he’s a murderer first.',
      firstDestination: 2,
      secondDestination: 1,
    ),
    Story(
      title: 'He nods slowly, completely unfazed by the question.',
      firstChoice: 'At least he’s honest. I’ll climb in.',
      secondChoice: 'Wait, I know how to change a tire.',
      firstDestination: 2,
      secondDestination: 3,
    ),
    Story(
      title:
          'As you drive, the stranger asks you to open the glovebox. Inside you find a bloody knife, two severed fingers and an Elton John cassette. He reaches for the glovebox.',
      firstChoice: 'I love Elton John! Hand him the cassette.',
      secondChoice: 'It’s him or me! Take the knife.',
      firstDestination: 5,
      secondDestination: 4,
    ),
    Story(
      title:
          'You repair the tire and continue your journey safely. Sometimes the simplest choice is the best one.',
      firstChoice: 'CHƠI LẠI',
    ),
    Story(
      title:
          'The truck crashes through the guardrail. You reflect on the dubious wisdom of attacking someone while they are driving.',
      firstChoice: 'CHƠI LẠI',
    ),
    Story(
      title:
          'You bond over Elton John songs. He drops you off safely at the next town and drives into the night.',
      firstChoice: 'CHƠI LẠI',
    ),
  ];

  final List<Story> _stories;
  int _currentIndex = 0;

  Story get currentStory => _stories[_currentIndex];
  int get currentIndex => _currentIndex;

  void choose(int choice) {
    if (currentStory.isEnding) {
      restart();
      return;
    }

    final destination = choice == 1
        ? currentStory.firstDestination
        : currentStory.secondDestination;
    if (destination != null) _currentIndex = destination;
  }

  void restart() => _currentIndex = 0;
}
