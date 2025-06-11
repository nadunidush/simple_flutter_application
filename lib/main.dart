import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:simple_flutter_application/pages/item_list_screen.dart';
import 'package:simple_flutter_application/services/item_provider.dart';



void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => ItemProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Item List',
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.teal,
        textTheme: const TextTheme(
          bodyMedium: TextStyle(fontSize: 18, color: Colors.white),
        ),
      ),
      home: const ItemListScreen(),
    );
  }
}

 
