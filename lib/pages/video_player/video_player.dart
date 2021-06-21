import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:iptv/config/app_config.dart';
import 'package:iptv/provider/CategoryProvider.dart';
import 'package:iptv/services/ApiService.dart';
import 'package:iptv/widgets/ChannelList.dart';
import 'package:iptv/widgets/CircleProgress.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerPage extends StatefulWidget {
  final link;

  const VideoPlayerPage({this.link});
  @override
  _VideoPlayerPageState createState() => _VideoPlayerPageState();
}

class _VideoPlayerPageState extends State<VideoPlayerPage> {
  // late TargetPlatform
  //     _platform;
  late VideoPlayerController _videoPlayerController1;
  late ChewieController _chewieController;

  // var channels = [
  //   {
  //     "title": "Asian TV",
  //     "link": "http://10.16.100.203:8082/bangla/tv_asian.m3u8",
  //   },
  //   {
  //     "title": "Forign Channel",
  //     "link": "https://tv-trthaber.live.trt.com.tr/master.m3u8",
  //   }
  // ];

  @override
  void initState() {
    super.initState();

    // Initial Channel link
    _videoPlayerController1 = VideoPlayerController.network('${widget.link}');

    _chewieController = ChewieController(
      videoPlayerController:
          _videoPlayerController1, //Control the first playback control
      aspectRatio: 3 / 2,
      autoPlay: true,
      looping: true,
    );
    // _chewieController = ChewieController(
    //   videoPlayerController: _videoPlayerController1,
    //   aspectRatio: 3 / 2, //Aspect ratio
    //   autoPlay: true, //Auto play
    //   looping: true, //loop
    //   // // Try playing around with some of these other options:

    //   showControls: false, //Display control The following colors feel useless
    //   materialProgressColors: ChewieProgressColors(
    //     playedColor: Colors.red,
    //     handleColor: Colors.blue,
    //     backgroundColor: Colors.grey,
    //     bufferedColor: Colors.lightGreen,
    //   ),
    //   placeholder: Container(
    //     color: Colors.grey,
    //   ),
    //   autoInitialize: true, //Automatically initialize emmmmmmm
    // );
  }

  @override //The following is the control of the playback function
  void dispose() {
    super.dispose();
    _videoPlayerController1.dispose();
    _chewieController.dispose();
  }

  // This is for futureBuilder
  loadCategoryForFuture() async {
    var result = await ApiService().getData(apiUrl: "/category", auth: false);
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppConfig().appName()),
      ),
      body: ListView(
        shrinkWrap: true,
        children: [
          Container(
            height: 200.0,
            child: Center(
              child: Chewie(
                controller: _chewieController,
              ),
            ),
          ),
          // ElevatedButton(
          //   //This is a flat button
          //   onPressed: () {
          //     _chewieController.enterFullScreen();
          //   },
          //   child: Text('Fullscreen'),
          // ),
          // Channel List
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
                            // gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            //   childAspectRatio: 0.9, //cardWidth / cardHeight,
                            //   crossAxisCount: 2,
                            // ),
                            itemCount: category[index]['tvs'].length,
                            itemBuilder: (context, i) {
                              var channel = category[index]['tvs'];

                              //print(channel);
                              return channel.isEmpty
                                  ? Container()
                                  : ListTile(
                                      onTap: () {
                                        setState(() {
                                          //State
                                          _chewieController.dispose();

                                          // _videoPlayerController2
                                          //     .pause(); //The second playback function is paused
                                          // _videoPlayerController2.seekTo(
                                          //     Duration(seconds: 0)); //Set the progress bar to 0

                                          setState(() {
                                            _videoPlayerController1 =
                                                VideoPlayerController.network(
                                                    "${channel[i]['link']}");
                                          });
                                          _chewieController = ChewieController(
                                            videoPlayerController:
                                                _videoPlayerController1, //Control the first playback control
                                            aspectRatio: 3 / 2,
                                            autoPlay: true,
                                            looping: true,
                                          );
                                        });
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
                },
              );
            },
          ),
          // End Channel List
        ],
      ),
    );
  }
}
