import 'package:batonchess/bloc/model/game_props.dart';
import 'package:batonchess/bloc/new_game/new_game_bloc.dart';
import 'package:batonchess/ui/screen/game_screen.dart';
import 'package:batonchess/ui/widget/button_bc.dart';
import 'package:batonchess/ui/widget/selection_group_bc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewGameScreen extends StatelessWidget {
  const NewGameScreen({super.key});

  @override
  Widget build(BuildContext context) => BlocProvider(
        create: (context) => NewGameBloc(),
        child: BlocBuilder<NewGameBloc, NewGameState>(
            builder: (context, state) => Scaffold(
                  appBar: AppBar(
                    title: const Text('Game properties'),
                  ),
                  body: BlocBuilder<NewGameBloc, NewGameState>(
                      builder: (context, state) => Column(
                            children: [
                              playAsSelection(context),
                              playersPerSideSelection(context),
                              ButtonBc(text: "Time format", onPressed: () {}),
                              const Spacer(),
                              submitCreateGameButton(context, state)
                            ],
                          )),
                )),
      );

  SelectionGroupBc playAsSelection(BuildContext context) => SelectionGroupBc(
        label: "Play as",
        isRow: true,
        padding: const EdgeInsets.all(8),
        values: const ["Random", "White", "Black"],
        onSelected: (s, index, isSelected) =>
            context.read<NewGameBloc>().add(ChangeSideRadioEvent(index)),
      );

  SelectionGroupBc playersPerSideSelection(BuildContext context) =>
      SelectionGroupBc(
        label: "Players per side",
        isRow: true,
        padding: const EdgeInsets.all(8),
        values: const ["1", "5", "10", "20"],
        onSelected: (s, index, isSelected) =>
            context.read<NewGameBloc>().add(ChangeSideRadioEvent(index)),
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
