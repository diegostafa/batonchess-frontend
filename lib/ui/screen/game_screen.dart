import "dart:math";

import "package:batonchess/bloc/game_controller/game_controller_bloc.dart";
import "package:batonchess/data/model/game/game_info.dart";
import "package:batonchess/data/model/game/game_state.dart";
import "package:batonchess/data/model/game/join_game_request.dart";
import "package:batonchess/data/model/user/user_player.dart";
import "package:batonchess/ui/screen/settings_screen.dart";
import "package:batonchess/ui/widget/container_bc.dart";
import "package:batonchess/ui/widget/dialog_bc.dart";
import "package:batonchess/ui/widget/empty_bc.dart";
import "package:batonchess/ui/widget/loading_bc.dart";
import "package:batonchess/ui/widget/player_card_bc.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:flutter_stateless_chessboard/flutter_stateless_chessboard.dart";
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
      child: BlocListener<GameControllerBloc, GameControllerState>(
        listener: (context, state) {
          if (state is GameReadyState && !state.gameState.ongoing()) {
            showDialog(
              context: context,
              builder: (ctx) {
                return DialogBc(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child:
                        Center(child: Text(state.gameState.prettyBoardState())),
                  ),
                );
              },
            );
          }
        },
        child: BlocBuilder<GameControllerBloc, GameControllerState>(
          builder: (context, state) {
            if (state is JoiningGameState) {
              return Scaffold(
                appBar: AppBar(
                  title: const Text("Joining the game..."),
                ),
                body: const Center(child: LoadingBc()),
              );
            }

            if (state is GameReadyState) {
              return Scaffold(
                appBar: appBar(state.gameState, context),
                bottomNavigationBar: bottomNavBar(context),
                body: gameScreenPages(state.gameState, context),
              );
            }

            return const EmptyBc();
          },
        ),
      ),
    );
  }

  Widget bottomNavBar(BuildContext context) {
    return BottomNavigationBar(
      unselectedFontSize: 14,
      currentIndex: _currPageIndex,
      onTap: (i) => setState(() => _currPageIndex = i),
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.people_outline),
          label: "White team",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.grid_4x4_sharp),
          label: "Chessboard",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.people),
          label: "Black team",
        ),
      ],
    );
  }

  AppBar appBar(GameState gameState, BuildContext context) {
    final fgPlayAsWhite = gameState.userToPlay.playingAsWhite
        ? Theme.of(context).primaryColorLight
        : Theme.of(context).canvasColor;

    final bgPlayAsWhite = gameState.userToPlay.playingAsWhite
        ? Theme.of(context).canvasColor
        : Theme.of(context).primaryColorLight;

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
              gameState.prettyBoardState(),
              mode: TextScrollMode.bouncing,
              pauseBetween: const Duration(seconds: 2),
            ),
          ),
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SettingsScreen(),
                ),
              );
            },
            icon: Icon(
              Icons.settings,
              color: fgPlayAsWhite,
            ),
          )
        ],
      ),
    );
  }

  Widget gameScreenPages(GameState gameState, BuildContext context) {
    switch (_currPageIndex) {
      case 0:
        return teamList(gameState.whiteQueue);
      case 1:
        return ContainerBc(child: chessboard(gameState, context));
      case 2:
        return teamList(gameState.blackQueue);
      default:
        return const EmptyBc();
    }
  }

  Widget chessboard(
    GameState gameState,
    BuildContext context,
  ) {
    return LayoutBuilder(
      builder: (ctx, constraints) {
        if (!gameState.ongoing()) {
          return Chessboard(
            orientation: widget.joinReq.playAsWhite ? Color.WHITE : Color.BLACK,
            lightSquareColor: Theme.of(context).splashColor,
            darkSquareColor: Theme.of(context).primaryColorLight,
            fen: gameState.fen,
            size: min(constraints.maxWidth, constraints.maxHeight),
          );
        }
        return Chessboard(
          orientation: widget.joinReq.playAsWhite ? Color.WHITE : Color.BLACK,
          lightSquareColor: Theme.of(context).splashColor,
          darkSquareColor: Theme.of(context).primaryColorLight,
          fen: gameState.fen,
          size: min(constraints.maxWidth, constraints.maxHeight),
          onMove: (move) {
            context.read<GameControllerBloc>().add(SubmitMoveEvent(move: move));
          },
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
