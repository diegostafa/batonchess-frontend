import "package:batonchess/bloc/join_game/join_game_bloc.dart";
import "package:batonchess/ui/screen/game_screen.dart";
import "package:batonchess/ui/widget/button_bc.dart";
import "package:batonchess/ui/widget/dialog_bc.dart";
import "package:batonchess/ui/widget/empty_bc.dart";
import "package:batonchess/ui/widget/join_game_card_bc.dart";
import "package:batonchess/ui/widget/loading_bc.dart";
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
          child: RefreshIndicator(
            triggerMode: RefreshIndicatorTriggerMode.anywhere,
            onRefresh: () {
              return Future(
                () => context.read<JoinGameBloc>().add(FetchGamesEvent()),
              );
            },
            child: BlocBuilder<JoinGameBloc, JoinGameState>(
              builder: (context, state) {
                return RefreshIndicator(
                  triggerMode: RefreshIndicatorTriggerMode.anywhere,
                  onRefresh: () {
                    return Future(
                      () => context.read<JoinGameBloc>().add(FetchGamesEvent()),
                    );
                  },
                  child: pageBody(state),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget pageBody(JoinGameState state) {
    if (state is FetchingGamesState) {
      return const Center(
        child: LoadingBc(
          msg: "Loading active games...",
        ),
      );
    }

    if (state is SuccessLoadingGamesState) {
      if (state.games.isEmpty) {
        return const Center(
          child: Text("There are no active games"),
        );
      } else {
        return ListView.builder(
          itemCount: state.games.length,
          itemBuilder: (context, gameIndex) {
            return joinGameCard(state, gameIndex, context);
          },
        );
      }
    }

    if (state is FailureLoadingGamesState) {
      return const Text("Couldn't retrieve active games");
    }

    return const EmptyBc();
  }

  Widget joinGameCard(
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
                await showDialog(
                  context: context,
                  builder: (context) => chooseSideDialog(context),
                ) as int?,
              ),
            );
      },
    );
  }

  Widget chooseSideDialog(BuildContext context) {
    int sideIndex = 0;
    return DialogBc(
      action: ButtonBc(
        text: "Confirm",
        onPressed: () => Navigator.of(context).pop(sideIndex),
      ),
      child: SelectionGroupBc(
        label: "Play as:",
        padding: const EdgeInsets.all(8),
        values: const ["White", "Black"],
        onSelected: (s, index, isSelected) {
          sideIndex = index;
        },
      ),
    );
  }
}
