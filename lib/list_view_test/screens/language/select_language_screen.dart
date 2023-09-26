import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:practise1/list_view_test/providers/language_provider.dart';
import 'package:practise1/list_view_test/utils/dart_helper/sizebox_helper.dart';
import 'package:provider/provider.dart';

class SelectLanguageScreen extends StatelessWidget {
  SelectLanguageScreen({Key? key}) : super(key: key);

  final List<Map<String, String>> languages = [
    {"United Kingdom": "English"},
    {"United States": "English"}
  ];

  @override
  Widget build(BuildContext context) {
    return Consumer<LanguageProvider>(builder: (context, languageProvider, _) {
      return Scaffold(
        appBar: AppBar(
          title: const Text("Choose Language"),
          leading: IconButton(
            onPressed: () {
              languageProvider.setSelectedCountryAndLanguage(
                  languageProvider.countryAndLanguage);
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
          ),
          centerTitle: true,
          actions: [
            InkWell(
              onTap: () {
                languageProvider.setCurrentLanguage(
                    languageProvider.selectedCountryAndLanguage);
                Navigator.pop(context);
              },
              child: const Padding(
                padding: EdgeInsets.only(right: 16.0),
                child: Text(
                  "Done",
                  style: TextStyle(color: Colors.blue),
                ),
              ),
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Current",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black26,
                            ),
                          ),
                          SizedBoxHelper.sizedBox20,
                          Text(
                            languageProvider
                                .countryAndLanguage.entries.first.value
                                .toString(),
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            languageProvider
                                .countryAndLanguage.entries.first.key
                                .toString(),
                            style: const TextStyle(
                              color: Colors.black45,
                            ),
                          ),
                        ],
                      ),
                      const Icon(Icons.check)
                    ],
                  ),
                ),
                SizedBoxHelper.sizedBox20,
                const Text(
                  "Available",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black26,
                  ),
                ),
                SizedBoxHelper.sizedBox20,
                Column(
                  children: languages
                      .map(
                        (language) => InkWell(
                          onTap: () {
                            languageProvider
                                .setSelectedCountryAndLanguage(language);
                          },
                          child: SizedBox(
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          language.entries.first.value
                                              .toString(),
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          language.entries.first.key.toString(),
                                          style: const TextStyle(
                                            color: Colors.black45,
                                          ),
                                        ),
                                      ],
                                    ),
                                    if (mapEquals(
                                        language,
                                        languageProvider
                                            .selectedCountryAndLanguage))
                                      const Icon(Icons.check)
                                  ],
                                ),
                                SizedBoxHelper.sizedBox20,
                              ],
                            ),
                          ),
                        ),
                      )
                      .toList(),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
