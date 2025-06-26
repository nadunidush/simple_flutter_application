import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_flutter_application/pages/cart_screen.dart';
import 'package:simple_flutter_application/pages/checkout_screen.dart';

import 'package:simple_flutter_application/pages/login_scree.dart';
import 'package:simple_flutter_application/pages/registation_screen.dart';
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
      initialRoute: '/login',
      routes: {
        '/login': (context) => const LoginScreen(),
        '/register': (context) => const RegisterScreen(),
        '/cart': (context) => const CartScreen(),
        '/checkout': (context) => const CheckoutScreen(),
      },
      //home: ItemListScreen(),
    );
  }
}

 
