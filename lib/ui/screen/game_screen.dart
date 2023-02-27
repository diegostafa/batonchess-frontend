import "dart:math";

import "package:batonchess/bloc/game_controller/game_controller_bloc.dart";
import "package:batonchess/data/model/game/game_info.dart";
import "package:batonchess/data/model/game/join_game_request.dart";
import "package:batonchess/data/model/user/user_player.dart";
import "package:batonchess/ui/widget/container_bc.dart";
import "package:batonchess/ui/widget/empty_bc.dart";
import "package:batonchess/ui/widget/loading_bc.dart";
import "package:batonchess/ui/widget/player_card_bc.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:flutter_stateless_chessboard/flutter_stateless_chessboard.dart";
import "package:salomon_bottom_bar/salomon_bottom_bar.dart";
import "package:text_scroll/text_scroll.dart";

class GameScreen extends StatefulWidget {
  final GameInfo gameInfo;
  final JoinGameRequest joinReq;

  const GameScreen({super.key, required this.gameInfo, required this.joinReq});

  @override
  GameScreenState createState() => GameScreenState();
}

class GameScreenState extends State<GameScreen> {
  var _currPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          GameControllerBloc()..add(JoinGameEvent(joinReq: widget.joinReq)),
      child: BlocBuilder<GameControllerBloc, GameControllerState>(
        builder: (context, state) {
          if (state is GameReadyState) {
            return Scaffold(
              appBar: appBar(state, context),
              bottomNavigationBar: bottomNavBar(context),
              body: gameScreenPages(state, context),
            );
          }

          if (state is JoiningGameState) {
            return Scaffold(
              appBar: AppBar(
                title: const Text("Joining the game..."),
              ),
              body: const LoadingBc(),
            );
          }

          if (state is CheckmateState) {
            return Scaffold(
              appBar: AppBar(
                title: const Text("CHECKMATE"),
              ),
              body: const Center(
                child: Text("CHECKMATE"),
              ),
            );
          }

          return const EmptyBc();
        },
      ),
    );
  }

  Widget bottomNavBar(BuildContext context) {
    return SalomonBottomBar(
      itemPadding: EdgeInsets.symmetric(
        vertical: 10,
        horizontal: MediaQuery.of(context).size.width / 8,
      ),
      currentIndex: _currPageIndex,
      onTap: (i) => setState(() => _currPageIndex = i),
      items: [
        SalomonBottomBarItem(
          icon: const Icon(Icons.games),
          title: const Text("Game"),
          selectedColor: Theme.of(context).primaryColor,
        ),
        SalomonBottomBarItem(
          icon: const Icon(Icons.people),
          title: const Text("Team"),
          selectedColor: Theme.of(context).primaryColor,
        ),
      ],
    );
  }

  AppBar appBar(GameReadyState state, BuildContext context) {
    return AppBar(
      iconTheme: IconThemeData(
        color: state.gameState.userToPlay.playingAsWhite
            ? Theme.of(context).primaryColor
            : Theme.of(context).canvasColor,
      ),
      foregroundColor: state.gameState.userToPlay.playingAsWhite
          ? Theme.of(context).primaryColor
          : Theme.of(context).canvasColor,
      backgroundColor: state.gameState.userToPlay.playingAsWhite
          ? Theme.of(context).canvasColor
          : Theme.of(context).primaryColor,
      title: Row(
        textBaseline: TextBaseline.alphabetic,
        children: [
          Expanded(
            child: TextScroll(
              state.gameState.waitingForPlayers
                  ? "Waiting for players..."
                  : "Player to move: ${state.gameState.userToPlay.name}",
              mode: TextScrollMode.bouncing,
              pauseBetween: const Duration(seconds: 2),
            ),
          ),
        ],
      ),
    );
  }

  Widget gameScreenPages(GameReadyState state, BuildContext context) {
    if (_currPageIndex == 0) {
      return ContainerBc(child: adaptiveChessboard(state, context));
    } else {
      return playersPage(state);
    }
  }

  Widget adaptiveChessboard(
    GameReadyState state,
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

  Widget chessboard(
    GameReadyState state,
    BuildContext context,
  ) {
    void onMove(ShortMove move) {
      context.read<GameControllerBloc>().add(SubmitMoveEvent(move: move));
    }

    return LayoutBuilder(
      builder: (ctx, constraints) {
        return Chessboard(
          orientation: widget.joinReq.playAsWhite ? Color.WHITE : Color.BLACK,
          lightSquareColor: Theme.of(context).splashColor,
          darkSquareColor: Theme.of(context).primaryColorLight,
          fen: state.gameState.fen,
          size: min(constraints.maxWidth, constraints.maxHeight),
          onMove: onMove,
        );
      },
    );
  }

  Widget playersPage(GameReadyState state) {
    return Row(
      children: [
        teamList(state.gameState.whiteQueue, state),
        teamList(state.gameState.blackQueue, state),
      ],
    );
  }

  Widget teamList(
    List<UserPlayer> whiteTeam,
    GameReadyState state,
  ) {
    return Expanded(
      child: ListView.builder(
        itemCount: whiteTeam.length,
        itemBuilder: (context, index) => PlayerCardBc(
          isCurrentTurn: whiteTeam[index].id == state.gameState.userToPlay.id,
          player: whiteTeam[index],
          onTap: () {},
        ),
      ),
    );
  }
}
