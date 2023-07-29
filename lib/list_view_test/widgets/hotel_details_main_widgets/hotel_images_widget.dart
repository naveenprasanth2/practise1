import 'package:flutter/material.dart';
import 'package:practise1/list_view_test/models/hotel_detail_model/hotel_details_model_v2.dart';

import '../../screens/hotel_booking/images_categorization_page.dart';
import '../images/image_stack.dart';

class HotelImagesWithIconsWidget extends StatefulWidget {
  final HotelDetailsModel? hotelDetailsModel;

  const HotelImagesWithIconsWidget({
    super.key,
    required this.hotelDetailsModel,
  });

  @override
  State<HotelImagesWithIconsWidget> createState() =>
      _HotelImagesWithIconsWidgetState();
}

class _HotelImagesWithIconsWidgetState
    extends State<HotelImagesWithIconsWidget> {
  late PageController _pageController;
  List<String> hotelPicTypes = ["reception", "lobby", "facade", "washroom"];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _pageController = PageController(
      initialPage: 0,
      viewportFraction: 1,
      keepPage: true,
    );
    _pageController.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: InkWell(
        onTap: () {
          if (widget.hotelDetailsModel?.hotelImages != null) {
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              builder: (context) {
                return HotelImagesBottomSheet(
                  hotelImagesModel: widget.hotelDetailsModel!.hotelImages,
                  tabName: "All",
                );
              },
            );
          }
        },
        child: SizedBox(
          height: 250,
          child: Stack(
            children: [
              Stack(
                alignment: Alignment.bottomCenter,
                // This aligns the children of the stack at the bottom center
                children: [
                  if (widget.hotelDetailsModel?.hotelImages.allImages != null)
                    PageView.builder(
                      itemCount: widget
                          .hotelDetailsModel!.hotelImages.allImages.length,
                      physics: const RangeMaintainingScrollPhysics(),
                      controller: _pageController,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          width: MediaQuery.of(context).size.width * 0.99,
                          margin: const EdgeInsets.symmetric(horizontal: 1.0),
                          child: Image.network(
                            widget.hotelDetailsModel!.hotelImages
                                .allImages[index],
                            fit: BoxFit.cover,
                          ),
                        );
                      },
                    ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: hotelPicTypes
                        .map((picType) => widget.hotelDetailsModel != null
                                ? Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 2),
                                    child: imageStack(
                                        picType.substring(0, 1).toUpperCase() +
                                            picType
                                                .substring(
                                                  1,
                                                )
                                                .toLowerCase(),
                                        widget.hotelDetailsModel!.hotelImages
                                            .getImageFromType(picType)[0],
                                        widget.hotelDetailsModel!,
                                        context),
                                  )
                                : Container() // or another placeholder widget for when hotelDetailsModel is null
                            )
                        .toList(),
                  ),
                ],
              ),
              Positioned(
                  top: 50,
                  left: 10,
                  child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Container(
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white60
                      ),
                      child: const Icon(
                        Icons.close,
                        size: 30,
                      ),
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
