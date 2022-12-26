import 'package:batonchess/bloc/new_game/new_game_bloc.dart';
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
          body: BlocBuilder<NewGameBloc, NewGameState>(
            builder: (context, state) => Column(
              children: [
                playAsSelection(context),
                playersPerSideSelection(context),
                Row(
                  children: [
                    Expanded(
                      child: minutesPerSideSlider(state, context),
                    ),
                    Expanded(
                      child: secondsPerMoveSlider(state, context),
                    ),
                  ],
                ),
                const Spacer(),
                submitCreateGameButton(context, state)
              ],
            ),
          ),
        ),
      );

  ContainerBc secondsPerMoveSlider(NewGameState state, BuildContext context) {
    return ContainerBc(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.all(10),
      child: Column(
        children: [
          Text("Increment per move (in seconds): ${state.secondsPerMove}"),
          SliderBc(
            initialValue: state.secondsPerMove.toDouble(),
            minValue: 0,
            maxValue: 10,
            isDiscrete: true,
            onDragging: (handlerIndex, lowerValue, upperValue) {
              context.read<NewGameBloc>().add(
                  ChangeSecondsPerMoveEvent((lowerValue as double).toInt()),);
            },
          ),
        ],
      ),
    );
  }

  ContainerBc minutesPerSideSlider(NewGameState state, BuildContext context) {
    return ContainerBc(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.all(10),
      child: Column(
        children: [
          Text("Minutes per side: ${state.minPerSide}"),
          SliderBc(
            initialValue: state.minPerSide.toDouble(),
            minValue: 1,
            maxValue: 10,
            isDiscrete: true,
            onDragging: (handlerIndex, lowerValue, upperValue) {
              context.read<NewGameBloc>().add(
                  ChangeMinutesPerSideEvent((lowerValue as double).toInt()),);
            },
          ),
        ],
      ),
    );
  }

  ContainerBc playAsSelection(BuildContext context) => ContainerBc(
        margin: const EdgeInsets.all(10),
        child: SelectionGroupBc(
          label: "Play as",
          isRow: true,
          padding: const EdgeInsets.all(8),
          values: const ["Random", "White", "Black"],
          onSelected: (s, index, isSelected) =>
              context.read<NewGameBloc>().add(ChangeSideRadioEvent(index)),
        ),
      );

  ContainerBc playersPerSideSelection(BuildContext context) => ContainerBc(
        margin: const EdgeInsets.all(10),
        child: SelectionGroupBc(
          label: "Players per side",
          isRow: true,
          padding: const EdgeInsets.all(8),
          values: const ["1", "5", "10", "20"],
          onSelected: (s, index, isSelected) =>
              context.read<NewGameBloc>().add(ChangeSideRadioEvent(index)),
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
