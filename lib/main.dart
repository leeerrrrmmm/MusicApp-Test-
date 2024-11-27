import 'package:flutter/material.dart';
import 'package:lermmusic/models/play_list_provider.dart';

import 'package:lermmusic/pages/homePage.dart';
import 'package:lermmusic/themes/themes_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
        ChangeNotifierProvider(create: (context) => PlayListProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      home: const Homepage(),
      theme: Provider.of<ThemeProvider>(context).themeData,
    );
  }
}
