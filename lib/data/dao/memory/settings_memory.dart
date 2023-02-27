import "package:batonchess/data/model/batonchess_settings.dart";
import "package:shared_preferences/shared_preferences.dart";

class SettingsMemory {
  factory SettingsMemory() => _singleton;
  SettingsMemory._internal();
  static final SettingsMemory _singleton = SettingsMemory._internal();

  Future<void> setSettings(BatonchessSettings s) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool("use_material_3", s.useMaterial3);
    await prefs.setInt("theme_index", s.themeIndex);
  }

  Future<BatonchessSettings?> getSettings() async {
    final prefs = await SharedPreferences.getInstance();
    final useMat3 = prefs.getBool("use_material_3");
    final themeIndex = prefs.getInt("theme_index");

    if (useMat3 == null || themeIndex == null) return null;
    return BatonchessSettings(useMaterial3: useMat3, themeIndex: themeIndex);
  }
}
