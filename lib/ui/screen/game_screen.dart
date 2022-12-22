import 'package:flutter/material.dart';
import 'package:flutter_chess_board/flutter_chess_board.dart';

/// GameScreen with game id
/// bloc calls the server to retrieve the game state
/// 

class GameScreen extends StatefulWidget {
  const GameScreen({Key? key}) : super(key: key);

  @override
  GameScreenState createState() => GameScreenState();
}

class GameScreenState extends State<GameScreen> {
  ChessBoardController controller = ChessBoardController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chess Demo'),
      ),
      body: Column(
        children: [
          Row(
            children: const [
              Text("john, mike, susan"),
              Text("john, mike, susan"),
              Text("john, mike, susan"),
            ],
          ),
          Container(
            color: Colors.red,
            child: Expanded(
              child: Center(
                child: ChessBoard(
                  controller: controller,
                  boardColor: BoardColor.darkBrown,
                  boardOrientation: PlayerColor.white,
                ),
              ),
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
