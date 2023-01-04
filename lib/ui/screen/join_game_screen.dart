import 'package:batonchess/ui/screen/game_screen.dart';
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
          return Card(
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const GameScreen()),
                );
              },
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: ListTile(
                  leading: Icon(Icons.album),
                  title: Text('title'),
                  subtitle: Text('subtitle'),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
