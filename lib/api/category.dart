import 'dart:convert';

import 'package:iptv/services/ApiService.dart';

class CategoryApi {
  fetchCategory() async {
    var result = await ApiService().getData(apiUrl: "/category", auth: false);
    var body = json.decode(result.body);
    return body;
  }
}
