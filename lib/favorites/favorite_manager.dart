import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FavoriteManager extends ChangeNotifier {
  final List<Map<String, String>> _favoriteMovies = [];
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  List<Map<String, String>> get favoriteMovies => List.unmodifiable(_favoriteMovies);

  FavoriteManager() {
    _auth.authStateChanges().listen((user) {
      if (user != null) {
        loadFavorites();
      }
    });
  }

  Future<void> loadFavorites() async {
    final user = _auth.currentUser;
    if (user == null) return;

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
          'title': data['title'] ?? '',
          'genre': data['genre'] ?? '',
          'duration': data['duration'] ?? '',
          'rating': data['rating'] ?? '',
          'description': data['description'] ?? '',
          'imageUrl': data['imageUrl'] ?? '',
          'videoUrl': data['videoUrl'] ?? '',
        });
      }
      notifyListeners();
    } catch (e) {
      debugPrint('Error loading favorites: $e');
    }
  }

  Future<void> toggleFavorite(Map<String, String> movie) async {
    final user = _auth.currentUser;
    if (user == null) return;

    final userFavoritesRef = _firestore
        .collection('users')
        .doc(user.uid)
        .collection('favorites');

    final docId = movie['title']!;
    final existingIndex = _favoriteMovies.indexWhere((item) => item['title'] == docId);

    try {
      if (existingIndex >= 0) {
        _favoriteMovies.removeAt(existingIndex);
        await userFavoritesRef.doc(docId).delete();
      } else {
        _favoriteMovies.add(movie);
        await userFavoritesRef.doc(docId).set(movie);
      }
      notifyListeners();
    } catch (e) {
      debugPrint('Error toggling favorite: $e');
    }
  }

  bool isFavorite(String title) {
    return _favoriteMovies.any((movie) => movie['title'] == title);
  }
}

final favoriteManager = FavoriteManager();
