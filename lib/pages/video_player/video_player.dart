import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:iptv/config/app_config.dart';
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
  late VideoPlayerController
      _videoPlayerController1; //Wuhan live broadcast //Control instantiation is the same as below
  // late VideoPlayerController _videoPlayerController2; //CCTV13
  // late VideoPlayerController _videoPlayerController3; //CCTV1
  // late VideoPlayerController _videoPlayerController4; //CCTV6
  // late VideoPlayerController _videoPlayerController5; //CCTV5
  // late VideoPlayerController _videoPlayerController6; //Huya Movie
  late ChewieController _chewieController;

  var channels = [
    {
      "title": "Asian TV",
      "link": "http://10.16.100.203:8082/bangla/tv_asian.m3u8",
    },
    {
      "title": "Forign Channel",
      "link": "https://tv-trthaber.live.trt.com.tr/master.m3u8",
    }
  ];

  @override
  void initState() {
    super.initState();
    // _videoPlayerController1 = VideoPlayerController.network(
    //     'https://tv-trthaber.live.trt.com.tr/master.m3u8');

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
    _videoPlayerController1.dispose();
    _chewieController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppConfig().appName()),
      ),
      body: ListView(
        shrinkWrap: true,
        children: <Widget>[
          Container(
            height: 200.0,
            child: Center(
              child: Chewie(
                controller: _chewieController,
              ),
            ),
          ),
          ElevatedButton(
            //This is a flat button
            onPressed: () {
              _chewieController.enterFullScreen();
            },
            child: Text('Fullscreen'),
          ),
          ListView.builder(
              shrinkWrap: true,
              itemCount: channels.length,
              itemBuilder: (context, index) {
                return Container(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          //State
                          _chewieController.dispose();

                          // _videoPlayerController2
                          //     .pause(); //The second playback function is paused
                          // _videoPlayerController2.seekTo(
                          //     Duration(seconds: 0)); //Set the progress bar to 0
                          // _videoPlayerController3.pause();
                          // _videoPlayerController3.seekTo(Duration(seconds: 0));
                          // _videoPlayerController4.pause();
                          // _videoPlayerController4.seekTo(Duration(seconds: 0));
                          // _videoPlayerController5.pause();
                          // _videoPlayerController5.seekTo(Duration(seconds: 0));
                          // _videoPlayerController6.pause();
                          // _videoPlayerController6.seekTo(Duration(seconds: 0));

                          setState(() {
                            _videoPlayerController1 =
                                VideoPlayerController.network(
                                    "${channels[index]['link']}");
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
                      child: Padding(
                        child: Text("${channels[index]['title']}"),
                        padding: EdgeInsets.symmetric(vertical: 16.0),
                      ),
                    ),
                  ),
                );
              }),
        ],
      ),
    );
  }
}
