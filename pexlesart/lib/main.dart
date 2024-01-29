import 'package:flutter/material.dart';
import 'package:pexlesart/core/view_model/favorite_view_model.dart';
import 'package:provider/provider.dart';

import 'core/db/db_helper.dart';
import 'ui/screens/home.dart';
import 'core/view_model/curent_wallpaper_view_model.dart';
import 'core/view_model/save_image_view_model.dart';
import 'core/view_model/search_view_model.dart';
import 'ui/widgets/errorpagehandle.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DBHelper.initDB();
  const ErrorScreenHandle();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<CurentWallpaperViewModel>(
        create: (_) => CurentWallpaperViewModel(),
      ),
      ChangeNotifierProvider<SaveImageViewModel>(
        create: (_) => SaveImageViewModel(),
      ),
      ChangeNotifierProvider<SearchViewModel>(
        create: (_) => SearchViewModel(),
      ),
      ChangeNotifierProvider<FavoriteViewModel>(
        create: (_) => FavoriteViewModel(),
      ),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomeScreen(),
    );
  }
}
