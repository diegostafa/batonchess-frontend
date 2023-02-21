import "dart:math";

import "package:batonchess/bloc/game_controller/game_controller_bloc.dart";
import "package:batonchess/data/model/game/join_game_request.dart";
import "package:batonchess/ui/widget/container_bc.dart";
import "package:batonchess/ui/widget/empty_bc.dart";
import "package:bottom_nav_layout/bottom_nav_layout.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:flutter_stateless_chessboard/flutter_stateless_chessboard.dart";

class GameScreen extends StatelessWidget {
  final JoinGameRequest joinProps;
  const GameScreen({
    super.key,
    required this.joinProps,
  });
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          GameControllerBloc()..add(JoinGameEvent(joinProps: joinProps)),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Player to move: TODO CHECK STATE"),
        ),
        body: BottomNavLayout(
          savePageState: true,
          pages: [
            (_) => chessboardPage(),
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

  BlocBuilder<GameControllerBloc, GameControllerState> chessboardPage() {
    return BlocBuilder<GameControllerBloc, GameControllerState>(
      builder: (context, state) {
        return ContainerBc(
          child: adaptiveChessboard(state, context),
        );
      },
    );
  }

  Widget adaptiveChessboard(GameControllerState state, BuildContext context) {
    final screen = MediaQuery.of(context).size;
    const verticalRatio = 2 / 3;
    const horizontalRatio = 4 / 5;

    if (screen.width < screen.height * verticalRatio) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [const Text("data"), chessboard(state, context), const Text("data")],
      );
    }
    if (screen.height < screen.width * horizontalRatio) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [const Text("data"), chessboard(state, context), const Text("data")],
      );
    }

    return chessboard(state, context);
  }

  LayoutBuilder chessboard(GameControllerState state, BuildContext context) {
    return LayoutBuilder(
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
                  .add(SubmitMoveEvent(move: move));
            },
          );
        } else {
          return const Text("yoooo");
        }
      },
    );
  }

  Widget playersPage() {
    // return ListView.builder(
    //   itemCount: initialGameState.players.length,
    //   itemBuilder: (context, index) => PlayerCardBc(
    //     player: initialGameState.players[index],
    //     onTap: () {},
    //   ),
    // );

    return const EmptyBc();
  }
}
