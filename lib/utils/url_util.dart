import 'package:dio/dio.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:ext_storage/ext_storage.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';

/// Url Utilities
class UrlUtil {
  /// Launch Url
  static void launchURL(String url) async {
    final Uri _url = Uri.parse(url);
    if (!await launchUrl(_url)) {
      throw 'Could not launch $_url';
    }
  }

  /// Download And Save file
  static downloadAndSaveFile({String url, String fileName}) async {
    //print("background permission");
    //await _handlePermission(Permission.storage);
    var status = await Permission.storage.status;
    if (!status.isGranted) {
      await Permission.storage.request();
    }

    Dio dio = Dio();

    try {
      var dir = await ExtStorage.getExternalStoragePublicDirectory(
          ExtStorage.DIRECTORY_DOWNLOADS);

      await dio.download(url, "$dir/$fileName",
          onReceiveProgress: (rec, total) {
        print("Rec: $rec , Total: $total");
      });

      return "$dir/$fileName";
    } catch (e) {
      print(e);
    }
  }

  //
  // ignore: unused_element
  static Future<void> _handlePermission(Permission permission) async {
    final status = await permission.request();
    print(status);
  }
}
