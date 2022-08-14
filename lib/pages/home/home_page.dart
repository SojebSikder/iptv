import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iptv/config/app_config.dart';
import 'package:iptv/provider/CategoryProvider.dart';
import 'package:iptv/widgets/ChannelList.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with WidgetsBindingObserver {
  late VideoPlayerController _videoPlayerController1;
  late ChewieController _chewieController;

  // BannerAd ad = new BannerAd(
  //   size: AdSize.banner,
  //   adUnitId: AdmobService.bannerAdUnit,
  //   // adUnitId: AdmobService.bannerAdTestUnit,
  //   listener: AdmobService.bannerAdlistener,
  //   request: AdRequest(),
  // );

  loadData() async {
    // Fetch Category
    await context.read<CategoryProvider>().fetchCategory();
    // Fetch Channels
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addObserver(this);
    // ad.load();
    loadData();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _videoPlayerController1.dispose();
      _chewieController.dispose();
    } else {
      _videoPlayerController1.dispose();
      _chewieController.dispose();
    }
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
          title: Text(AppConfig().appName()),
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            await loadData();
          },
          child: ListView(
            //shrinkWrap: true,
            //physics: NeverScrollableScrollPhysics(),
            children: [
              ChannelListWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
