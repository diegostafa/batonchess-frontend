import 'package:batonchess/bloc/home/home_bloc.dart';
import 'package:batonchess/data/model/game/game_info.dart';
import 'package:batonchess/ui/screen/join_game_screen.dart';
import 'package:batonchess/ui/screen/new_game_screen.dart';
import 'package:batonchess/ui/widget/button_bc.dart';
import 'package:batonchess/ui/widget/empty_bc.dart';
import 'package:batonchess/ui/widget/join_game_card_bc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) => BlocProvider(
        create: (context) => HomeBloc()..add(FetchUserEvent()),
        child: Scaffold(
          drawer: historyPanel(),
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

  Drawer historyPanel() {
    return Drawer(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [Text("Games history")],
          ),
          Expanded(
            /**
             * todo:
             * - home bloc --> add game info history
             * - history is saved locally
             * - userRepo.getGamesHistory
             * - every time you join a game save the game info locally
             * - add clear history button
             */
            child: ListView.builder(
              itemCount: 5,
              itemBuilder: (context, index) => JoinGameCardBc(
                onTap: () {},
                gameInfo: GameInfo(
                  gameId: 1,
                  creatorName: "anon",
                  gameStatus: "NORMAL",
                  createdAt: "yesterday",
                  maxPlayers: 10,
                  currentPlayers: 5,
                ),
              ),
            ),
          ),
          ButtonBc(borderRadius: 0, text: "Clear history", onPressed: () {})
        ],
      ),
    );
  }

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
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('COMING SOON'),
            ),
          );
        },
      );

  Widget userInfo() => BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          if (state is UserLoadedState) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextButton(
                    child: Text("User ID: #${state.user.prettyId()}"),
                    onPressed: () {},
                  ),
                ),
                ButtonBc(
                  borderRadius: 4,
                  padding: const EdgeInsets.all(8),
                  expand: false,
                  onPressed: () async => context.read<HomeBloc>().add(
                        UpdateUsernameEvent(
                          await promptNewUsername(context) as String?,
                        ),
                      ),
                  text: "Username: ${state.user.name}",
                ),
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
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
      ),
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
