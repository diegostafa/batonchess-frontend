import "dart:math";

import "package:batonchess/bloc/game_controller/game_controller_bloc.dart";
import "package:batonchess/data/model/game/game_info.dart";
import "package:batonchess/data/model/game/join_game_request.dart";
import "package:batonchess/ui/widget/container_bc.dart";
import "package:batonchess/ui/widget/player_card_bc.dart";
import "package:bottom_nav_layout/bottom_nav_layout.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:flutter_stateless_chessboard/flutter_stateless_chessboard.dart";

class GameScreen extends StatelessWidget {
  final GameInfo gameInfo;
  final JoinGameRequest joinReq;

  const GameScreen({
    super.key,
    required this.gameInfo,
    required this.joinReq,
  });
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          GameControllerBloc()..add(JoinGameEvent(joinReq: joinReq)),
      child: BlocBuilder<GameControllerBloc, GameControllerState>(
        builder: (context, state) {
          if (state is ReadyGameControllerState) {
            return Scaffold(
              appBar: AppBar(
                title: Text("Player to move: ${state.gameState.userIdTurn}"),
              ),
              body: BottomNavLayout(
                savePageState: true,
                pages: [
                  (_) => ContainerBc(child: adaptiveChessboard(state, context)),
                  (_) => playersPage(state),
                ],
                bottomNavigationBar: (currentIndex, onTap) =>
                    BottomNavigationBar(
                  selectedItemColor: Colors.white,
                  unselectedItemColor: Colors.white,
                  backgroundColor: Colors.brown,
                  currentIndex: currentIndex,
                  onTap: (index) => onTap(index),
                  items: const [
                    BottomNavigationBarItem(
                        icon: Icon(Icons.home), label: "game",),
                    BottomNavigationBarItem(
                        icon: Icon(Icons.search), label: "teams",),
                  ],
                ),
              ),
            );
          } else {
            return const Text("Waiting to join the game");
          }
        },
      ),
    );
  }

  Widget adaptiveChessboard(GameControllerState state, BuildContext context) {
    final screen = MediaQuery.of(context).size;
    const verticalRatio = 2 / 3;
    const horizontalRatio = 4 / 5;

    if (screen.width < screen.height * verticalRatio) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const Text("data"),
          chessboard(state, context),
          const Text("data")
        ],
      );
    }
    if (screen.height < screen.width * horizontalRatio) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const Text("data"),
          chessboard(state, context),
          const Text("data")
        ],
      );
    }

    return chessboard(state, context);
  }

  LayoutBuilder chessboard(GameControllerState state, BuildContext context) {
    return LayoutBuilder(
      builder: (ctx, constraints) {
        if (state is ReadyGameControllerState) {
          return Chessboard(
            lightSquareColor: Colors.white,
            darkSquareColor: Colors.brown,
            fen: state.gameState.fen,
            size: min(constraints.maxWidth, constraints.maxHeight),
            onMove: (move) {
              context
                  .read<GameControllerBloc>()
                  .add(SubmitMoveEvent(move: move));
            },
          );
        } else {
          return const Text("NOT READY");
        }
      },
    );
  }

  ListView playersPage(ReadyGameControllerState state) {
    return ListView.builder(
      itemCount: state.gameState.players.length,
      itemBuilder: (context, index) => PlayerCardBc(
        player: state.gameState.players[index],
        onTap: () {},
      ),
    );
  }
}
