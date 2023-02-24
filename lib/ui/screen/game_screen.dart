import "dart:math";

import "package:batonchess/bloc/game_controller/game_controller_bloc.dart";
import "package:batonchess/data/model/game/game_info.dart";
import "package:batonchess/data/model/game/join_game_request.dart";
import "package:batonchess/data/model/user/user_player.dart";
import "package:batonchess/ui/widget/container_bc.dart";
import "package:batonchess/ui/widget/empty_bc.dart";
import "package:batonchess/ui/widget/player_card_bc.dart";
import "package:bottom_nav_layout/bottom_nav_layout.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:flutter_stateless_chessboard/flutter_stateless_chessboard.dart";
import "package:text_scroll/text_scroll.dart";

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
                title: Row(
                  textBaseline: TextBaseline.alphabetic,
                  children: [
                    Expanded(
                      child: TextScroll(
                        "Player to move: ${state.gameState.players.first.name}",
                        mode: TextScrollMode.bouncing,
                        pauseBetween: const Duration(seconds: 2),
                      ),
                    ),
                  ],
                ),
              ),
              body: BottomNavLayout(
                savePageState: true,
                pages: [
                  (_) => ContainerBc(child: adaptiveChessboard(state, context)),
                  (_) => playersPage(state),
                ],
                bottomNavigationBar: (currentIndex, onTap) =>
                    BottomNavigationBar(
                  currentIndex: currentIndex,
                  onTap: (index) => onTap(index),
                  items: const [
                    BottomNavigationBarItem(
                      icon: Icon(Icons.home),
                      label: "game",
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.search),
                      label: "teams",
                    ),
                  ],
                ),
              ),
            );
          } else {
            return Scaffold(
              appBar: AppBar(
                title: const Text("Joining the game..."),
              ),
              body: const EmptyBc(),
            );
          }
        },
      ),
    );
  }

  Widget adaptiveChessboard(
    ReadyGameControllerState state,
    BuildContext context,
  ) {
    final screen = MediaQuery.of(context).size;
    const verticalRatio = 2 / 3;
    const horizontalRatio = 4 / 5;
    final children = [
      chessboard(state, context),
    ];

    if (screen.width < screen.height * verticalRatio) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: children,
      );
    }
    if (screen.height < screen.width * horizontalRatio) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: children,
      );
    }

    return chessboard(state, context);
  }

  LayoutBuilder chessboard(
    ReadyGameControllerState state,
    BuildContext context,
  ) {
    void onMove(ShortMove move) {
      context.read<GameControllerBloc>().add(SubmitMoveEvent(move: move));
    }

    return LayoutBuilder(
      builder: (ctx, constraints) {
        return Chessboard(
          lightSquareColor: Theme.of(context).splashColor,
          darkSquareColor: Theme.of(context).primaryColorLight,
          fen: state.gameState.fen,
          size: min(constraints.maxWidth, constraints.maxHeight),
          onMove: onMove,
        );
      },
    );
  }

  Row playersPage(ReadyGameControllerState state) {
    final whiteTeam = state.gameState.players
        .where((player) => player.playingAsWhite)
        .toList();

    final blackTeam = state.gameState.players
        .where((player) => !player.playingAsWhite)
        .toList();

    return Row(
      children: [
        teamList(whiteTeam, state),
        teamList(blackTeam, state),
      ],
    );
  }

  Expanded teamList(
    List<UserPlayer> whiteTeam,
    ReadyGameControllerState state,
  ) {
    return Expanded(
      child: ListView.builder(
        itemCount: whiteTeam.length,
        itemBuilder: (context, index) => PlayerCardBc(
          isCurrentTurn: whiteTeam[index].id == state.gameState.userIdTurn,
          player: whiteTeam[index],
          onTap: () {},
        ),
      ),
    );
  }
}
