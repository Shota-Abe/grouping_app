
import 'package:flutter/material.dart';

import 'my_home_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeClass.lightTheme,
      darkTheme: ThemeClass.darkTheme,
      themeMode: ThemeMode.system,
      home: MyHomePage(),
    );
  }
}

class ThemeClass {
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    colorSchemeSeed: Colors.cyan,
    textTheme: TextThemeClass.textTheme,
    appBarTheme: AppBarThemeClass.appBarTheme,
  );

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    colorSchemeSeed: Colors.cyan,
    textTheme: TextThemeClass.textTheme,
    appBarTheme: AppBarThemeClass.appBarTheme,
  );
}

class TextThemeClass {
  static TextTheme textTheme = TextTheme(
      titleLarge: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
      bodyMedium: TextStyle(fontSize: 17, fontWeight: FontWeight.normal));
}

class AppBarThemeClass {
  static AppBarTheme appBarTheme = AppBarTheme(
    toolbarHeight: 44,
  );
}
