import 'package:flutter/material.dart';
import 'package:notes_app/src/res/strings.dart';
import 'package:notes_app/src/views/home.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppStrings.appName,
      theme: ThemeData.dark(
        useMaterial3: true,
      ),
      home: const HomeView(),
    );
  }
}
