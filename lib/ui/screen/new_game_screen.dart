import 'package:batonchess/bloc/new_game/new_game_bloc.dart';
import 'package:batonchess/ui/screen/game_screen.dart';
import 'package:batonchess/ui/widget/button_bc.dart';
import 'package:batonchess/ui/widget/container_bc.dart';
import 'package:batonchess/ui/widget/selection_group_bc.dart';
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
              if (state is SuccessCreateGameState) {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const GameScreen()),
                );
              }
              // TODO: implement listener
            },
            child: BlocBuilder<NewGameBloc, NewGameState>(
              builder: (context, state) {
                if (state is GamePropsState) {
                  return stateIsGameProps(context, state);
                } else if (state is IsCreatingGameState) {
                  return const Text("Creating GAme.....");
                } else {
                  return const Text("FAILURE");
                }
              },
            ),
          ),
        ),
      );

  Column stateIsGameProps(BuildContext context, GamePropsState state) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(child: playAsSelection(context)),
          ],
        ),
        Row(
          children: [
            Expanded(child: maxPlayersSelection(context)),
          ],
        ),
        // minutesPerSideSlider(state, context),
        // secondsPerMoveSlider(state, context),
        const Spacer(),
        submitCreateGameButton(context, state)
      ],
    );
  }

  // ContainerBc secondsPerMoveSlider(NewGameState state, BuildContext context) {
  //   return ContainerBc(
  //     padding: const EdgeInsets.all(10),
  //     margin: const EdgeInsets.all(10),
  //     child: Column(
  //       children: [
  //         Text(
  //           "Increment per move: ${(state as GamePropsState).incPerMove}s",
  //         ),
  //         SliderBc(
  //           initialValue: state.incPerMove.toDouble(),
  //           minValue: 0,
  //           maxValue: 10,
  //           isDiscrete: true,
  //           onDragging: (handlerIndex, lowerValue, upperValue) {
  //             context.read<NewGameBloc>().add(
  //                   ChangeSecondsPerMoveEvent((lowerValue as double).toInt()),
  //                 );
  //           },
  //         ),
  //       ],
  //     ),
  //   );
  // }

  // ContainerBc minutesPerSideSlider(NewGameState state, BuildContext context) {
  //   return ContainerBc(
  //     padding: const EdgeInsets.all(10),
  //     margin: const EdgeInsets.all(10),
  //     child: Column(
  //       children: [
  //         Text("Minutes per side: ${(state as GamePropsState).minPerSide}"),
  //         SliderBc(
  //           initialValue: state.minPerSide.toDouble(),
  //           minValue: 1,
  //           maxValue: 10,
  //           isDiscrete: true,
  //           onDragging: (handlerIndex, lowerValue, upperValue) {
  //             context.read<NewGameBloc>().add(
  //                   ChangeMinutesPerSideEvent((lowerValue as double).toInt()),
  //                 );
  //           },
  //         ),
  //       ],
  //     ),
  //   );
  // }

  ContainerBc playAsSelection(BuildContext context) => ContainerBc(
        margin: const EdgeInsets.all(10),
        child: SelectionGroupBc(
          label: "Play as:",
          padding: const EdgeInsets.all(8),
          values: const ["White", "Black"],
          onSelected: (s, index, isSelected) =>
              context.read<NewGameBloc>().add(ChangeSideRadioEvent(index)),
        ),
      );

  ContainerBc maxPlayersSelection(BuildContext context) => ContainerBc(
        margin: const EdgeInsets.all(10),
        child: SelectionGroupBc(
          label: "Max players:",
          padding: const EdgeInsets.all(8),
          values: const ["1", "5", "10", "20"],
          onSelected: (s, index, isSelected) => context
              .read<NewGameBloc>()
              .add(ChangeMaxPlayersRadioEvent(index)),
        ),
      );

  ButtonBc submitCreateGameButton(BuildContext context, NewGameState state) =>
      ButtonBc(
        padding: const EdgeInsets.all(8),
        text: "Create game",
        onPressed: () {
          context.read<NewGameBloc>().add(SubmitCreateGameEvent());
        },
      );
}
