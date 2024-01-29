import 'package:flutter/material.dart';
import 'package:pexlesart/models/favorit_model.dart';
import 'package:pexlesart/size_config.dart';
import 'package:pexlesart/ui/screens/details_favorite.dart';
import 'package:pexlesart/ui/widgets/imagenetwork.dart';
import 'package:pexlesart/ui/widgets/navigator.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../core/view_model/favorite_view_model.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({Key? key}) : super(key: key);

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {

  @override
  void initState() {
    final FavoriteViewModel getDataProv =
        Provider.of<FavoriteViewModel>(context, listen: false);
    getDataProv.getFavorite();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    FavoriteViewModel getFavoriteProv = Provider.of<FavoriteViewModel>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorite'),
        centerTitle: true,
      ),
      body: getFavoriteProv.favoriteList.isNotEmpty
          ? ListView.builder(
              itemCount: getFavoriteProv.favoriteList.length,
              itemBuilder: (context, index) {
                final FavoriteModel list = getFavoriteProv.favoriteList[index];
                return Stack(
                  children: [
                    InkWell(
                      onTap: () => NavigatorScreen().push(context,
                          screen: DetailsFavoriteScreen(data: list)),
                      child: Card(
                        elevation: 5,
                        margin: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            /// Image View
                            Container(
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 5, vertical: 5),
                              width: SizeConfig.screenWidth / 3,
                              height: SizeConfig.screenHeight / 4,
                              child: CustomerImageNetWork(url: list.original),
                            ),

                            /// vertical Line
                            Container(
                              width: .5,
                              height: SizeConfig.screenHeight / 4,
                              color: Colors.black,
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 5, vertical: 5),
                            ),

                            /// Some Details
                            Container(
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 5, vertical: 5),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  /// Photographer data
                                  TextButton(
                                    onPressed: () async => await canLaunchUrl(
                                      Uri.parse(list.photographerUrl),
                                    ),
                                    child: RichText(
                                      text: TextSpan(
                                        children: [
                                          TextSpan(
                                            text: list.photographer,
                                            style: const TextStyle(
                                                fontSize: 20,
                                                color: Colors.black),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 20.0),

                                  /// width and height
                                  RichText(
                                    text: TextSpan(
                                      style: const TextStyle(
                                          fontSize: 25, color: Colors.blue),
                                      children: [
                                        const TextSpan(text: 'height: '),
                                        TextSpan(
                                          text: '${list.height}',
                                          style: const TextStyle(
                                              fontSize: 20,
                                              color: Colors.black),
                                        ),
                                      ],
                                    ),
                                  ),
                                  RichText(
                                    text: TextSpan(
                                      style: const TextStyle(
                                          fontSize: 25, color: Colors.blue),
                                      children: [
                                        const TextSpan(text: 'width: '),
                                        TextSpan(
                                          text: '${list.width}',
                                          style: const TextStyle(
                                              fontSize: 20,
                                              color: Colors.black),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 20.0),

                                  /// avg Colors
                                  RichText(
                                    text: TextSpan(
                                      style: const TextStyle(
                                          fontSize: 25, color: Colors.blue),
                                      children: [
                                        const TextSpan(text: 'avgColor: '),
                                        TextSpan(
                                          text: list.avgColor,
                                          style: const TextStyle(
                                              fontSize: 20,
                                              color: Colors.black),
                                        ),
                                      ],
                                    ),
                                  ),

                                  /// alt
                                  RichText(
                                    text: TextSpan(
                                      style: const TextStyle(
                                          fontSize: 25, color: Colors.blue),
                                      children: [
                                        const TextSpan(text: 'alt: '),
                                        TextSpan(
                                          text: list.alt,
                                          style: const TextStyle(
                                              fontSize: 20,
                                              color: Colors.black),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 10,
                      right: 20,
                      child: Container(
                        width: 40,
                        alignment: Alignment.center,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.red,
                        ),
                        child: IconButton(
                          alignment: Alignment.center,
                          onPressed: () {
                            getFavoriteProv.deleteFavorite(list.id);
                            getFavoriteProv.getFavorite();
                          },
                          icon: const Icon(Icons.delete),
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                );
              })

          /// If Favorite List Is Empty
          : const Center(
              child: Text(
                'Go To Add Some Photo To Favorite!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 30,
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
    );
  }
}
