import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

class ExistenceCheckResult {
  final bool exists;
  final String filePath;

  ExistenceCheckResult({required this.exists, required this.filePath});
}

class ImageFilePath extends StatelessWidget {
  final String filePath;

  const ImageFilePath({Key? key, required this.filePath}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<ExistenceCheckResult>(
      future: _checkFileExistence(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          print("File exists: ${snapshot.data!.exists}");
          if (snapshot.data!.exists) {
            return SizedBox(
              width: 40,
              height: 40,
              child: Image.file(
                File(snapshot.data!.filePath),
                fit: BoxFit.cover,
              ),
            );
          } else {
            return const SizedBox(
              width: 40,
              height: 40,
              child: Text('File not found'),
            );
          }
        } else {
          return const SizedBox(
            width: 40,
            height: 40,
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  Future<ExistenceCheckResult> _checkFileExistence() async {
    File file = File(filePath);
    print('File path: $filePath');

    if (Platform.isIOS) {
      final documentPath = (await getApplicationDocumentsDirectory()).path;
      File destinationFile = File('$documentPath/${path.basename(file.path)}');

      if (!(await destinationFile.exists())) {
        await file.copy(destinationFile.path);
      }

      return ExistenceCheckResult(
          exists: await destinationFile.exists(),
          filePath: destinationFile.path);
    }

    return ExistenceCheckResult(
        exists: await file.exists(), filePath: filePath);
  }
}
