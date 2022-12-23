import 'package:batonchess/bloc/home/home_bloc.dart';
import 'package:batonchess/ui/screen/join_game_screen.dart';
import 'package:batonchess/ui/screen/new_game_screen.dart';
import 'package:batonchess/ui/widget/button_bc.dart';
import 'package:batonchess/ui/widget/empty_bc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeBloc()..add(FetchUserEvent()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Baton Chess"),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            newGameButton(context),
            joinGameButton(context),
            const Spacer(),
            userInfo(),
          ],
        ),
      ),
    );
  }

  Widget userInfo() {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        if (state is UserLoadedState) {
          return Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Username:"),
                  TextButton(
                    onPressed: () async => context.read<HomeBloc>().add(
                          UpdateUsernameEvent(
                            await promptNewUsername(context) as String?,
                          ),
                        ),
                    child: Text(state.user.name),
                  )
                ],
              ),
              Text(state.user.id),
            ],
          );
        } else {
          return const EmptyBc();
        }
      },
    );
  }

  Widget joinGameButton(BuildContext context) {
    return ButtonBc(
      text: "Join Game",
      padding: const EdgeInsets.only(left: 80, right: 80, top: 8, bottom: 8),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const JoinGameScreen()),
        );
      },
    );
  }

  Widget newGameButton(BuildContext context) {
    return ButtonBc(
      text: "New Game",
      padding: const EdgeInsets.only(left: 80, right: 80, top: 8, bottom: 8),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const NewGameScreen()),
        );
      },
    );
  }

  Widget changeUsernameDialog(BuildContext context) {
    String input = "";
    return SimpleDialog(
      contentPadding: const EdgeInsets.all(20),
      children: [
        TextField(
          decoration: const InputDecoration(hintText: "Change username"),
          onChanged: (changedText) {
            input = changedText;
          },
        ),
        ButtonBc(
          text: "Save",
          onPressed: () => Navigator.of(context).pop(input),
        ),
      ],
    );
  }

  Future<dynamic> promptNewUsername(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
        return changeUsernameDialog(context);
      },
    );
  }
}
