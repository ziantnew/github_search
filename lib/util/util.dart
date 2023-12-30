import 'package:dio/dio.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'dart:typed_data';

//github accessToken
const accessToken =
    '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';

class Utils {
  static bool isNotNullAndNotEmpty(List<dynamic>? list) {
    return list != null && list.isNotEmpty;
  }

  static Future<String?> downloadAndSaveImage(String url) async {
    try {
      Dio dio = Dio();
      Response<List<int>> response = await dio.get<List<int>>(url,
          options: Options(responseType: ResponseType.bytes));

      if (response.statusCode == 200) {
        Uint8List uint8List = Uint8List.fromList(response.data!);
        var file = await DefaultCacheManager().putFile(url, uint8List);
        if (file != null) {
          return file.path;
        }
      }
    } catch (e) {
      print('Error downloading and saving image: $e');
    }
    return null;
  }
}
