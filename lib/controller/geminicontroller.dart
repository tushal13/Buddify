import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

import '../helper/gemini_helper.dart';
import '../models/gemini_chat_modal.dart';
import '../models/gemini_modal.dart';

class GeminiController extends ChangeNotifier {
  List<GeminiModal> geminires = [];

  List<GChatModal> gchats = [];
  bool typing = false;

  void GeminiApi(String prompt) async {
    Logger().i(prompt);

    gchats.insert(0, GChatModal(sent: prompt, recieved: ''));
    Logger().i('${gchats[0].sent} , ${gchats[0].recieved}');
    typing = gchats[0].recieved == '' ? true : false;
    notifyListeners();
    geminires =
        await GeminiApiHelper.geminiApiHelper.GeminiApi(prompt: prompt) ?? [];

    for (int i = 0; i < geminires.length; i++) {
      if (geminires.isNotEmpty) {
        gchats[0].recieved = geminires[0].content;
      }
    }
    Logger().t('${gchats[0].sent} , ${gchats[0].recieved}');
    typing = false;
    notifyListeners();
  }
}
