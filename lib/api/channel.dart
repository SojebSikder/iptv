import 'dart:convert';

import 'package:iptv/services/ApiService.dart';

class ChannelApi {
  fetchChannels() async {
    var result = await ApiService().getData(apiUrl: "/tv", auth: false);
    var body = json.decode(result.body);
    return body;
  }

  fetchChannelByCategory({required String category}) async {
    var result = await ApiService()
        .getData(apiUrl: "/tv?category=" + category, auth: false);
    var body = json.decode(result.body);
    return body;
  }
}
