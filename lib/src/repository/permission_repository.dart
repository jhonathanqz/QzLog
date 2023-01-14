import 'package:permission_handler/permission_handler.dart';

//Class responsible for managing the necessary permissions to control file storage
class PermissionRepository {
  //Check and if necessary obtain device storage permissions.
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

  //Check and if storage permissions are allowed
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
