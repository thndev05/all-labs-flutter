# Flutter Labs

## Lab 1 — I Am Rich

This branch contains the first lab from the Flutter Bootcamp reference
repository (`chapter_1/i_am_rich`). The project includes current Flutter
runners for Android, iOS and Web. It demonstrates the smallest useful Flutter
app:

- `MaterialApp` provides the application shell and theme.
- `Scaffold` supplies the page layout.
- `AppBar` displays the **I Am Rich** title.
- `Image.asset` loads the diamond image from `images/diamond.png`.

## Demo on the Web

The project includes a web target, so no phone or emulator is required. With
Flutter installed, run it in Chrome from this directory:

```bash
flutter pub get
flutter run -d chrome
```

Use `flutter run -d edge` instead if you prefer Microsoft Edge. While the app
is running, press `r` in the terminal for hot reload and `q` to stop it.

The `android/` and `ios/` directories are retained so this remains a complete
cross-platform Flutter project; a phone or emulator is not needed for the web
demo.

Run the widget test with:

```bash
flutter test
```

The original reference implementation is kept in `../flutter-bootcamp`.
