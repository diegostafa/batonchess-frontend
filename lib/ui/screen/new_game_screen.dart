import 'package:batonchess/bloc/new_game/new_game_bloc.dart';
import 'package:batonchess/ui/screen/game_screen.dart';
import 'package:batonchess/ui/widget/button_bc.dart';
import 'package:batonchess/ui/widget/container_bc.dart';
import 'package:batonchess/ui/widget/selection_group_bc.dart';
import 'package:batonchess/ui/widget/slider_bc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewGameScreen extends StatelessWidget {
  const NewGameScreen({super.key});

  @override
  Widget build(BuildContext context) => BlocProvider(
        create: (context) => NewGameBloc(),
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Game properties'),
          ),
          body: BlocListener<NewGameBloc, NewGameState>(
            listener: (context, state) {
              if (state is SuccessCreatingGameState) {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        GameScreen(initialGameState: state.joinedGame),
                  ),
                );
              }
            },
            child: BlocBuilder<NewGameBloc, NewGameState>(
              builder: (context, state) {
                if (state is SettingGamePropsState) {
                  return stateIsGameProps(context, state);
                } else if (state is CreatingGameState) {
                  return const Text("LOADING: CREATING GAME...");
                } else if (state is SuccessCreatingGameState) {
                  return const Text("GAME CREATED, JOINING...");
                } else {
                  return const Text("FAILED TO CREATE THE GAME, GO BACK");
                }
              },
            ),
          ),
        ),
      );

  Column stateIsGameProps(BuildContext context, SettingGamePropsState state) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(child: playAsSelection(context)),
          ],
        ),
        Row(
          children: [
            Expanded(child: maxPlayersSelection(state, context)),
          ],
        ),
        const Spacer(),
        submitCreateGameButton(context, state)
      ],
    );
  }

  ContainerBc playAsSelection(BuildContext context) => ContainerBc(
        padding: const EdgeInsets.all(20),
        margin: const EdgeInsets.only(left: 40, top: 10, right: 40, bottom: 10),
        child: SelectionGroupBc(
          label: "Play as:",
          padding: const EdgeInsets.all(8),
          values: const ["White", "Black"],
          onSelected: (s, index, isSelected) =>
              context.read<NewGameBloc>().add(ChangeSideEvent(index)),
        ),
      );

  ContainerBc maxPlayersSelection(NewGameState state, BuildContext context) {
    return ContainerBc(
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.only(left: 40, top: 10, right: 40, bottom: 10),
      child: Column(
        children: [
          Text("Groups size: ${(state as SettingGamePropsState).maxPlayers}"),
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
    );
  }

  ButtonBc submitCreateGameButton(BuildContext context, NewGameState state) =>
      ButtonBc(
        padding: const EdgeInsets.all(8),
        text: "Create game",
        onPressed: () {
          context.read<NewGameBloc>().add(SubmitCreateGameEvent());
        },
      );
}
