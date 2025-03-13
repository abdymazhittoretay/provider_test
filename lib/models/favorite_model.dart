import 'package:flutter/material.dart';
import 'package:provider_test/models/comment.dart';

class FavoriteModel extends ChangeNotifier {
  final List<Comment> _favorites = [];

  List<Comment> get favorites => _favorites;

  void addRemove(Comment comment) {
    if (_favorites.contains(comment)) {
      _favorites.remove(comment);
      notifyListeners();
    } else {
      _favorites.add(comment);
      notifyListeners();
    }
  }
}
