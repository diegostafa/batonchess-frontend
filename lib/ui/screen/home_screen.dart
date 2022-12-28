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
  Widget build(BuildContext context) => BlocProvider(
        create: (context) => HomeBloc()..add(FetchUserEvent()),
        child: Scaffold(
          drawer: Drawer(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [Text("Active games")],
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: 30,
                    itemBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(index.toString()),
                    ),
                  ),
                ),
              ],
            ),
          ),
          appBar: AppBar(
            title: const Text("Baton Chess"),
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              newGameButton(context),
              joinGameButton(context),
              settingsButton(context),
              const Spacer(),
              userInfo(),
            ],
          ),
        ),
      );

  Widget newGameButton(BuildContext context) => ButtonBc(
        text: "New Game",
        padding: const EdgeInsets.only(left: 80, right: 80, top: 8, bottom: 8),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const NewGameScreen()),
          );
        },
      );

  Widget joinGameButton(BuildContext context) => ButtonBc(
        text: "Join Game",
        padding: const EdgeInsets.only(left: 80, right: 80, top: 8, bottom: 8),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const JoinGameScreen()),
          );
        },
      );

  Widget settingsButton(BuildContext context) => ButtonBc(
        text: "Settings",
        padding: const EdgeInsets.only(left: 80, right: 80, top: 8, bottom: 8),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const JoinGameScreen()),
          );
        },
      );

  Widget userInfo() => BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          if (state is UserLoadedState) {
            return Column(
              children: [
                ElevatedButton(
                  onPressed: () async => context.read<HomeBloc>().add(
                        UpdateUsernameEvent(
                          await promptNewUsername(context) as String?,
                        ),
                      ),
                  child: Text(state.user.name),
                ),
                Text("#${state.user.id}"),
              ],
            );
          } else {
            return const EmptyBc();
          }
        },
      );

  Widget changeUsernameDialog(BuildContext context) {
    String input = "";
    return SimpleDialog(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            decoration: const InputDecoration(hintText: "Change username"),
            onChanged: (changedText) {
              input = changedText;
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ButtonBc(
            text: "Save",
            onPressed: () => Navigator.of(context).pop(input),
          ),
        ),
      ],
    );
  }

  Future<dynamic> promptNewUsername(BuildContext context) => showDialog(
        context: context,
        builder: (context) => changeUsernameDialog(context),
      );
}
