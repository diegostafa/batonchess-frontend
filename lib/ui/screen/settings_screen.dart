import "package:batonchess/bloc/settings/settings_bloc.dart";
import "package:batonchess/ui/widget/container_bc.dart";
import "package:dropdown_button2/dropdown_button2.dart";
import "package:flex_color_scheme/flex_color_scheme.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";

const themes = FlexScheme.values;

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final settingsBloc = BlocProvider.of<SettingsBloc>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
      ),
      body: BlocBuilder<SettingsBloc, SettingsState>(
        builder: (context, state) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ContainerBc(
                padding: const EdgeInsets.all(20),
                margin: const EdgeInsets.only(
                  left: 40,
                  top: 20,
                  right: 40,
                  bottom: 20,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Use material 3"),
                    Switch(
                      value: state.settings.useMaterial3,
                      onChanged: (_) {
                        settingsBloc.add(ToggleMaterial3Event());
                      },
                    )
                  ],
                ),
              ),
              ContainerBc(
                padding: const EdgeInsets.all(20),
                margin: const EdgeInsets.only(
                  left: 40,
                  top: 20,
                  right: 40,
                  bottom: 20,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Flexible(child: Text("Change global theme")),
                    Flexible(
                      child: DropdownButton2(
                        isExpanded: true,
                        hint: Text(
                          themes[state.settings.themeIndex].name.capitalize,
                          overflow: TextOverflow.ellipsis,
                        ),
                        onChanged: (value) {
                          if (value != null) {
                            settingsBloc
                                .add(ChangeThemeEvent(int.parse(value)));
                          }
                        },
                        items: themes
                            .map(
                              (theme) => DropdownMenuItem<String>(
                                value: theme.index.toString(),
                                child: Text(theme.name),
                              ),
                            )
                            .toList(),
                      ),
                    ),
                  ],
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
