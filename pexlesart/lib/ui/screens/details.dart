import 'package:flutter/material.dart';
import 'package:pexlesart/ui/widgets/customerpop.dart';
import 'package:provider/provider.dart';

import '../../core/view_model/favorite_view_model.dart';
import '../../core/view_model/save_image_view_model.dart';
import '../../models/favorit_model.dart';
import '../../models/wallpaper_model.dart';
import '../../size_config.dart';
import '../widgets/customer_text_button.dart';
import '../widgets/imagenetwork.dart';

class DetailsScreen extends StatefulWidget {
  const DetailsScreen({Key? key, required this.data}) : super(key: key);
  final Photo data;

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {

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
    FavoriteViewModel geFavoriteProv = Provider.of<FavoriteViewModel>(context);
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
                    onPressed: () {
                      if (geFavoriteProv.isFav(widget.data.id)) {
                        geFavoriteProv.deleteFavorite(widget.data.id);
                        geFavoriteProv.isFav(widget.data.id);
                      } else {
                        try {
                          geFavoriteProv.addToFavorite(
                            favorite: FavoriteModel(
                              id: widget.data.id,
                              width: widget.data.width,
                              height: widget.data.height,
                              photographerId: widget.data.photographerId,
                              photographer: widget.data.photographer,
                              photographerUrl: widget.data.photographerUrl,
                              avgColor: widget.data.avgColor,
                              original: widget.data.src.original,
                              alt: widget.data.alt,
                            ),
                          );
                          geFavoriteProv.isFav(widget.data.id);
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Text("Add to favorite"),
                            dismissDirection: DismissDirection.down,
                            duration: Duration(milliseconds: 300),
                          ));
                        } catch (e) {
                          CustomerPOP().handleErrors(context, '$e');
                        }
                      }
                        geFavoriteProv.isFav(widget.data.id);
                    },
                    icon: Icon(
                      Provider.of<FavoriteViewModel>(context).isFav(widget.data.id)
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
                    url: widget.data.src.original,
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
              widget.data.src.original,
            );
          },
          child: const Icon(Icons.download),
        ),
      ),
    );
  }
}
