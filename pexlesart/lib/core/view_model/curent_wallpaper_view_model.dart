import 'package:flutter/cupertino.dart';
import 'package:pexlesart/core/api/api_services/get_curent_image.dart';
import 'package:pexlesart/models/wallpaper_model.dart';

class CurentWallpaperViewModel extends ChangeNotifier {
  WallpaperModel? _wallpaper;
  bool loading = false;
  WallpaperModel? get wallpaper => _wallpaper;

  Future<WallpaperModel?> curentPhotosProf() async {
    loading = true;
    GetCurentPhotos model = GetCurentPhotos();
    _wallpaper = await model.getCuratedPhotos();
    loading = false;
    print('_wallpaper: $_wallpaper');
    notifyListeners();
    return _wallpaper;
  }
}
