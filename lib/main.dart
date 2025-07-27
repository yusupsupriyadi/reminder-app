import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'app/modules/settings/controllers/theme_controller.dart';
import 'app/routes/app_pages.dart';

void main() async {
  await GetStorage.init();
  Get.put(ThemeController());

  runApp(
    GetMaterialApp(
      title: 'Reminder App',
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      debugShowCheckedModeBanner: false,
      theme: _lightTheme(),
      darkTheme: _darkTheme(),
      themeMode: ThemeMode.system,
    ),
  );
}

ThemeData _lightTheme() {
  const softBlack = Color(0xFF1A1A1A);
  const offWhite = Color(0xFFFAFAFA);
  const lightGrey = Color(0xFFE0E0E0);

  return ThemeData(
    brightness: Brightness.light,
    primaryColor: softBlack,
    scaffoldBackgroundColor: offWhite,
    appBarTheme: const AppBarTheme(backgroundColor: offWhite, foregroundColor: softBlack, elevation: 0),
    colorScheme: const ColorScheme.light(
      primary: softBlack,
      secondary: softBlack,
      surface: Colors.white,
      onSurface: softBlack,
    ),
    cardTheme: CardThemeData(
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(6),
        side: BorderSide(color: softBlack.withOpacity(0.12), width: 1),
      ),
    ),
    switchTheme: SwitchThemeData(
      thumbColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return softBlack;
        }
        return lightGrey;
      }),
      trackColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return softBlack.withOpacity(0.3);
        }
        return softBlack.withOpacity(0.08);
      }),
      trackOutlineColor: WidgetStateProperty.all(softBlack.withOpacity(0.2)),
    ),
  );
}

ThemeData _darkTheme() {
  const darkGrey = Color(0xFF121212);
  const lightGrey = Color(0xFFE8E8E8);
  const mediumGrey = Color(0xFF1E1E1E);
  const darkGreyLight = Color(0xFF2C2C2C);

  return ThemeData(
    brightness: Brightness.dark,
    primaryColor: lightGrey,
    scaffoldBackgroundColor: darkGrey,
    appBarTheme: const AppBarTheme(backgroundColor: darkGrey, foregroundColor: lightGrey, elevation: 0),
    colorScheme: const ColorScheme.dark(
      primary: lightGrey,
      secondary: lightGrey,
      surface: mediumGrey,
      onSurface: lightGrey,
    ),
    cardTheme: CardThemeData(
      color: mediumGrey,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(6),
        side: BorderSide(color: lightGrey.withOpacity(0.12), width: 1),
      ),
    ),
    switchTheme: SwitchThemeData(
      thumbColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return lightGrey;
        }
        return darkGreyLight;
      }),
      trackColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return lightGrey.withOpacity(0.3);
        }
        return lightGrey.withOpacity(0.08);
      }),
      trackOutlineColor: WidgetStateProperty.all(lightGrey.withOpacity(0.2)),
    ),
  );
}
