import 'package:batonchess/ui/screen/game_screen.dart';
import 'package:batonchess/ui/widget/join_game_card_bc.dart';
import 'package:flutter/material.dart';

/*
  - select a game
  - retrieve the gameProps for the selected game
  - show dialog "join as <SIDE>"
  - post /join gameId, playerId, side -> return gameState
  - gameScreen(gameState)

  ui:
  - scaffold
    - local tab
*/

class JoinGameScreen extends StatelessWidget {
  const JoinGameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Join a game"),
      ),
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          return JoinGameCardBc(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const GameScreen()),
              );
            },
          );
        },
      ),
    );
  }
}
