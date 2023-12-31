import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'dart:typed_data';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

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
      Response<List<int>> response = await dio.get<List<int>>(
        url,
        options: Options(responseType: ResponseType.bytes),
      );

      if (response.statusCode == 200) {
        Uint8List uint8List = Uint8List.fromList(response.data!);

        var filePath = await saveImageToFile(url, uint8List);
        return filePath;
      }
    } catch (e) {
      print('Error downloading and saving image: $e');
    }
    return null;
  }

  static Future<String?> saveImageToFile(
      String url, Uint8List uint8List) async {
    try {
      final documentPath = await getApplicationDocumentsDirectory();
      String fileName = url.split('/').last;
      String filePath = '${documentPath.path}/$fileName';

      File file = File(filePath);

      if (await file.exists()) {
        print('File already exists: ${file.path}');
        return null;
      }

      await file.writeAsBytes(uint8List);
      print('Image saved to file: ${file.path}');
      return file.path;
    } catch (e) {
      print('Error saving image to file: $e');
      return null;
    }
  }
}
