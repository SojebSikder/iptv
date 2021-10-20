import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:iptv/config/app_config.dart';
import 'package:iptv/provider/CategoryProvider.dart';
import 'package:iptv/services/AdmobService.dart';
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
  late VideoPlayerController _videoPlayerController1;
  late ChewieController _chewieController;

  BannerAd ad = new BannerAd(
    size: AdSize.banner,
    adUnitId: AdmobService.bannerAdUnit,
    // adUnitId: AdmobService.bannerAdTestUnit,
    listener: AdmobService.bannerAdlistener,
    request: AdRequest(),
  );

  @override
  void initState() {
    super.initState();

    ad.load();

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

  // This is for futureBuilder
  loadCategoryForFuture() async {
    var result = await ApiService().getData(apiUrl: "/category", auth: false);
    return result;
  }

  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;
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
          Expanded(
            child: Consumer<CategoryProvider>(
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
                        // physics: NeverScrollableScrollPhysics(),
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
          ),

          // End Channel List
        ],
      ),
      bottomNavigationBar: Container(
        alignment: Alignment.center,
        width: AdmobService.createBannerAd().size.width.toDouble(),
        height: AdmobService.createBannerAd().size.height.toDouble(),
        child: AdWidget(
          // key: UniqueKey(),
          ad: ad,
        ),
      ),
    );
  }
}
