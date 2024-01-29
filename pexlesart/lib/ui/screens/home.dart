import 'package:flutter/material.dart';
import 'package:pexlesart/core/view_model/curent_wallpaper_view_model.dart';
import 'package:pexlesart/ui/screens/favorite.dart';
import 'package:pexlesart/ui/widgets/customerpop.dart';
import 'package:provider/provider.dart';
import '../../core/view_model/search_view_model.dart';
import '../../size_config.dart';
import '../widgets/customer_text_button.dart';
import '../widgets/imagenetwork.dart';
import '../widgets/navigator.dart';
import 'details.dart';

class MyHomeScreen extends StatefulWidget {
  const MyHomeScreen({Key? key}) : super(key: key);

  @override
  State<MyHomeScreen> createState() => _MyHomeScreenState();
}

class _MyHomeScreenState extends State<MyHomeScreen> {
  @override
  void initState() {
    final CurentWallpaperViewModel getDataProv =
        Provider.of<CurentWallpaperViewModel>(context, listen: false);
    getDataProv.curentPhotosProf();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final CurentWallpaperViewModel getDataProv =
        Provider.of<CurentWallpaperViewModel>(context);
    SizeConfig().init(context);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('WallpaperApp'),
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: () {
                NavigatorScreen().push(context, screen: const FavoriteScreen());
              },
              icon: const Icon(
                Icons.favorite,
                size: 30,
                color: Colors.red,
              ),
            ),
          ],
        ),
        body: Container(
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: getDataProv.loading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : GridView.builder(
                    itemCount: getDataProv.wallpaper!.photos.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      // mainAxisExtent: 10.0,
                      childAspectRatio: 0.8,
                      crossAxisSpacing: 6,
                      mainAxisSpacing: 10,
                    ),
                    itemBuilder: (_, index) {
                      final data = getDataProv.wallpaper!.photos[index];
                      return InkWell(
                        onTap: () => NavigatorScreen().push(context,
                            screen: DetailsScreen(
                              data: data,
                            )),
                        child: Hero(
                          tag: data.id,
                          child: Stack(
                            alignment: Alignment.bottomCenter,
                            children: [
                              /// Image viewer
                              SizedBox(
                                width: SizeConfig.screenHeight,
                                height: SizeConfig.screenHeight,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: CustomerImageNetWork(
                                    url: data.src.original,
                                  ),
                                ),
                              ),

                              /// some details viewer
                              Container(
                                alignment: Alignment.bottomCenter,
                                width: SizeConfig.screenWidth,
                                height: SizeConfig.screenHeight / 13,
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                decoration: const BoxDecoration(
                                  color: Colors.black26,
                                  borderRadius: BorderRadius.only(
                                    bottomRight: Radius.circular(10),
                                    bottomLeft: Radius.circular(10),
                                  ),
                                ),
                                child: Column(
                                  children: [
                                    CustomerTextButton(
                                      photographer: data.photographer,
                                      url: data.photographerUrl,
                                      fontSize: 15,
                                    ),
                                    Text(
                                      data.alt,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        fontSize: 15,
                                        color: Colors.black,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              ),


                            ],
                          ),
                        ),
                      );
                    })),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            SearchViewModel searchProvider =
                Provider.of<SearchViewModel>(context, listen: false);
            CustomerPOP().popDialog(context,
                title: Form(
                  key: _globalKey,
                  child: TextFormField(
                    onSaved: searchProvider.onSave,
                    onChanged: searchProvider.onChange,
                    validator: (val) {
                      if (val == null || val.isNotEmpty) {
                        return '';
                      }
                      return 'error';
                    },
                  ),
                ),
                desc: 'Enter Some Words',
                action: [
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text(
                        'Cancel',
                        style: TextStyle(
                          color: Colors.red,
                        ),
                      )),
                  IconButton(
                    onPressed: () async {
                      if (_globalKey.currentState!.validate()) {
                        print('ERROR-->');
                      } else {
                        await searchProvider.resultSearch(
                            context, searchProvider.textEditingController);
                      }
                    },
                    icon: const Icon(
                      Icons.search,
                      color: Colors.blue,
                      size: 30,
                    ),
                  ),
                ]);
          },
          child: const Icon(Icons.search),
        ),
      ),
    );
  }

  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
}
