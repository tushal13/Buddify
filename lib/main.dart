import 'package:buddify/controller/keyboardcontroller.dart';
import 'package:buddify/views/screen/splesh_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'controller/geminicontroller.dart';
import 'controller/imagecontroller.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => GeminiController()),
    ChangeNotifierProvider(create: (_) => KeyboardController()),
    ChangeNotifierProvider(create: (_) => ImageController()),
  ], child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Color(0xff577FDF)),
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xff1c1d2a),
        appBarTheme: const AppBarTheme(
            backgroundColor: Color(0xff1c1d2a), foregroundColor: Colors.white),
      ),
      home: SplashScreen(),
    );
  }
}
