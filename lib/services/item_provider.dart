import 'package:flutter/material.dart';

class ItemProvider with ChangeNotifier {
  List<dynamic> _items = [];
  List<dynamic> get items => _items;

  final Map<int, bool> _favorites = {}; 
  bool isFavorite(int itemId) => _favorites[itemId] ?? false;

  //get all items function using provider
  void setItems(List<dynamic> newItems) {
    _items = newItems;
    notifyListeners();
  }

  //clickable favourite icon button function
  void toggleFavorite(int itemId) {
    if (_favorites.containsKey(itemId)) {
      _favorites[itemId] = !_favorites[itemId]!; 
    } else {
      _favorites[itemId] = true; 
    }
    notifyListeners(); 
  }
}