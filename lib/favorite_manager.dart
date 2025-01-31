import 'package:flutter/material.dart';

class FavoriteManager extends ChangeNotifier {
  final List<Map<String, String>> _favoriteMovies = [];

  List<Map<String, String>> get favoriteMovies => _favoriteMovies;

  void toggleFavorite(Map<String, String> movie) {
    final existingIndex = _favoriteMovies.indexWhere(
      (item) => item['title'] == movie['title'],
    );

    if (existingIndex >= 0) {
      _favoriteMovies.removeAt(existingIndex);
    } else {
      _favoriteMovies.add(movie);
    }

    notifyListeners();
  }

  bool isFavorite(String title) {
    return _favoriteMovies.any((movie) => movie['title'] == title);
  }
}

final favoriteManager = FavoriteManager();
