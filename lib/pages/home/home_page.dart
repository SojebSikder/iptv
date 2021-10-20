import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:iptv/config/app_config.dart';
import 'package:iptv/pages/video_player/video_player.dart';
import 'package:iptv/provider/CategoryProvider.dart';
import 'package:iptv/services/AdmobService.dart';
import 'package:iptv/services/ApiService.dart';
import 'package:iptv/widgets/ChannelList.dart';
import 'package:iptv/widgets/CircleProgress.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with WidgetsBindingObserver {
  late VideoPlayerController _videoPlayerController1;
  late ChewieController _chewieController;

  BannerAd ad = new BannerAd(
    size: AdSize.banner,
    adUnitId: AdmobService.bannerAdUnit,
    listener: AdmobService.bannerAdlistener,
    request: AdRequest(),
  );

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
    WidgetsBinding.instance!.addObserver(this);
    ad.load();
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
        bottomNavigationBar: Container(
          alignment: Alignment.center,
          width: AdmobService.createBannerAd().size.width.toDouble(),
          height: AdmobService.createBannerAd().size.height.toDouble(),
          child: AdWidget(
            // key: UniqueKey(),
            ad: ad,
          ),
        ),
      ),
    );
  }
}
