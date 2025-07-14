import 'package:flutter/material.dart';
import 'package:mini_tourist/view/main_page.dart';
import 'package:mini_tourist/view_model/card_view_model.dart';
import 'package:mini_tourist/view_model/client_view_model.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ClientViewModel()),
        ChangeNotifierProvider(create: (context) => CardViewModel()),
      ],
      child: const MainApp(),
    ),
  );
}
class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MiniTourist',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.red,
        scaffoldBackgroundColor: const Color(0xFFDBDBDB)
      ),
      home: const MainPage(),
    );
  }
}
