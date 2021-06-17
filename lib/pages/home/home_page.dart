import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:video_player/video_player.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late TargetPlatform
      _platform; ////The target platform, emmmm does not understand
  late VideoPlayerController
      _videoPlayerController1; //Wuhan live broadcast //Control instantiation is the same as below
  // late VideoPlayerController _videoPlayerController2; //CCTV13
  // late VideoPlayerController _videoPlayerController3; //CCTV1
  // late VideoPlayerController _videoPlayerController4; //CCTV6
  // late VideoPlayerController _videoPlayerController5; //CCTV5
  // late VideoPlayerController _videoPlayerController6; //Huya Movie
  late ChewieController _chewieController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _videoPlayerController1 =
        VideoPlayerController.network('http://tv.satiptvlinks.com/bd.m3u');

    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController1,
      aspectRatio: 3 / 2, //Aspect ratio
      autoPlay: false, //Auto play
      looping: true, //loop
      // // Try playing around with some of these other options:

      showControls: false, //Display control The following colors feel useless
      materialProgressColors: ChewieProgressColors(
        playedColor: Colors.red,
        handleColor: Colors.blue,
        backgroundColor: Colors.grey,
        bufferedColor: Colors.lightGreen,
      ),
      placeholder: Container(
        color: Colors.grey,
      ),
      autoInitialize: true, //Automatically initialize emmmmmmm
    );
  }

  @override //The following is the control of the playback function
  void dispose() {
    _videoPlayerController1.dispose();
    // _videoPlayerController2.dispose();
    // _videoPlayerController3.dispose();
    // _videoPlayerController4.dispose();
    // _videoPlayerController5.dispose();
    // _videoPlayerController6.dispose();
    _chewieController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.group_add), //This is an icon button
              onPressed: () {
                callQQ(); //Press event. Go to the plus group function at the end of this code
              }),
        ],
        title: Text("IPTV"),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
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
          Row(
            //Row flutter layout, corresponding to Column
            children: <Widget>[
              //children child silly, but there can be children in children
              Expanded(
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
                    child: Text("TV 1"),
                    padding: EdgeInsets.symmetric(vertical: 16.0),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

//This is the addition of QQ or QQ group?? ?: What can you do it yourself?
void callQQ({int number = 365700128, bool isGroup = true}) async {
  String url = isGroup
      ? 'mqqapi://card/show_pslcard?src_type=internal&version=1&uin=$number&card_type=group&source=qrcode'
      : 'mqqwpa://im/chat?chat_type=wpa&uin=$number&version=1&src_type=web&web_src=oicqzone.com';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    print('Inaccessible');
  }
}
