import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter/services.dart';

class ImaginApiHelper {
  ImaginApiHelper._();

  static final ImaginApiHelper imaginApiHelper = ImaginApiHelper._();

  String apiUrl = 'https://api.vyro.ai/v1/imagine/api/generations';

  Future<dynamic> imaginApi({String prompt = ''}) async {
    try {
      Map<String, dynamic> headers = {
        'Authorization':
            'Bearer 	vk-2qZB8emkoshOF0o77C35u54ZUqVvwKSh1VyvC2gDvBkLmSZ'
      };

      Map<String, dynamic> payload = {
        'prompt': prompt,
        'style_id': '31',
      };

      FormData formData = FormData.fromMap(payload);

      Dio dio = Dio();
      dio.options =
          BaseOptions(headers: headers, responseType: ResponseType.bytes);

      final response = await dio.post(apiUrl, data: formData);
      if (response.statusCode == 200) {
        Uint8List uint8List = Uint8List.fromList(response.data);
        return uint8List;
      } else {
        print('Failed to imagin data: ${response.statusCode}');

        return null;
      }
    } catch (e) {
      print('Exception while imagining data: $e');
      return null;
    }
  }
}
