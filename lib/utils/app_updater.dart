// import 'package:flutter/material.dart';
// import 'package:package_info/package_info.dart';
// import 'package:pharmacy_app/api/web.dart';
// import 'package:pharmacy_app/pages/app_update_page.dart';
// import 'package:version/version.dart';

// class AppUpdater {
//   static checkUpdate(context) async {
//     //
//     PackageInfo packageInfo = await PackageInfo.fromPlatform();
//     String version = packageInfo.version;
//     //
//     var result = await WebApi().fetchWeb();
//     var data = result;
//     var appVersion = data['data']['app_version'];
//     //

//     // Get from device
//     Version oldVersion = Version.parse(version);
//     // Get from server
//     Version latestVersion = Version.parse(appVersion);
//     //
//     if (latestVersion > oldVersion) {
//       print("Update is available");
//       Navigator.pushReplacement(
//           context, MaterialPageRoute(builder: (builder) => AppUpdatePage()));

//       return true;
//     } else {
//       return false;
//     }
//   }
// }
