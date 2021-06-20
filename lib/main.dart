import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:iptv/config/app_config.dart';
// Pages
import 'package:iptv/pages/home/home_page.dart';
import 'package:iptv/pages/splash/splash_page.dart';
// Widgets
// Provider
import 'provider/ChannelProvider.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => ChannelProvider()),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: AppConfig().appName(),
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SplashPage(),
      routes: {
        'home': (context) => HomePage(),
      },
    );
  }
}
