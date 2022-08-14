import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iptv/pages/video_player/video_player.dart';
import 'package:iptv/provider/CategoryProvider.dart';
import 'package:iptv/widgets/CircleProgress.dart';
import 'package:provider/provider.dart';

class ChannelListWidget extends StatefulWidget {
  @override
  _ChannelListWidgetState createState() => _ChannelListWidgetState();
}

class _ChannelListWidgetState extends State<ChannelListWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle.dark.copyWith(
          statusBarColor: Colors.blue,
          statusBarIconBrightness: Brightness.dark),
    );

    return FutureBuilder(
      future: context.read<CategoryProvider>().fetchCategory(),
      builder: (context, snapshot) {
        //
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return Center(
              child: CircularProgressIndicator(),
            );
          default:
            if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else if (snapshot.hasData) {
              var category = snapshot.data['data'];

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
                      itemCount: category[index]['tvs'].length,
                      itemBuilder: (context, i) {
                        var channel = category[index]['tvs'];

                        return channel.isEmpty
                            ? Container()
                            : ListTile(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (builder) {
                                        return VideoPlayerPage(
                                          link: channel[i]['link'],
                                        );
                                      },
                                    ),
                                  );
                                },
                                title: Text("${channel[i]['title']}"),
                              );
                      },
                    ),
                  );
                },
              );
            } else {
              return CircleProgressWidget();
            }
        }
      },
    );
  }
}
