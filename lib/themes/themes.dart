import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yahoapp/themes/app_colors.dart';

enum AppThemeKeys { light, dark }

final Map<AppThemeKeys, ThemeData> _themes = {
  AppThemeKeys.light: ThemeData(
    primaryColor: AppColorLight.primary,
    backgroundColor: Colors.white,
    fontFamily: 'Roboto',
    indicatorColor: AppColorLight.primary,
    appBarTheme: const AppBarTheme(
      color: AppColorLight.primary,
      elevation: 0,
      titleTextStyle: TextStyle(
        fontSize: 18,
        color: Colors.white,
        fontWeight: FontWeight.w600,
      ),
    ),
    textTheme: const TextTheme(
      headline1: TextStyle(
        fontFamily: 'Roboto',
        fontWeight: FontWeight.w500,
        fontSize: 18,
        color: Colors.white,
      ),
      subtitle1: TextStyle(
        fontFamily: 'Roboto',
        fontWeight: FontWeight.w500,
        fontSize: 16,
        color: Colors.black,
      ),
      bodyText1: TextStyle(
        fontFamily: 'Roboto',
        fontSize: 14,
        color: AppColorLight.gray,
      ),
    ),
  ),
  AppThemeKeys.dark: ThemeData(
    backgroundColor: Colors.black,
    primaryColor: Colors.black,
    fontFamily: 'Roboto',
    indicatorColor: Colors.white,
    appBarTheme: const AppBarTheme(
      color: Colors.black,
      elevation: 0,
      titleTextStyle: TextStyle(
        fontSize: 18,
        color: Colors.white,
        fontWeight: FontWeight.w600,
      ),
    ),
    textTheme: const TextTheme(
      headline1: TextStyle(
        fontFamily: 'Roboto',
        fontWeight: FontWeight.w500,
        fontSize: 18,
        color: Colors.white,
      ),
      subtitle1: TextStyle(
        fontFamily: 'Roboto',
        fontWeight: FontWeight.w500,
        fontSize: 16,
        color: Colors.white,
      ),
      bodyText1: TextStyle(
        fontFamily: 'Roboto',
        fontSize: 14,
        color: Colors.white,
      ),
    ),
  ),
};

class AppTheme extends ChangeNotifier {
  static AppTheme of(BuildContext context, {bool listen = false}) =>
      Provider.of<AppTheme>(context, listen: listen);

  // Đây sẽ là state chính của class, chứa tên của theme, mặc định mình set là light
  AppThemeKeys _themeKey = AppThemeKeys.light;

  ThemeData get currentTheme => _themes[_themeKey]!;
  AppThemeKeys get currentThemeKey => _themeKey;

  void setTheme(AppThemeKeys themeKey) {
    _themeKey = themeKey;
    notifyListeners();
  }

  void switchTheme() {
    if (_themeKey == AppThemeKeys.dark) {
      _themeKey = AppThemeKeys.light;
    } else {
      _themeKey = AppThemeKeys.dark;
    }
    notifyListeners();
  }
}
