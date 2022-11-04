import 'package:flutter/material.dart';
import 'package:flutter_urbetrack_challenge/navigation/view/navigation_view.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final storage = await HydratedStorage.build(
    storageDirectory: await getApplicationDocumentsDirectory(),
  );
  HydratedBlocOverrides.runZoned(() => runApp(const UrbetrackChallenge()), storage: storage);
}

class UrbetrackChallenge extends StatelessWidget {
  const UrbetrackChallenge({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, theme: _customThemeData(), title: 'Urbetrack Challenge', home: const NavigationView());
  }

  ThemeData _customThemeData() => ThemeData.dark().copyWith(
      scaffoldBackgroundColor: Colors.white,
      iconTheme: const IconThemeData().copyWith(color: const Color(0xffE9B042)),
      switchTheme: const SwitchThemeData().copyWith(
          thumbColor: MaterialStateProperty.all(const Color(0xffE9B042)),
          trackColor: MaterialStateProperty.all(const Color(0xffE9B042).withOpacity(0.8))),
      inputDecorationTheme: const InputDecorationTheme().copyWith(
          labelStyle: const TextStyle(color: Color(0xff273037)),
          alignLabelWithHint: false,
          floatingLabelBehavior: FloatingLabelBehavior.never,
          prefixIconColor: const Color(0xff273037),
          focusedBorder:
              OutlineInputBorder(borderRadius: BorderRadius.circular(20), borderSide: const BorderSide(color: Color(0xff273037), width: 3)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20), borderSide: BorderSide(color: const Color(0xff273037).withOpacity(0.7), width: 2))),
      appBarTheme: const AppBarTheme().copyWith(
        elevation: 0.0,
        backgroundColor: const Color(0xff273037),
      ),
      listTileTheme: const ListTileThemeData().copyWith(
          tileColor: const Color(0xff273037),
          contentPadding: const EdgeInsets.all(8.0),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData().copyWith(
          elevation: 0.0,
          backgroundColor: const Color(0xff273037),
          unselectedLabelStyle: const TextStyle(fontFamily: 'StarJedi', fontSize: 12.0, letterSpacing: 1.0),
          selectedLabelStyle: const TextStyle(fontFamily: 'StarJedi', fontSize: 12.0, letterSpacing: 1.0),
          unselectedItemColor: const Color(0xff78828B),
          selectedItemColor: const Color(0xffE9B042)));
}
