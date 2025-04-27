// import 'dart:io';

// import 'package:path_provider/path_provider.dart';
// import 'package:team_up/core/service/permission_service.dart';

// class StorageService {
//   static Future<String?> getExternalDocumentPath() async {
// final hasPermission = await PermissionService().storage();
//     Directory directory;
//     directory = await getApplicationDocumentsDirectory();
//     final exPath = directory.path;
//     await Directory(exPath).create(recursive: true);
//     return exPath;
//   }

//   static Future<String> get _localPath async {
//     // final directory = await getApplicationDocumentsDirectory();
//     // return directory.path;
//     // To get the external path from device of download folder
//     final String directory = await getExternalDocumentPath();
//     return directory;
//   }

//   static Future<File> writeCounter(String bytes, String name) async {
//     final path = await _localPath;
//     // Create a file for the path of
//     // device and file name with extension
//     File file = File('$path/$name');
//     ;
//     print("Save file");

//     // Write the data in the file you have created
//     return file.writeAsString(bytes);
//   }
// }
