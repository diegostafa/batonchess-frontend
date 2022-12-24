import 'package:batonchess/ui/screen/home_screen.dart';
import 'package:batonchess/ui/theme/theme.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
        title: 'Baton Chess',
        theme: lightTheme(),
        home: const HomeScreen(),
      );

  ThemeData lightTheme() => ThemeData(
        primarySwatch: primaryBlack,
        useMaterial3: true,
      );
}
