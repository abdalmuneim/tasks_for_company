import 'dart:io';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

class ShareContent {
  static ShareContent? _instance;
  // Avoid self instance
  ShareContent._();
  static ShareContent get instance => _instance ??= ShareContent._();

  Future<File> urlToFile({required String imageUrl}) async {
    var rng = Random();
    Directory tempDir = await getTemporaryDirectory();
    String tempPath = tempDir.path;
    File file = File('$tempPath${rng.nextInt(100)}.png');
    http.Response response = await http.get(Uri.parse(imageUrl));
    await file.writeAsBytes(response.bodyBytes);

    return file;
  }
}
