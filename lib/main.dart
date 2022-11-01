import 'package:flutter/material.dart';
import 'package:flutter_urbetrack_challenge/navigation/view/navigation_view.dart';

void main() => runApp(const UrbetrackChallenge());

class UrbetrackChallenge extends StatelessWidget {
  const UrbetrackChallenge({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(theme: _customThemeData(), title: 'Urbetrack Challenge', home: const NavigationView());
  }

  ThemeData _customThemeData() => ThemeData.dark().copyWith(
      scaffoldBackgroundColor: const Color(0xff11181E),
      bottomAppBarColor: const Color(0xff273037),
      appBarTheme: const AppBarTheme().copyWith(
        elevation: 0.0,
        backgroundColor: const Color(0xff273037),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData().copyWith(
          elevation: 0.0,
          backgroundColor: const Color(0xff273037),
          unselectedLabelStyle: const TextStyle(fontFamily: 'StarJedi', fontSize: 12.0, letterSpacing: 1.0),
          selectedLabelStyle: const TextStyle(fontFamily: 'StarJedi', fontSize: 12.0, letterSpacing: 1.0),
          unselectedItemColor: const Color(0xff78828B),
          selectedItemColor: const Color(0xffE9B042)));
}
