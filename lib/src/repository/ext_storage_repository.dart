// ignore_for_file: constant_identifier_names, library_prefixes

import 'dart:io';

import 'package:path/path.dart' as Path;
import 'package:path_provider/path_provider.dart';

//Enum to map device public directories.
enum ExtPublicDir {
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

//Class responsible for controlling the logic and construction of the fields,
//and finally calling the communication with the database,
//passing the processed data as a parameter.
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
    required ExtPublicDir type,
    required String folderName,
  }) async {
    var _appDocDir = await _getExtStoragePath;
    //Get Application Directory
    _appDocDir = await getPathFolderApp(type: type, folderName: folderName);

    if (await Directory(_appDocDir).exists()) {
      return _appDocDir;
    } else {
      //if folder not exists create folder and then return its path
      final _appDocDirNewFolder =
          await Directory(_appDocDir).create(recursive: true);
      final pathNorma = Path.normalize(_appDocDirNewFolder.path);
      //Returns full directory of created folder
      return pathNorma;
    }
  }

  //Function responsible for getting the application directory
  static Future<String> getPathFolderApp({
    required ExtPublicDir type,
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
