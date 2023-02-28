import "package:batonchess/bloc/home/home_bloc.dart";
import "package:batonchess/ui/screen/join_game_screen.dart";
import "package:batonchess/ui/screen/new_game_screen.dart";
import "package:batonchess/ui/screen/settings_screen.dart";
import "package:batonchess/ui/widget/button_bc.dart";
import "package:batonchess/ui/widget/dialog_bc.dart";
import "package:batonchess/ui/widget/empty_bc.dart";
import "package:batonchess/ui/widget/loading_bc.dart";
import "package:batonchess/utils/prettify_utils.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";

const mainBtnPadding = EdgeInsets.only(left: 80, right: 80, top: 8, bottom: 8);

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) => BlocProvider(
        create: (context) => HomeBloc()..add(FetchUserEvent()),
        child: Scaffold(
          appBar: AppBar(
            title: const Text("Batonchess"),
          ),
          body: BlocBuilder<HomeBloc, HomeState>(
            builder: (context, state) {
              if (state is FetchingUserState) {
                return const Center(child: LoadingBc(msg: "Signing in..."));
              }

              if (state is UserLoadedState) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Spacer(),
                    newGameButton(context),
                    joinGameButton(context),
                    settingsButton(context),
                    const Spacer(),
                    userInfo(state, context),
                  ],
                );
              }

              if (state is FailureLoadingUserState) {
                return Center(
                  child: DialogBc(
                    child: Column(
                      children: [
                        const Text("Failed to get a user"),
                        ButtonBc(
                          text: "Retry",
                          onPressed: () {
                            context.read<HomeBloc>().add(FetchUserEvent());
                          },
                        )
                      ],
                    ),
                  ),
                );
              }

              return const EmptyBc();
            },
          ),
        ),
      );

  Widget newGameButton(BuildContext context) => ButtonBc(
        text: "New Game",
        padding: mainBtnPadding,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const NewGameScreen()),
          );
        },
      );

  Widget joinGameButton(BuildContext context) => ButtonBc(
        text: "Join Game",
        padding: mainBtnPadding,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const JoinGameScreen()),
          );
        },
      );

  Widget settingsButton(BuildContext context) => ButtonBc(
        text: "Settings",
        padding: mainBtnPadding,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const SettingsScreen()),
          );
        },
      );

  Widget userInfo(UserLoadedState state, BuildContext context) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          showFullId(context, state),
          updateUsername(context, state),
        ],
      );

  ButtonBc updateUsername(BuildContext context, UserLoadedState state) =>
      ButtonBc(
        borderRadius: 4,
        padding: const EdgeInsets.all(8),
        expand: false,
        onPressed: () async => context.read<HomeBloc>().add(
              UpdateUsernameEvent(
                await showDialog(
                  context: context,
                  builder: changeUsernameDialog,
                ) as String?,
              ),
            ),
        text: state.user.name,
      );

  Widget showFullId(BuildContext context, UserLoadedState state) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: ButtonBc(
          expand: false,
          text: "ID: #${prettyId(state.user.id)}",
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) => DialogBc(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const Text("Full user ID:"),
                    Text("#${state.user.id}"),
                  ],
                ),
              ),
            );
          },
        ),
      );

  Widget changeUsernameDialog(BuildContext context) {
    String input = "";
    return DialogBc(
      action: ButtonBc(
        text: "Save",
        onPressed: () => Navigator.of(context).pop(input),
      ),
      child: TextField(
        decoration: const InputDecoration(
          fillColor: Colors.transparent,
          hintText: "Change username",
        ),
        onChanged: (changedText) {
          input = changedText;
        },
      ),
    );
  }
}
