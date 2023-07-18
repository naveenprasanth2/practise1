import 'dart:math';

import 'package:flutter/material.dart';

class RatingView extends StatefulWidget {
  const RatingView({super.key});

  @override
  State<RatingView> createState() => _RatingViewState();
}

class _RatingViewState extends State<RatingView> {
  final PageController _pageController = PageController();
  double _starPosition = 200.0;
  int _rating = 0;
  int _selectedChipIndex = -1;
  String _selectedValue = "";
  bool _isMoreDetailActive = false;
  final FocusNode _moreDetailsFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24), color: Colors.white),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        children: [
          //Thanks Note
          SizedBox(
            height: max(300, MediaQuery.of(context).size.height * 0.3),
            child: PageView(
              controller: _pageController,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                _buildThanksNote(),
                _causeOfRating(),
              ],
            ),
          ),
          //Submit button
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              color: Colors.red.shade400,
              child: MaterialButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text(
                  "Done",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
          //skip button
          Positioned(
            right: 0,
            child: MaterialButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("skip"),
            ),
          ),
          //animated stars
          AnimatedPositioned(
            top: _starPosition,
            left: 0,
            right: 0,
            duration: const Duration(milliseconds: 300),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                5,
                (index) => IconButton(
                    onPressed: () {
                      _pageController.nextPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeIn);
                      setState(() {
                        _starPosition = 20.0;
                        //index starts with 0, so added 1
                        _rating = index + 1;
                      });
                    },
                    icon: index < _rating
                        ? const Icon(
                            Icons.star,
                          )
                        : const Icon(Icons.star_outline_outlined),
                    color: Colors.red.shade400),
              ),
            ),
          ),
          //back button
          if (_isMoreDetailActive)
            Positioned(
              top: 0,
              left: 0,
              child: MaterialButton(
                onPressed: () {
                  setState(() {
                    _isMoreDetailActive = false;
                  });
                },
                child: const Icon(Icons.arrow_back_ios),
              ),
            ),
        ],
      ),
    );
  }

  _buildThanksNote() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Thanks for using our service",
          style: TextStyle(
            fontSize: 24,
            color: Colors.red.shade400,
            fontWeight: FontWeight.bold,
          ),
        ),
        const Text("We'd love to hear your feed back"),
        const Text("How was your experience?"),
      ],
    );
  }

  _causeOfRating() {
    return Stack(
      alignment: Alignment.center,
      children: [
        Visibility(
          visible: !_isMoreDetailActive,
          //text field display
          replacement: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text("Tell us more"),
              Chip(label: Text(_selectedValue)),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  focusNode: _moreDetailsFocusNode,
                  decoration: InputDecoration(
                      hintText: "Write your review here",
                      hintStyle: TextStyle(
                        color: Colors.grey.shade400,
                      ),
                      border: InputBorder.none),
                ),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text("What could be better?"),
              Wrap(spacing: 8, alignment: WrapAlignment.center, children: [
                InkWell(
                  onTap: () {
                    setState(() {
                      _selectedValue = "Bedroom";
                    });
                  },
                  child: Chip(
                    backgroundColor: _selectedValue == "Bedroom"
                        ? Colors.red.shade400
                        : Colors.grey.shade200,
                    label: Text("Bedroom",
                        style: TextStyle(
                          color: _selectedValue == "Bedroom"
                              ? Colors.white
                              : Colors.black,
                        )),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20.0),
                        topRight: Radius.circular(20.0),
                        bottomLeft: Radius.circular(20.0),
                        bottomRight: Radius.circular(20.0),
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      _selectedValue = "Washroom";
                    });
                  },
                  child: Chip(
                    backgroundColor: _selectedValue == "Washroom"
                        ? Colors.red.shade400
                        : Colors.grey.shade200,
                    label: Text("Washroom",
                        style: TextStyle(
                          color: _selectedValue == "Washroom"
                              ? Colors.white
                              : Colors.black,
                        )),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20.0),
                        topRight: Radius.circular(20.0),
                        bottomLeft: Radius.circular(20.0),
                        bottomRight: Radius.circular(20.0),
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      _selectedValue = "Bed";
                    });
                  },
                  child: Chip(
                    backgroundColor: _selectedValue == "Bed"
                        ? Colors.red.shade400
                        : Colors.grey.shade200,
                    label: Text("Bed",
                        style: TextStyle(
                          color: _selectedValue == "Bed"
                              ? Colors.white
                              : Colors.black,
                        )),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20.0),
                        topRight: Radius.circular(20.0),
                        bottomLeft: Radius.circular(20.0),
                        bottomRight: Radius.circular(20.0),
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      _selectedValue = "Staff Behaviour";
                    });
                  },
                  child: Chip(
                    backgroundColor: _selectedValue == "Staff Behaviour"
                        ? Colors.red.shade400
                        : Colors.grey.shade200,
                    label: Text("Staff Behaviour",
                        style: TextStyle(
                          color: _selectedValue == "Staff Behaviour"
                              ? Colors.white
                              : Colors.black,
                        )),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20.0),
                        topRight: Radius.circular(20.0),
                        bottomLeft: Radius.circular(20.0),
                        bottomRight: Radius.circular(20.0),
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      _selectedValue = "Cleanliness";
                    });
                  },
                  child: Chip(
                    backgroundColor: _selectedValue == "Cleanliness"
                        ? Colors.red.shade400
                        : Colors.grey.shade200,
                    label: Text("Cleanliness",
                        style: TextStyle(
                          color: _selectedValue == "Cleanliness"
                              ? Colors.white
                              : Colors.black,
                        )),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20.0),
                        topRight: Radius.circular(20.0),
                        bottomLeft: Radius.circular(20.0),
                        bottomRight: Radius.circular(20.0),
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      _selectedValue = "Basic Amenities";
                    });
                  },
                  child: Chip(
                    backgroundColor: _selectedValue == "Basic Amenities"
                        ? Colors.red.shade400
                        : Colors.grey.shade200,
                    label: Text("Basic Amenities",
                        style: TextStyle(
                          color: _selectedValue == "Basic Amenities"
                              ? Colors.white
                              : Colors.black,
                        )),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20.0),
                        topRight: Radius.circular(20.0),
                        bottomLeft: Radius.circular(20.0),
                        bottomRight: Radius.circular(20.0),
                      ),
                    ),
                  ),
                ),
              ]),
              const SizedBox(
                height: 16,
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    _moreDetailsFocusNode.requestFocus();
                    _isMoreDetailActive = true;
                  });
                },
                child: const Text(
                  "want to tell us more?",
                  style: TextStyle(
                    decoration: TextDecoration.underline,
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
