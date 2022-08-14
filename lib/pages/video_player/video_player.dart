import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:iptv/config/app_config.dart';
import 'package:iptv/provider/CategoryProvider.dart';
import 'package:iptv/services/ApiService.dart';
import 'package:iptv/widgets/CircleProgress.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';
import 'package:wakelock/wakelock.dart';

class VideoPlayerPage extends StatefulWidget {
  final link;

  const VideoPlayerPage({this.link});
  @override
  _VideoPlayerPageState createState() => _VideoPlayerPageState();
}

class _VideoPlayerPageState extends State<VideoPlayerPage> {
  // late TargetPlatform
  //     _platform;
  VideoPlayerController _videoPlayerController1;
  ChewieController _chewieController;

  @override
  void initState() {
    super.initState();

    // ad.load();

    // Initial Channel link
    _videoPlayerController1 = VideoPlayerController.network('${widget.link}');

    _chewieController = ChewieController(
      videoPlayerController:
          _videoPlayerController1, //Control the first playback control
      aspectRatio: 3 / 2,
      autoPlay: true,
      looping: true,
    );

    Wakelock.enable();
  }

  @override //The following is the control of the playback function
  void dispose() {
    super.dispose();
    _videoPlayerController1.dispose();
    _chewieController.dispose();
    Wakelock.disable();
  }

  @override
  Widget build(BuildContext context) {
    // final _screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(AppConfig().appName()),
      ),
      body: Column(
        // physics: NeverScrollableScrollPhysics(),
        //shrinkWrap: true,
        children: [
          Container(
            height: 200.0,
            child: Center(
              child: Chewie(
                controller: _chewieController,
              ),
            ),
          ),
          // Channel List

          // fetchChannel();
          //
          Expanded(
            child: FutureBuilder(
                future: context.read<CategoryProvider>().fetchCategory(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    var category = snapshot.data['data'];
                    // Category List
                    return ListView.builder(
                      shrinkWrap: true,
                      // physics: NeverScrollableScrollPhysics(),
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

                              //print(channel);
                              return channel.isEmpty
                                  ? Container()
                                  : ListTile(
                                      onTap: () {
                                        setState(
                                          () {
                                            //State
                                            _chewieController.dispose();

                                            setState(() {
                                              _videoPlayerController1 =
                                                  VideoPlayerController.network(
                                                      "${channel[i]['link']}");
                                            });
                                            _chewieController =
                                                ChewieController(
                                              videoPlayerController:
                                                  _videoPlayerController1, //Control the first playback control
                                              aspectRatio: 3 / 2,
                                              autoPlay: true,
                                              looping: true,
                                            );
                                          },
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
                }),
          )

          // End Channel List
        ],
      ),
    );
  }
}
