import 'package:permission_handler/permission_handler.dart';

///  Permission
class PermissionUtil {
  /// Storage Permission
  static storagePermission() async {
    var status = await Permission.storage.status;
    if (!status.isGranted) {
      await Permission.storage.request();
    }
  }
}
