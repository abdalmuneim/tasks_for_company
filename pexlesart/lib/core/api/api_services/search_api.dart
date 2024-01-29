import 'package:http/http.dart' as http;
import 'package:pexlesart/const.dart';
import 'package:pexlesart/models/wallpaper_model.dart';

class SearchApi {
  Future<WallpaperModel?> resultSearchApi(String query) async {
    WallpaperModel? wallpaperModel;

    final Uri url = Uri.parse(searchEndPoint + query + perPageLimit);

    try {
      http.Response response =
          await http.get(url, headers: {"Authorization": apiKey});

      if (response.statusCode == 200) {
        final str = response.body;

        wallpaperModel = wallpaperModelFromJson(str);
      } else {
        print('response.statusCode: ${response.statusCode}');
      }
    } catch (e) {
      print('ERROR-->$e');
    }
    return wallpaperModel;
  }
}
