import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/view_model/favorite_view_model.dart';
import '../../core/view_model/save_image_view_model.dart';
import '../../models/favorit_model.dart';
import '../../size_config.dart';
import '../widgets/customer_text_button.dart';
import '../widgets/imagenetwork.dart';

class DetailsFavoriteScreen extends StatefulWidget {
  const DetailsFavoriteScreen({Key? key, required this.data}) : super(key: key);
  final FavoriteModel data;

  @override
  State<DetailsFavoriteScreen> createState() => _DetailsFavoriteScreenState();
}

class _DetailsFavoriteScreenState extends State<DetailsFavoriteScreen> {
  // late bool isFav;

  @override
  void initState() {
    final FavoriteViewModel getDataProv =
        Provider.of<FavoriteViewModel>(context, listen: false);
    getDataProv.getFavorite();
    getDataProv.favoriteList;
    getDataProv.isFav(widget.data.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    FavoriteViewModel geFavoriteProv = Provider.of<FavoriteViewModel>(
      context,
    );
    return SafeArea(
      child: Scaffold(
        body: Hero(
          tag: widget.data.id,
          child: CustomScrollView(
            shrinkWrap: true,
            slivers: [
              /// App Bar title
              SliverAppBar(
                actions: [
                  IconButton(
                    onPressed: () async {
                      if (geFavoriteProv.fav) {
                        geFavoriteProv.deleteFavorite(widget.data.id);
                      } else {
                        try {
                          int value = await geFavoriteProv.addToFavorite(
                            favorite: FavoriteModel(
                              id: widget.data.id,
                              width: widget.data.width,
                              height: widget.data.height,
                              photographerId: widget.data.photographerId,
                              photographer: widget.data.photographer,
                              photographerUrl: widget.data.photographerUrl,
                              avgColor: widget.data.avgColor,
                              original: widget.data.original,
                              alt: widget.data.alt,
                            ),
                          );
                          print('value: $value');
                        } catch (e) {
                          print('failed add to favorite!: $e');
                        }
                      }
                      setState(() {});
                    },
                    icon: Icon(
                      geFavoriteProv.fav
                          ? Icons.favorite
                          : Icons.favorite_border,
                      size: 30,
                      color: Colors.red,
                    ),
                  ),
                ],
                flexibleSpace: FlexibleSpaceBar(
                  title: CustomerTextButton(
                    photographer: widget.data.photographer,
                    url: widget.data.photographerUrl,
                    fontSize: 25,
                  ),
                  background: CustomerImageNetWork(
                    url: widget.data.original,
                  ),
                ),
                centerTitle: true,
                pinned: true,
                expandedHeight: SizeConfig.screenHeight * 0.6,
              ),

              /// screen body
              SliverList(
                delegate: SliverChildListDelegate(
                  [
                    Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 10),
                      child: Column(
                        children: [
                          RichText(
                            text: TextSpan(
                              style: const TextStyle(
                                  fontSize: 25, color: Colors.blue),
                              children: [
                                const TextSpan(text: 'height: '),
                                TextSpan(
                                  text: '${widget.data.height}',
                                  style: const TextStyle(
                                      fontSize: 20, color: Colors.black),
                                ),
                                const TextSpan(text: '               '),
                                const TextSpan(text: 'width: '),
                                TextSpan(
                                  text: '${widget.data.width}',
                                  style: const TextStyle(
                                      fontSize: 20, color: Colors.black),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 20.0),
                          RichText(
                            text: TextSpan(
                              style: const TextStyle(
                                  fontSize: 25, color: Colors.blue),
                              children: [
                                const TextSpan(text: 'avgColor: '),
                                TextSpan(
                                  text: widget.data.avgColor,
                                  style: const TextStyle(
                                      fontSize: 20, color: Colors.black),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 20.0),
                          RichText(
                            text: TextSpan(
                              style: const TextStyle(
                                  fontSize: 25, color: Colors.blue),
                              children: [
                                const TextSpan(text: 'alt: '),
                                TextSpan(
                                  text: widget.data.alt,
                                  style: const TextStyle(
                                      fontSize: 20, color: Colors.black),
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
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Provider.of<SaveImageViewModel>(context, listen: false).save(
              context,
              widget.data.original,
            );
          },
          child: const Icon(Icons.download),
        ),
      ),
    );
  }
}
