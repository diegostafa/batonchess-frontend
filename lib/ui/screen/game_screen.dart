import 'package:batonchess/bloc/model/game_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chess_board/flutter_chess_board.dart';

class GameScreen extends StatefulWidget {
  final GameState? initialGameState;

  const GameScreen({super.key, this.initialGameState});

  @override
  GameScreenState createState() => GameScreenState();
}

class GameScreenState extends State<GameScreen> {
  final ChessBoardController controller = ChessBoardController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chess Demo'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ChessBoard(
              controller: controller,
              boardColor: BoardColor.darkBrown,
            ),
          ),
          Row(
            children: const [
              Text("john, mike, susan"),
              Text("john, mike, susan"),
              Text("john, mike, susan"),
            ],
          ),
        ],
      ),
    );
  }
}
