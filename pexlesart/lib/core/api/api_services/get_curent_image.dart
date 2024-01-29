import 'package:pexlesart/const.dart';
import 'package:http/http.dart' as http;

import '../../../models/wallpaper_model.dart';

class GetCurentPhotos {

  Future<WallpaperModel?> getCuratedPhotos() async {

    WallpaperModel? wallpaper;

    final Uri url = Uri.parse(curentImageUrl + perPageLimit);

    try {
      http.Response response =
          await http.get(url, headers: {"Authorization": apiKey});

      if (response.statusCode == 200) {
        final String strData = response.body;
        // final jsonData = jsonDecode(strData);
        // final Photos data = Photos.fromJson(jsonData);
        // wallpaper = data.photos.map((e) => WallpaperModel.fromJson(e)).toList();
        // return wallpaperModelFromJson(strData);
        wallpaper = wallpaperModelFromJson(strData);
      } else {
        print(response.statusCode);
      }
    } catch (e) {
      print(e);
    }
    return wallpaper;
  }
}
