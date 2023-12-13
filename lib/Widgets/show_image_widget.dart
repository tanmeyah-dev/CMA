// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';


class ShowImagesWidget extends StatelessWidget {
  final List<String> images;
  final ImageProvider? image;
  final int currentIndex;
  ShowImagesWidget({Key? key, required this.images,this.currentIndex = 0,this.image}):
        pageController = PageController(initialPage: currentIndex), super(key: key);

  final PageController pageController;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.black87.withOpacity(0.8),),
      body: PhotoViewGallery.builder(
        enableRotation: true,
        pageController: pageController,
        scrollPhysics: const BouncingScrollPhysics(),
        builder: (BuildContext context, int index) {
          return PhotoViewGalleryPageOptions(
            imageProvider: image??NetworkImage(images[index]),
            initialScale: PhotoViewComputedScale.contained,
            heroAttributes: PhotoViewHeroAttributes(tag: image??images[index]),
          );
        },
        itemCount: image!=null?1:images.length,
        loadingBuilder: (context, event) => Center(
          child: Container(
            width: 20.0,
            height: 20.0,
            color: Colors.grey.shade400,
            child: CircularProgressIndicator(
              value: event == null
                  ? 0
                  : event.cumulativeBytesLoaded / event.expectedTotalBytes!,
            ),
          ),
        ),
      ),
    );
  }
}
