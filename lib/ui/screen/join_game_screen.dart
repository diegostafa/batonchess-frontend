import "package:batonchess/bloc/join_game/join_game_bloc.dart";
import "package:batonchess/ui/screen/game_screen.dart";
import "package:batonchess/ui/widget/button_bc.dart";
import "package:batonchess/ui/widget/join_game_card_bc.dart";
import "package:batonchess/ui/widget/selection_group_bc.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";

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
        body: BlocListener<JoinGameBloc, JoinGameState>(
          listener: (context, state) {
            if (state is JoiningGameState) {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => GameScreen(
                    gameInfo: state.gameInfo,
                    joinReq: state.joinReq,
                  ),
                ),
              );
            }
          },
          child: BlocBuilder<JoinGameBloc, JoinGameState>(
            builder: (context, state) {
              if (state is SuccessLoadingGamesState) {
                return ListView.builder(
                  itemCount: state.games.length,
                  itemBuilder: (context, gameIndex) {
                    return joinGameCard(state, gameIndex, context);
                  },
                );
              } else if (state is FailureLoadingGamesState) {
                return const Text("FAILED TO LOAD ACTIVE GAMES");
              } else {
                return const Text("INTERNAL ERROR");
              }
            },
          ),
        ),
      ),
    );
  }

  JoinGameCardBc joinGameCard(
    SuccessLoadingGamesState state,
    int gameIndex,
    BuildContext context,
  ) {
    return JoinGameCardBc(
      gameInfo: state.games[gameIndex],
      onTap: () async {
        context.read<JoinGameBloc>().add(
              SubmitJoinGameEvent(
                state.games[gameIndex],
                await promptSide(context) as int?,
              ),
            );
      },
    );
  }

  Widget chooseSideDialog(BuildContext context) {
    int sideIndex = 0;
    return SimpleDialog(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
      ),
      children: [
        SelectionGroupBc(
          label: "Play as:",
          padding: const EdgeInsets.all(8),
          values: const ["White", "Black"],
          onSelected: (s, index, isSelected) {
            sideIndex = index;
          },
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ButtonBc(
            text: "Confirm",
            onPressed: () => Navigator.of(context).pop(sideIndex),
          ),
        ),
      ],
    );
  }

  Future<dynamic> promptSide(BuildContext context) => showDialog(
        context: context,
        builder: (context) => chooseSideDialog(context),
      );
}
