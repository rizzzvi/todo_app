import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app/models/tasksProvider.dart';
import 'package:todo_app/screens/todo_list.dart';
import 'package:provider/provider.dart';

import 'global.dart';

final darkTheme = ThemeData(
  primarySwatch: Colors.grey,
  primaryColor: Colors.grey[800],
  brightness: Brightness.dark,
  backgroundColor: const Color(0xFF212121),
  accentColor: Colors.yellow[700],
  accentIconTheme: IconThemeData(color: Colors.black),
  dividerColor: Colors.grey[800],
);

final lightTheme = ThemeData(
  appBarTheme: AppBarTheme(
    color: Colors.green,
  ),
  primarySwatch: Colors.grey,
  primaryColor: Colors.white,
  accentColor: Colors.black38,
  brightness: Brightness.light,
  backgroundColor: const Color(0xFFE5E5E5),
  accentIconTheme: IconThemeData(color: Colors.grey[600]),
  dividerColor: Colors.white54,
);

class ThemeNotifier with ChangeNotifier {
  ThemeData _themeData;

  ThemeNotifier(this._themeData);

  getTheme() => _themeData;

  setTheme(ThemeData themeData) async {
    _themeData = themeData;
    notifyListeners();
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var isDarkTheme = prefs.getBool(SharedPreferencesKeys.isDarkTheme);
  ThemeData theme;
  if (isDarkTheme != null) {
    theme = isDarkTheme ? darkTheme : lightTheme;
  } else {
    theme = lightTheme;
  }
  runApp(
    ChangeNotifierProvider<ThemeNotifier>(
      create: (_) => ThemeNotifier(theme),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);

    return ChangeNotifierProvider(
      create: (_) => TasksProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Todo App',
        theme: themeNotifier.getTheme(),
        home: ToDoList(),
      ),
    );
  }
}
