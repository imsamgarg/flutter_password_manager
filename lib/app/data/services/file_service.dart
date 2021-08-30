import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

class FileService extends GetxService {
  Future<void> shareFile(String path) async {
    await Share.shareFiles([path]);
  }

  Future<PlatformFile?> pickFile() async {
    final pickedFile = await FilePicker.platform.pickFiles(
      allowedExtensions: ["json"],
    );
    if (pickedFile != null) {
      return pickedFile.files.first;
    } else {
      return null;
    }
  }

  Future<File> createTextFile(String text, String path) async {
    final dir = await getExternalStorageDirectory();
    final fullPath = join(dir!.path, path);
    return await File(fullPath).writeAsString(text);
  }

  Future<String> readTextFile(String path) async {
    return await File(path).readAsString();
  }

  Future decodeJsonFile(String path) async {
    final file = await this.readTextFile(path);
    return JsonDecoder().convert(file);
  }

  Future<bool> isFileExists(String path) async {
    final dir = await getExternalStorageDirectory();
    final fullPath = join(dir!.path, path);
    return await File(fullPath).exists();
  }
}
