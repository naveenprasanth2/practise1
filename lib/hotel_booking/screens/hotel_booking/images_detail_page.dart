import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ImagesDetailPage extends StatefulWidget {
  final List<String> allImages;
  final int index;

  const ImagesDetailPage({
    Key? key,
    required this.allImages,
    required this.index,
  }) : super(key: key);

  @override
  State<ImagesDetailPage> createState() => _ImagesDetailPageState();
}

class _ImagesDetailPageState extends State<ImagesDetailPage> {
  late PageController _pageController;
  bool _isZoomed = false;

  @override
  void initState() {
    _pageController = PageController(
      initialPage: widget.index,
      viewportFraction: 1,
      keepPage: true,
    );
    _pageController.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    var isLandscape = screenHeight < screenWidth;

    return Scaffold(
      backgroundColor: Colors.white60,
      body: Stack(
        children: [
          Center(
            child: PageView.builder(
              itemCount: widget.allImages.length,
              physics: _isZoomed
                  ? const NeverScrollableScrollPhysics()
                  : const AlwaysScrollableScrollPhysics(),
              controller: _pageController,
              scrollDirection: Axis.horizontal,
              itemBuilder: (BuildContext context, int index) {
                return SizedBox(
                  width: screenWidth,
                  height: isLandscape ? screenHeight : 250,
                  // change height based on orientation
                  child: PhotoView(
                    enableRotation: true,
                    basePosition: Alignment.center,
                    backgroundDecoration:
                    const BoxDecoration(color: Colors.transparent),
                    imageProvider: NetworkImage(widget.allImages[index]),
                    minScale: PhotoViewComputedScale.contained * 0.8,
                    maxScale: PhotoViewComputedScale.covered * 2.0,
                    initialScale: PhotoViewComputedScale.contained * 1.0,
                    scaleStateChangedCallback:
                        (PhotoViewScaleState scaleState) {
                      setState(() {
                        _isZoomed = scaleState !=
                            PhotoViewScaleState
                                .initial; // Set _isZoomed to true if the image is zoomed in
                      });
                    },
                  ),
                );
              },
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SmoothPageIndicator(
                controller: _pageController,
                count: widget.allImages.length,
                effect: const ScrollingDotsEffect(
                  dotColor: Colors.grey,
                  activeDotColor: Colors.white,
                  dotHeight: 8,
                  dotWidth: 8,
                  spacing: 8,
                  maxVisibleDots: 5,
                ),
              ),
            ),
          ),
          Positioned(
            top: 40,
            left: 10,
            child: Material(
              type: MaterialType.transparency,
              child: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const Padding(
                  padding: EdgeInsets.all(12.0), // increase the hit area
                  child: Icon(
                    Icons.close,
                    color: Colors.black,
                    size: 30,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
