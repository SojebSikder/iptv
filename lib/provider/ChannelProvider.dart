import 'package:flutter/material.dart';
import 'package:iptv/api/channel.dart';

class ChannelProvider extends ChangeNotifier {
  var _channels;

  dynamic get channels => _channels == null ? "" : _channels;
  fetchChannels() async {
    var data = await ChannelApi().fetchChannels();
    _channels = data;
    notifyListeners();
  }
}
