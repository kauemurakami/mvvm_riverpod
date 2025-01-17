import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mvvm_statemanagements/constants/my_app_constants.dart';
import 'package:mvvm_statemanagements/enums/theme_enums.dart';
import 'package:shared_preferences/shared_preferences.dart';

//provider
// ChangeNotifierProvider<ThemeProvider>(create: (_)=> ThemeProvider())
//riverpod        //<providerclass, state>
final themeProvider = StateNotifierProvider<ThemeProvider, ThemeEnums>(
  (_) => ThemeProvider(),
);

class ThemeProvider extends StateNotifier<ThemeEnums> {
  ThemeProvider() : super(ThemeEnums.light) {
    _loadTheme();
  }

  Future<void> _loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final bool isDarkMode = prefs.getBool(MyAppConstants.isDarkThemeKey) ?? false;
    state = isDarkMode ? ThemeEnums.dark : ThemeEnums.light;
  }

  Future<void> toggleTheme() async {
    final prefs = await SharedPreferences.getInstance();
    if (state == ThemeEnums.light) {
      state = ThemeEnums.dark;
      await prefs.setBool(MyAppConstants.isDarkThemeKey, true);
    } else {
      state = ThemeEnums.light;
      await prefs.setBool(MyAppConstants.isDarkThemeKey, false);
    }
  }
}
