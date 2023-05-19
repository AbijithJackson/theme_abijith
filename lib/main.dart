import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sqflite_internship/new/model_theme.dart';
import 'package:sqflite_internship/screens/splash.dart';
import 'package:sqflite_internship/screens/todo_product.dart';

import 'new/homepage.dart';

import 'screens/todo_product.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ModelTheme(),
      child: Consumer(builder: (context,ModelTheme themeNotifier, child) {
        return MaterialApp(
          theme: themeNotifier.isDark
              ? ThemeData(
                  brightness: Brightness.dark,
                )
              : ThemeData(
                  brightness: Brightness.light,
                  primaryColor: Colors.green,
                  primarySwatch: Colors.green),
          debugShowCheckedModeBanner: false,
          home: SplashScreen(),
        );
      }),
    );
  }
}
