import 'package:buddify/controller/KeyboardController.dart';
import 'package:buddify/views/screen/SpleshScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'controller/GeminiController.dart';
import 'controller/ImageController.dart';
import 'controller/ThemeController.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => GeminiController()),
    ChangeNotifierProvider(create: (_) => KeyboardController()),
    ChangeNotifierProvider(create: (_) => ImageController()),
    ChangeNotifierProvider(create: (_) => ThemeController()),
  ], child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    bool isDark = Provider.of<ThemeController>(context).isDark;
    return MaterialApp(
      title: 'Buddify',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Color(0xff577FDF)),
        useMaterial3: true,
        scaffoldBackgroundColor: isDark ? Color(0xffffffff) : Color(0xff1c1d2a),
        appBarTheme: AppBarTheme(
            backgroundColor: isDark ? Color(0xffffffff) : Color(0xff1c1d2a),
            foregroundColor: isDark ? Colors.black : Colors.white),
      ),
      home: SplashScreen(),
    );
  }
}
