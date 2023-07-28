import 'package:flutter/material.dart';
import 'package:practise1/list_view_test/screens/hotel_booking/images_detail_page.dart';

class ImageListView extends StatelessWidget {
  final List<String> images;

  const ImageListView({Key? key, required this.images}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: images.length,
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (builder) =>
                    ImagesDetailPage(images: images, index: index),
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
