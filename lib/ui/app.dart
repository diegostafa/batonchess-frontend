import "package:batonchess/ui/screen/home_screen.dart";
import "package:flex_color_scheme/flex_color_scheme.dart";
import "package:flutter/material.dart";

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
        title: "Baton Chess",
        theme: lightTheme(),
        darkTheme: darkTheme(),
        themeMode: ThemeMode.light,
        home: const HomeScreen(),
      );

  ThemeData lightTheme() =>
      FlexThemeData.light(scheme: FlexScheme.rosewood, useMaterial3: true);

  ThemeData darkTheme() =>
      FlexThemeData.dark(scheme: FlexScheme.deepBlue, useMaterial3: true);
}
