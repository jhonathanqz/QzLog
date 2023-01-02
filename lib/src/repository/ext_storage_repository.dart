import 'dart:io';

import 'package:path/path.dart' as Path;
import 'package:path_provider/path_provider.dart';

enum extPublicDir {
  Music,
  PodCasts,
  Ringtones,
  Alarms,
  Notifications,
  Pictures,
  Movies,
  Download,
  DCIM,
  Documents,
  Screenshots,
  Audiobooks,
}

class ExtStorageRepository {
  static Future<String> get _getExtStoragePath async {
    var directory = await getExternalStorageDirectory();
    if (directory != null) {
      return directory.path;
    }

    return '';
  }

  /* Create or not a folder within the public directory, and return its full path */

  static Future<String> createFolderInPublicDirectory({
    required extPublicDir type,
    required String folderName,
  }) async {
    var _appDocDir = await _getExtStoragePath;

    _appDocDir = await getPathFolderApp(type: type, folderName: folderName);

    if (await Directory(_appDocDir).exists()) {
      return _appDocDir;
    } else {
      //if folder not exists create folder and then return its path
      final _appDocDirNewFolder =
          await Directory(_appDocDir).create(recursive: true);
      final pathNorma = Path.normalize(_appDocDirNewFolder.path);

      return pathNorma;
    }
  }

  static Future<String> getPathFolderApp({
    required extPublicDir type,
    required String folderName,
  }) async {
    var _appDocDir = await _getExtStoragePath;

    var values = _appDocDir.split(Platform.pathSeparator);
    // ignore: avoid_print
    values.forEach(print);

    var dim = values.length - 4; // Android/Data/package.name/files
    _appDocDir = "";

    for (var i = 0; i < dim; i++) {
      _appDocDir += values[i];
      _appDocDir += Platform.pathSeparator;
    }
    _appDocDir += "${type.toString().split('.').last}${Platform.pathSeparator}";
    _appDocDir += folderName;
    return _appDocDir;
  }
}
