import "package:batonchess/bloc/settings/settings_bloc.dart";
import "package:batonchess/ui/screen/home_screen.dart";
import "package:flex_color_scheme/flex_color_scheme.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SettingsBloc()..add(LoadSettingsEvent()),
      child: BlocBuilder<SettingsBloc, SettingsState>(
        builder: (context, state) {
          return MaterialApp(
            title: "Baton Chess",
            theme: FlexThemeData.light(
              scheme: FlexScheme.values[state.settings.themeIndex],
              useMaterial3: state.settings.useMaterial3,
            ),
            themeMode: ThemeMode.light,
            home: const HomeScreen(),
          );
        },
      ),
    );
  }
}
