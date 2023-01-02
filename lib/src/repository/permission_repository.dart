import 'package:permission_handler/permission_handler.dart';

class PermissionRepository {
  static Future<void> checkAndRequestPermission() async {
    try {
      final _statusStorage = await Permission.storage.status; //isDenied
      if (!_statusStorage.isGranted) {
        await Permission.storage.request();
      }
      final _statusManageStorage =
          await Permission.manageExternalStorage.status;
      if (!_statusManageStorage.isGranted) {
        await Permission.manageExternalStorage.request();
      }
    } catch (e) {
      rethrow;
    }
  }

  static Future<bool> isPermissonsGranted() async {
    bool aux = true;
    try {
      final _statusStorage = await Permission.storage.status; //isDenied
      if (!_statusStorage.isGranted) {
        aux = false;
      }
      final _statusManageStorage =
          await Permission.manageExternalStorage.status;
      if (!_statusManageStorage.isGranted) {
        aux = false;
      }
    } catch (e) {
      rethrow;
    }
    return aux;
  }
}
