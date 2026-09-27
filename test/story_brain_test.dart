import 'package:flutter_test/flutter_test.dart';
import 'package:destini/story_brain.dart';

void main() {
  test('follows a story branch and restarts at an ending', () {
    final brain = StoryBrain();

    brain.choose(2);
    expect(brain.currentIndex, 1);
    brain.choose(2);
    expect(brain.currentIndex, 3);
    expect(brain.currentStory.isEnding, isTrue);
    brain.choose(1);
    expect(brain.currentIndex, 0);
  });
}
