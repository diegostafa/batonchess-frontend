enum BcTheme { red, blue, green }

class BatonchessSettings {
  final bool useMaterial3;
  final int themeIndex;

  const BatonchessSettings({
    required this.useMaterial3,
    required this.themeIndex,
  });

  BatonchessSettings copyWith({
    bool? useMaterial3,
    int? themeIndex,
  }) =>
      BatonchessSettings(
        useMaterial3: useMaterial3 ?? this.useMaterial3,
        themeIndex: themeIndex ?? this.themeIndex,
      );
}
