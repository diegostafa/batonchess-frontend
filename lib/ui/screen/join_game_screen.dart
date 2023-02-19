import 'package:batonchess/bloc/join_game/join_game_bloc.dart';
import 'package:batonchess/ui/screen/game_screen.dart';
import 'package:batonchess/ui/widget/join_game_card_bc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/*
  - select a game
  - retrieve the gameProps for the selected game
  - show dialog "join as <SIDE>"
  - post /join gameId, playerId, side -> return gameState
  - gameScreen(gameState)

  ui:
  - scaffold
    - local tab
*/

class JoinGameScreen extends StatelessWidget {
  const JoinGameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => JoinGameBloc()..add(FetchGamesEvent()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Join a game"),
        ),
        body: BlocBuilder<JoinGameBloc, JoinGameState>(
          builder: (context, state) {
            if (state is GamesLoadedState) {
              return ListView.builder(
                itemCount: state.games.length,
                itemBuilder: (context, index) {
                  return JoinGameCardBc(
                    gameInfo: state.games[index],
                    onTap: () {
                      /**
                       * show dialog play as white/black
                       * emit JoinGameEvent(selected_game, side)
                       * bloc --> repo.joinGame --> http.joinGame
                       * get gameInfo
                       * emit JoinSuccessState
                       * bloc listener --> route.push(gameScreen(GameInfo))
                       */
                    },
                  );
                },
              );
            } else if (state is FailedToLoadGamesState) {
              return const Text("FAILED TO LOAD ACTIVE GAMES");
            } else {
              return const Text("INTERNAL ERROR");
            }
          },
        ),
      ),
    );
  }
}
