import 'dart:typed_data';

import 'package:http/http.dart' as http;

class DownloadApi {


  late Uint8List uint8list;
  Future<Uint8List> getUint8Photo(String url) async {
    try {
      final http.Response response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        uint8list = response.bodyBytes;
      }
    } catch (e) {
      print("ERROR--> $e");
    }
    return uint8list;
  }
}
