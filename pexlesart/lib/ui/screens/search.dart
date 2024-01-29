import 'package:flutter/material.dart';
import 'package:pexlesart/models/wallpaper_model.dart';
import 'package:pexlesart/size_config.dart';

import '../widgets/customer_text_button.dart';
import '../widgets/imagenetwork.dart';
import '../widgets/navigator.dart';
import 'details.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key, required this.data,required this.word,}) : super(key: key);
  final WallpaperModel? data;
  final String word;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              title: Text(word),
              centerTitle: true,
            ),
            body: Container(
              margin: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
              child: GridView.builder(
                  itemCount: data!.photos.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    // mainAxisExtent: 10.0,
                    childAspectRatio: 0.8,
                    crossAxisSpacing: 6,
                    mainAxisSpacing: 10,
                  ),
                  itemBuilder: (_, index) {
                    final inData = data!.photos[index];
                    return InkWell(
                      onTap: () => NavigatorScreen().push(context,
                          screen: DetailsScreen(
                            data: inData,
                          )),
                      child: Hero(
                        tag: inData.id,
                        child: Stack(
                          alignment: Alignment.bottomCenter,
                          children: [
                            SizedBox(
                              width: SizeConfig.screenHeight,
                              height: SizeConfig.screenHeight,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: CustomerImageNetWork(
                                  url: inData.src.original,
                                ),
                              ),
                            ),
                            Container(
                              alignment: Alignment.bottomCenter,
                              width: SizeConfig.screenWidth,
                              height: SizeConfig.screenHeight / 13,
                              padding: const EdgeInsets.symmetric(horizontal: 10),
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
                                    photographer: inData.photographer,
                                    url: inData.photographerUrl,
                                    fontSize: 15,
                                  ),
                                  Text(
                                    inData.alt,
                                    style: const TextStyle(
                                      fontSize: 15,
                                      color: Colors.black,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
            )));
  }
}
