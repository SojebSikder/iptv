import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:iptv/config/app_config.dart';
// Pages
import 'pages/home/home_page.dart';
import 'pages/splash/splash_page.dart';
// Widgets
// Provider
import 'provider/CategoryProvider.dart';
import 'provider/ChannelProvider.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => CategoryProvider()),
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
