import "package:batonchess/bloc/new_game/new_game_bloc.dart";
import "package:batonchess/ui/screen/game_screen.dart";
import "package:batonchess/ui/widget/button_bc.dart";
import "package:batonchess/ui/widget/container_bc.dart";
import "package:batonchess/ui/widget/loading_bc.dart";
import "package:batonchess/ui/widget/selection_group_bc.dart";
import "package:batonchess/ui/widget/slider_bc.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";

class NewGameScreen extends StatelessWidget {
  const NewGameScreen({super.key});

  @override
  Widget build(BuildContext context) => BlocProvider(
        create: (context) => NewGameBloc(),
        child: Scaffold(
          appBar: AppBar(
            title: const Text("Game properties"),
          ),
          body: BlocListener<NewGameBloc, NewGameState>(
            listener: (context, state) {
              if (state is SuccessCreatingGameState) {
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
            child: newGameScreenBody(),
          ),
        ),
      );

  Widget newGameScreenBody() => BlocBuilder<NewGameBloc, NewGameState>(
      builder: (context, state) {
        if (state is SettingGamePropsState) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              newGameProps(context, state),
              submitCreateGameButton(context, state)
            ],
          );
        }

        if (state is CreatingGameState) {
          return const Center(child: LoadingBc(msg: "Creating the game"));
        }

        if (state is SuccessCreatingGameState) {
          return const Center(
              child: LoadingBc(msg: "Success, creating the game, now joining"),);
        }

        return const Center(child: Text("FAILED CREATING THE GAME, GO BACK"));
      },
    );

  Widget newGameProps(BuildContext context, SettingGamePropsState state) => Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          chooseSide(context),
          chooseMaxPlayers(state, context),
        ],
      ),
    );

  Widget chooseSide(BuildContext context) => ContainerBc(
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.only(left: 40, top: 20, right: 40, bottom: 20),
      child: SelectionGroupBc(
        label: "Play as",
        padding: const EdgeInsets.all(8),
        values: const ["White", "Black"],
        onSelected: (s, index, isSelected) =>
            context.read<NewGameBloc>().add(ChangeSideEvent(index)),
      ),
    );

  Widget chooseMaxPlayers(
    SettingGamePropsState state,
    BuildContext context,
  ) => ContainerBc(
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.only(left: 40, top: 20, right: 40, bottom: 20),
      child: Row(
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Groups size: ${state.maxPlayers}"),
                SliderBc(
                  initialValue: state.maxPlayers,
                  minValue: 1,
                  maxValue: 10,
                  isDiscrete: true,
                  onDragging: (handlerIndex, lowerValue, upperValue) {
                    context.read<NewGameBloc>().add(
                          ChangeMaxPlayersEvent((lowerValue as double).toInt()),
                        );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );

  Widget submitCreateGameButton(BuildContext context, NewGameState state) =>
      ButtonBc(
        padding: const EdgeInsets.all(8),
        text: "Create game",
        onPressed: () {
          context.read<NewGameBloc>().add(SubmitCreateGameEvent());
        },
      );
}
