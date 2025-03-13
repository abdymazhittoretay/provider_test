import 'package:flutter/material.dart';
import 'package:provider_test/models/comment.dart';

class FavoriteModel extends ChangeNotifier {
  final List<Comment> _favorites = [];

  List<Comment> get favorites => _favorites;

  void add(Comment comment){
    _favorites.add(comment);
    notifyListeners();
  }

  void remove(int index){
    _favorites.removeAt(index);
    notifyListeners();
  }
}
