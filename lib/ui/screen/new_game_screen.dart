import 'package:batonchess/bloc/new_game/new_game_bloc.dart';
import 'package:batonchess/ui/screen/game_screen.dart';
import 'package:batonchess/ui/widget/button_bc.dart';
import 'package:batonchess/ui/widget/selection_group_bc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:group_button/group_button.dart';

class NewGameScreen extends StatelessWidget {
  const NewGameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NewGameBloc(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Game properties'),
        ),
        body: BlocBuilder<NewGameBloc, NewGameState>(
          builder: (context, state) {
            return Column(
              children: [
                playAsSelection(context),
                playersPerSideSelection(context),
                SelectionGroupBc(
                  label: "Time format",
                  padding: const EdgeInsets.all(100),
                  values: const [
                    "1+0",
                    "2+1",
                    "3+0",
                    "3+2",
                    "5+0",
                    "5+3",
                    "10+0",
                    "10+5",
                    "15+10",
                  ],
                  onSelected: (s, index, isSelected) => context
                      .read<NewGameBloc>()
                      .add(ChangeSideRadioEvent(index)),
                ),
                const Spacer(),
                submitCreateGameButton(context),
              ],
            );
          },
        ),
      ),
    );
  }

  ButtonBc submitCreateGameButton(BuildContext context) {
    return ButtonBc(
      padding: const EdgeInsets.all(8),
      text: "Create game",
      onPressed: () {
        context.read<NewGameBloc>().add(SubmitCreateGameEvent());
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const GameScreen(),
          ),
        );
      },
    );
  }

  SelectionGroupBc playersPerSideSelection(BuildContext context) {
    return SelectionGroupBc(
      label: "Players per side",
      isRow: true,
      padding: const EdgeInsets.all(8),
      values: const ["1", "5", "10", "20"],
      onSelected: (s, index, isSelected) =>
          context.read<NewGameBloc>().add(ChangeSideRadioEvent(index)),
    );
  }

  SelectionGroupBc playAsSelection(BuildContext context) {
    return SelectionGroupBc(
      label: "Play as",
      isRow: true,
      padding: const EdgeInsets.all(8),
      values: const ["Random", "White", "Black"],
      onSelected: (s, index, isSelected) =>
          context.read<NewGameBloc>().add(ChangeSideRadioEvent(index)),
    );
  }
}
