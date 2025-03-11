import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FavoriteManager extends ChangeNotifier {
  final List<Map<String, String>> _favoriteMovies = [];
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  List<Map<String, String>> get favoriteMovies => _favoriteMovies;

  FavoriteManager() {
    // Load the current user’s favorites from Firestore when the manager is created
    loadFavorites();
  }

  /// Loads the favorite movies from Firestore for the current user.
  Future<void> loadFavorites() async {
    final user = _auth.currentUser;
    if (user == null) return; // If not logged in, exit early.

    try {
      final snapshot = await _firestore
          .collection('users')
          .doc(user.uid)
          .collection('favorites')
          .get();

      _favoriteMovies.clear();
      for (var doc in snapshot.docs) {
        final data = doc.data();
        _favoriteMovies.add({
          'title': data['title'] as String,
          'genre': data['genre'] as String,
          'duration': data['duration'] as String,
          'rating': data['rating'] as String,
          'description': data['description'] as String,
          'imageUrl': data['imageUrl'] as String,
          'videoUrl': data['videoUrl'] as String,
        });
      }
      notifyListeners();
    } catch (e) {
      debugPrint('Error loading favorites: $e');
    }
  }

  /// Toggles a movie as favorite or not.
  Future<void> toggleFavorite(Map<String, String> movie) async {
    final user = _auth.currentUser;
    if (user == null) return; // Ensure the user is logged in

    final existingIndex =
        _favoriteMovies.indexWhere((item) => item['title'] == movie['title']);
    final userFavoritesRef = _firestore
        .collection('users')
        .doc(user.uid)
        .collection('favorites');

    try {
      if (existingIndex >= 0) {
        // Movie already a favorite; remove it both locally and in Firestore.
        _favoriteMovies.removeAt(existingIndex);
        await userFavoritesRef.doc(movie['title']).delete();
      } else {
        // Movie is not a favorite; add it locally and in Firestore.
        _favoriteMovies.add(movie);
        await userFavoritesRef.doc(movie['title']).set(movie);
      }
      notifyListeners();
    } catch (e) {
      debugPrint('Error toggling favorite: $e');
    }
  }

  /// Checks whether a movie (by title) is a favorite.
  bool isFavorite(String title) {
    return _favoriteMovies.any((movie) => movie['title'] == title);
  }
}

final favoriteManager = FavoriteManager();
