import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iptv/api/category.dart';
import 'package:iptv/pages/video_player/video_player.dart';
import 'package:iptv/provider/CategoryProvider.dart';
import 'package:iptv/provider/ChannelProvider.dart';
import 'package:iptv/services/ApiService.dart';
import 'package:iptv/widgets/CircleProgress.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  loadData() async {
    // Fetch Category
    await context.read<CategoryProvider>().fetchCategory();
    // Fetch Channels
    // await context.read<ChannelProvider>().fetchChannels();

    //print(context.read<ChannelProvider>().channels['data']);
    //print(context.read<CategoryProvider>().category);
  }

  @override
  void initState() {
    super.initState();
    loadData();
  }

  loadCategoryForFuture() async {
    //var data = await CategoryApi().fetchCategory();

    var result = await ApiService().getData(apiUrl: "/category", auth: false);
    return result;
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle.dark.copyWith(
          statusBarColor: Colors.blue,
          statusBarIconBrightness: Brightness.dark),
    );
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
            //physics: NeverScrollableScrollPhysics(),
            children: [
              Consumer<CategoryProvider>(
                builder: (context, categoryData, child) {
                  //
                  var category = categoryData.category['data'];

                  // fetchChannel();
                  //
                  return FutureBuilder(
                    future: loadCategoryForFuture(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        // Category List
                        return ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: category.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              title: Text("${category[index]['title']}"),
                              // Channel List
                              subtitle: ListView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: category.length,
                                itemBuilder: (context, index) {
                                  var channel = category[index]['tvs'];

                                  //print(channel[index]['title']);
                                  return channel.isEmpty
                                      ? Container()
                                      : Text("${channel[index]['title']}");
                                },
                              ),
                            );
                          },
                        );
                      } else {
                        return CircleProgressWidget();
                      }
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
