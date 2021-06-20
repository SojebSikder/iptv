import 'package:flutter/material.dart';
import 'package:iptv/api/category.dart';

class CategoryProvider extends ChangeNotifier {
  var _category;

  dynamic get category => _category == null ? "" : _category;

  fetchCategory() async {
    var data = await CategoryApi().fetchCategory();
    _category = data;
    notifyListeners();
  }
}
