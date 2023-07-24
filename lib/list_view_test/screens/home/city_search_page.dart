import 'package:flutter/material.dart';

import '../../constants/location_constants.dart';

// Sample list of cities (replace this with your actual data)
List<String> citiesList = LocationConstants.citiesList;

class SearchPage extends StatefulWidget {
  final TextEditingController homeSearchController;

  const SearchPage({
    super.key,
    required this.homeSearchController,
  });

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();
  List<String> _searchResults = [];

  // Function to perform the search
  void _performSearch(String query) {
    query = query.toLowerCase();
    setState(() {
      if (query.isEmpty) {
        // If the search query is empty, show all cities in the list
        _searchResults = List.from(citiesList);
      } else {
        // If the search query is not empty, filter the list based on the query
        _searchResults = citiesList
            .where((item) => item.toLowerCase().contains(query))
            .toList();
      }
    });
  }

  @override
  void initState() {
    _searchResults.addAll(citiesList);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Select a city"),
        backgroundColor: Colors.red,
        // Set the background color of the AppBar to red
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              controller: _searchController,
              onChanged: _performSearch,
              decoration: InputDecoration(
                hintText: "Enter city name",
                border: OutlineInputBorder(
                  borderSide: Divider.createBorderSide(context),
                  borderRadius: BorderRadius.circular(10),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: Divider.createBorderSide(context),
                  borderRadius: BorderRadius.circular(10),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: Divider.createBorderSide(context),
                  borderRadius: BorderRadius.circular(10),
                ),
                filled: false,
                contentPadding: const EdgeInsets.all(8),
              ),
              keyboardType: TextInputType.text,
              obscureText: false,
            ),
            Expanded(
              // Wrap the Column with Expanded
              child: ListView.builder(
                itemCount: _searchResults.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      _searchController.text =
                          _searchResults[index].split(",")[0];
                      widget.homeSearchController.text =
                          _searchResults[index].split(",")[0];
                      Navigator.pop(context);
                    },
                    child: ListTile(
                      title: Text(_searchResults[index]),
                      // You can add more details or custom widgets in the ListTile as needed
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
