import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lab1_flutter_dart_basics/db/getTwits.dart';


class Twits extends ChangeNotifier {
  late List<Map<String, dynamic>> _twitters = [];

  void update() {
    _twitters.clear();
    getTwits().then((twits) {
      _twitters = twits.map((element) {
        element['isLiked'] = 'null';
        return element;
      }).toList();
      notifyListeners();
    });

  }

  List getAll() {
    return _twitters;
  }

  Map getTwitById(dynamic id) {
    return _twitters.firstWhere((element) => element['id'] == id);
  }

  void like(dynamic id) {
    final twit = getTwitById(id);
    twit['likes']++;

    notifyListeners();
  }

}
