import 'package:flutter/cupertino.dart';
import '../../models/wallpaper_model.dart';
import '../../ui/screens/search.dart';
import '../../ui/widgets/navigator.dart';
import '../api/api_services/search_api.dart';

class SearchViewModel extends ChangeNotifier {
  late String textEditingController;

  onChange(val) {
    textEditingController = val;
    notifyListeners();
  }

  onSave(vale) {
    textEditingController = vale;
    notifyListeners();
  }

  Future<WallpaperModel?> resultSearch(context, String query) async {
    loading = true;
    SearchApi model = SearchApi();
    _wallpaper = await model.resultSearchApi(query);
    loading = false;
    print('_wallpaper: $_wallpaper');
    notifyListeners();
    NavigatorScreen().push(context, screen: SearchScreen(data: _wallpaper,word:textEditingController));
    return _wallpaper;
  }

  WallpaperModel? _wallpaper;
  bool loading = false;

  WallpaperModel? get wallpaper => _wallpaper;
}
