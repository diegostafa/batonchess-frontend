import 'package:flutter/material.dart';

// select a game
// retrieve the gameProps for the selected game
// show dialog "join as <SIDE>"
// post /join gameId, playerId, side -> return gameState
// gameScreen(gameState)

class JoinGameScreen extends StatelessWidget {
  const JoinGameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Join a game"),
        ),
    );
  }
}
