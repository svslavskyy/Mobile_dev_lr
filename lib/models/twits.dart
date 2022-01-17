import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../twitters.dart';

class Twits extends ChangeNotifier {
  late List<Map<String, dynamic>> _twitters = [];

  void update() {
    _twitters.clear();
    getTwits().forEach((element) {
      _twitters.add(element);
    });
    notifyListeners();
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
