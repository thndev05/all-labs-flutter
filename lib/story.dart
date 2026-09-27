class Story {
  const Story({
    required this.title,
    required this.firstChoice,
    this.secondChoice,
    this.firstDestination,
    this.secondDestination,
  });

  final String title;
  final String firstChoice;
  final String? secondChoice;
  final int? firstDestination;
  final int? secondDestination;

  bool get isEnding => firstDestination == null;
}
