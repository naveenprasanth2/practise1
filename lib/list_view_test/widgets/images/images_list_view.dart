import 'package:flutter/material.dart';
import 'package:practise1/list_view_test/screens/hotel_booking/images_detail_page.dart';

class ImageListView extends StatelessWidget {
  final List<String> images;
  final List<String> allImages;

  const ImageListView({
    Key? key,
    required this.images,
    required this.allImages,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int indexFromAll;
    return ListView.builder(
      itemCount: images.length,
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () {
            indexFromAll = allImages.indexOf(images[index]);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (builder) =>
                    ImagesDetailPage(allImages: allImages, index: indexFromAll),
              ),
            );
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0),
            child: Image.network(images[index]),
          ),
        );
      },
    );
  }
}
