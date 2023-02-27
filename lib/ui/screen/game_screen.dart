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
  var _currPageIndex = 1;

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
        horizontal: MediaQuery.of(context).size.width / 14,
      ),
      currentIndex: _currPageIndex,
      onTap: (i) => setState(() => _currPageIndex = i),
      items: [
        SalomonBottomBarItem(
          icon: const Icon(Icons.people),
          title: const Text("White team"),
          selectedColor: Theme.of(context).primaryColor,
        ),
        SalomonBottomBarItem(
          icon: const Icon(Icons.games),
          title: const Text("Chessboard"),
          selectedColor: Theme.of(context).primaryColor,
        ),
        SalomonBottomBarItem(
          icon: const Icon(Icons.people),
          title: const Text("Black team"),
          selectedColor: Theme.of(context).primaryColor,
        ),
      ],
    );
  }

  String prettyInfoAppBar(GameReadyState state) {
    if (state.gameState.waitingForPlayers) {
      return "Waiting for players...";
    }

    if (state.gameState.userToPlay.playingAsWhite) {
      return "White to move: ${state.gameState.userToPlay.name}";
    } else {
      return "Black to move: ${state.gameState.userToPlay.name}";
    }
  }

  AppBar appBar(GameReadyState state, BuildContext context) {
    final fgPlayAsWhite = state.gameState.userToPlay.playingAsWhite
        ? Theme.of(context).primaryColor
        : Theme.of(context).canvasColor;

    final bgPlayAsWhite = state.gameState.userToPlay.playingAsWhite
        ? Theme.of(context).canvasColor
        : Theme.of(context).primaryColor;

    return AppBar(
      iconTheme: IconThemeData(
        color: fgPlayAsWhite,
      ),
      foregroundColor: fgPlayAsWhite,
      backgroundColor: bgPlayAsWhite,
      title: Row(
        textBaseline: TextBaseline.alphabetic,
        children: [
          Expanded(
            child: TextScroll(
              prettyInfoAppBar(state),
              mode: TextScrollMode.bouncing,
              pauseBetween: const Duration(seconds: 2),
            ),
          ),
        ],
      ),
    );
  }

  Widget gameScreenPages(GameReadyState state, BuildContext context) {
    switch (_currPageIndex) {
      case 0:
        return teamList(state.gameState.whiteQueue);
      case 1:
        return ContainerBc(child: adaptiveChessboard(state, context));
      case 2:
        return teamList(state.gameState.blackQueue);
      default:
        return const EmptyBc();
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

  Widget teamList(List<UserPlayer> whiteTeam) {
    return ListView.builder(
      itemCount: whiteTeam.length,
      itemBuilder: (context, index) => PlayerCardBc(
        player: whiteTeam[index],
        onTap: () {},
      ),
    );
  }
}
