import 'dart:io';

import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class TrainingDetailController extends GetxController {
  Future<bool> checkAndRequestStoragePermission() async {
    var status = await Permission.photos.status;
    if (!status.isGranted) {
      status = await Permission.photos.request();
    }

    return status.isGranted;
  }

  Future<void> saveFileLocally(String url) async {
    Directory? directory = await getApplicationDocumentsDirectory();
    String path = directory!.path;
    print(path);

  }
}
