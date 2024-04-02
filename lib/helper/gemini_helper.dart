import 'dart:convert';

import 'package:buddify/models/gemini_modal.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

class GeminiApiHelper {
  GeminiApiHelper._();

  static final GeminiApiHelper geminiApiHelper = GeminiApiHelper._();

  String apiUrl =
      'https://generativelanguage.googleapis.com/v1beta/models/gemini-pro:generateContent?key=AIzaSyC0yiuaSQ8yVT5uvKx51ZAt1Gvm3U_G_Ig';

  Future<List<GeminiModal>?> GeminiApi(
      {String prompt = 'who is primeminister of india'}) async {
    Map<String, dynamic> body = {
      "contents": [
        {
          "role": "user",
          "parts": [
            {"text": prompt}
          ]
        }
      ],
      "generationConfig": {
        "temperature": 0.9,
        "topK": 1,
        "topP": 1,
        "maxOutputTokens": 2048,
        "stopSequences": []
      },
      "safetySettings": [
        {
          "category": "HARM_CATEGORY_HARASSMENT",
          "threshold": "BLOCK_MEDIUM_AND_ABOVE"
        },
        {
          "category": "HARM_CATEGORY_HATE_SPEECH",
          "threshold": "BLOCK_MEDIUM_AND_ABOVE"
        },
        {
          "category": "HARM_CATEGORY_SEXUALLY_EXPLICIT",
          "threshold": "BLOCK_MEDIUM_AND_ABOVE"
        },
        {
          "category": "HARM_CATEGORY_DANGEROUS_CONTENT",
          "threshold": "BLOCK_MEDIUM_AND_ABOVE"
        }
      ]
    };

    String jsonBody = json.encode(body);
    try {
      final http.Response response = await http.post(
        Uri.parse(apiUrl),
        // Add your request body here if needed

        body: jsonBody,
      );

      final dynamic responseData = jsonDecode(response.body);

      if (response.statusCode == 200) {
        Logger().i(response.body);
        List data = responseData['candidates'][0]['content']['parts'];

        List<GeminiModal> content =
            data.map((e) => GeminiModal.fromMap(e)).toList();
        Logger().i(content);

        return content;
      } else {
        print('Failed to Gemini data: ${response.statusCode}');

        return null;
      }
    } catch (e) {
      print('Exception while Geminiing data: $e');
      return null;
    }
  }
}
