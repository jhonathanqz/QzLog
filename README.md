<div align="center" id="top"> 
  <img src="./.github/app.gif" alt="Qz_log" />

&#xa0;

</div>

<h1 align="center">QzLog</h1>

<br>

<a href="https://buymeacoffee.com/jhonathanqr" target="_blank">
  <img src="https://www.buymeacoffee.com/assets/img/custom_images/orange_img.png" alt="Buy Me A Book" style="height: 41px !important;width: 174px !important;box-shadow: 0px 3px 2px 0px rgba(190, 190, 190, 0.5) !important;-webkit-box-shadow: 0px 3px 2px 0px rgba(190, 190, 190, 0.5) !important;">
</a>

[![Github Badge](https://img.shields.io/badge/GitHub-100000?style=for-the-badge&logo=github&logoColor=white&link=https://github.com/jhonathanqz)](https://github.com/jhonathanqz)

Before using the QzLog package, it is necessary to configure the following permissions in androidManifest.xml:

```
<uses-permission android:name="android.permission.READ_EXTERNAL_STORAGE" />
<uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE" />
<uses-permission android:name="android.permission.MANAGE_EXTERNAL_STORAGE" />
<uses-permission android:name="android.permission.ACCESS_MEDIA_LOCATION"/>
```

Permissions are required to access and manipulate the generated files.

And still in androidManifest, inside the application tag, include the following key:

```
<application
        ...
        android:requestLegacyExternalStorage="true"
```

## :dart: How to use it?

- Firstly, add QzLog as a dependency in your pubspec.yaml file.
- And import this as in your dart file:

```
import 'package:qz_log/qz_log.dart';
```

- To insert or record a Log record, use the insertLog function;

```
await QzLog.insertLog(log: 'Test Log', exception: 'Function insert');
```

- To check if there are Logs recorded in the database, just use the logExists function.

```
await QzLog.logExists();
```

- To export the Log file, just use the exportLogs function. The file will be saved inside the Downloads/QzLog folder.

```
await QzLog.exportLogs();
```

- To delete all Log records in the database and also the generated files, just use the deleteAll function.

```
await QzLog.deleteAll();
```

- To delete only the exported files in the device's storage, just use the deleteAllFiles function.

```
await QzLog.deleteAllFiles();
```

- To delete only the log records stored in the database and keep the exported files, just use the deleteLogFromDatabase function.

```
await QzLog.deleteLogFromDatabase();
```

- To check and request storage permissions, just use the checkAndRequestPermission function..

```
await QzLog.checkAndRequestPermission();
```

## :sparkles: Documentation

<a href="https://github.com/jhonathanqz" target="_blank">
Access documentation</a>
<br>
<br>
Made by: Jhonathan Queiroz
