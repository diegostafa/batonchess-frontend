import "dart:math";

import "package:batonchess/bloc/game_controller/game_controller_bloc.dart";
import "package:batonchess/data/model/game/game_info.dart";
import "package:batonchess/data/model/game/game_state.dart";
import "package:batonchess/ui/widget/container_bc.dart";
import "package:batonchess/ui/widget/player_card_bc.dart";
import "package:bottom_nav_layout/bottom_nav_layout.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:flutter_stateless_chessboard/flutter_stateless_chessboard.dart";

class GameScreen extends StatelessWidget {
  final GameState initialGameState;
  final GameInfo gameInfo;

  const GameScreen(
      {super.key, required this.initialGameState, required this.gameInfo,});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<GameControllerBloc>(
          create: (BuildContext context) =>
              GameControllerBloc(gameState: initialGameState),
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: Text("Player to move: ${initialGameState.userIdTurn}"),
        ),
        body: BottomNavLayout(
          savePageState: true,
          pages: [
            (_) => gamePage(),
            (_) => playersPage(),
          ],
          bottomNavigationBar: (currentIndex, onTap) => BottomNavigationBar(
            selectedItemColor: Colors.white,
            unselectedItemColor: Colors.white,
            backgroundColor: Colors.brown,
            currentIndex: currentIndex,
            onTap: (index) => onTap(index),
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: "game"),
              BottomNavigationBarItem(icon: Icon(Icons.search), label: "teams"),
            ],
          ),
        ),
      ),
    );
  }

  Column gamePage() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        BlocBuilder<GameControllerBloc, GameControllerState>(
          builder: (context, state) {
            return ContainerBc(
              margin: const EdgeInsets.all(10),
              child: LayoutBuilder(
                builder: (ctx, constraints) {
                  if (state is IdleGameControllerState) {
                    return Chessboard(
                      lightSquareColor: Colors.white,
                      darkSquareColor: Colors.brown,
                      fen: state.gameState.fen,
                      size: min(constraints.maxWidth, constraints.maxHeight),
                      onMove: (move) {
                        context
                            .read<GameControllerBloc>()
                            .add(MakeMoveEvent(move: move));
                      },
                    );
                  } else {
                    return const Text("yoooo");
                  }
                },
              ),
            );
          },
        )
      ],
    );
  }

  Widget playersPage() {
    return ListView.builder(
      itemCount: initialGameState.players.length,
      itemBuilder: (context, index) => PlayerCardBc(
        player: initialGameState.players[index],
        onTap: () {},
      ),
    );
  }
}
