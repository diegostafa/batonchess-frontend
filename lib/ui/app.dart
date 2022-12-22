import 'package:batonchess/ui/screen/game_screen.dart';
import 'package:batonchess/ui/screen/join_game_screen.dart';
import 'package:flutter/material.dart';

import 'screen/home_screen.dart';
import 'screen/new_game_screen.dart';
import 'theme/theme.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Baton Chess',
      theme: ThemeData(
        primarySwatch: primaryBlack,
        useMaterial3: true,
      ),
      home: const HomeScreen(),
      routes: {
        '/host': (BuildContext context) => const NewGameScreen(),
        '/join': (BuildContext context) => const JoinGameScreen(),
        '/game': (BuildContext context) => const GameScreen(),
      },
    );
  }
}
