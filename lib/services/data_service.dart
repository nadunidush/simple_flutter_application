import 'dart:convert';
import 'package:flutter/services.dart';

Future<List<dynamic>> loadItems() async {
  String jsonString = await rootBundle.loadString('assets/items.json');
  return jsonDecode(jsonString);
}
