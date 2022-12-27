import 'package:batonchess/bloc/model/game_state.dart';
import 'package:batonchess/ui/widget/container_bc.dart';
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
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          timers(),
          chessBoard(),
          Expanded(
            flex: 2,
            child: ContainerBc(
              margin: const EdgeInsets.all(10),
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 10,
                      itemBuilder: (context, index) =>
                          // todo :
                          ContainerBc(
                              margin: const EdgeInsets.all(10),
                              padding: const EdgeInsets.all(4),
                              child: Text("User $index"),),
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 10,
                      itemBuilder: (context, index) => ContainerBc(
                          margin: const EdgeInsets.all(10),
                          padding: const EdgeInsets.all(4),
                          child: Text("User $index"),),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  ContainerBc timers() {
    return ContainerBc(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: const [
          Text("WHITE 10:00"),
          Text("BLACK 00:12"),
        ],
      ),
    );
  }

  Expanded chessBoard() {
    return Expanded(
      flex: 5,
      child: ContainerBc(
        child: ChessBoard(
          controller: controller,
          boardColor: BoardColor.darkBrown,
        ),
      ),
    );
  }
}
