import 'package:flutter/material.dart';
import 'package:iptv/api/channel.dart';

class ChannelProvider extends ChangeNotifier {
  var _channels;
  var _channelByCategory;

  dynamic get channels => _channels == null ? "" : _channels;
  dynamic get channelByCategory =>
      _channelByCategory == null ? "" : _channelByCategory;

  Future<dynamic> fetchChannels() async {
    var data = await ChannelApi().fetchChannels();
    _channels = data;
    notifyListeners();
    return _channels;
  }

  Future<dynamic> fetchChannelByCategory({required String category}) async {
    var data = await ChannelApi().fetchChannelByCategory(category: category);
    _channelByCategory = data;
    notifyListeners();
    return _channelByCategory;
  }
}
