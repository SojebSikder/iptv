import 'package:flutter/material.dart';
import 'package:iptv/provider/ChannelProvider.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  loadData() async {
    await context.read<ChannelProvider>().fetchChannels();

    print(context.read<ChannelProvider>().channels['data']);
  }

  @override
  void initState() {
    super.initState();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("ChocoWatch"),
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            await loadData();
          },
          child: ListView(
            //shrinkWrap: true,
            children: [
              Text("Hello World"),
            ],
          ),
        ),
      ),
    );
  }
}
