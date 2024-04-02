import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:logger/logger.dart';

import '../helper/imagin_helper.dart';

class ImageController extends ChangeNotifier {
  List<Uint8List> images = [];

  Uint8List image = Uint8List(0);
  bool typing = false;

  void ImaginApi(String prompt) async {
    Logger().i(prompt);
    typing = true;
    notifyListeners();
    image =
        await await ImaginApiHelper.imaginApiHelper.imaginApi(prompt: prompt) ??
            [];

    if (image.isNotEmpty) {
      images.add(image);
    }

    typing = false;
    notifyListeners();
  }
}
