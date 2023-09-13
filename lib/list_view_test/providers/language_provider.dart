import 'package:flutter/material.dart';

class LanguageProvider extends ChangeNotifier {
  Map<String, String>? _countryAndLanguage;
  Map<String, String>? _selectedCountryAndLanguage;
  LanguageProvider() {
    _countryAndLanguage = {"United Kingdom": "English"};
    _selectedCountryAndLanguage = _countryAndLanguage;
  }

  Map<String, String> get countryAndLanguage => _countryAndLanguage!;

  Map<String, String> get selectedCountryAndLanguage =>
      _selectedCountryAndLanguage!;

  void setCurrentLanguage(Map<String, String> countryAndLanguage) {
    _countryAndLanguage = countryAndLanguage;
    _selectedCountryAndLanguage = countryAndLanguage;
    notifyListeners();
  }

  void setSelectedCountryAndLanguage(Map<String, String> countryAndLanguage) {
    _selectedCountryAndLanguage = countryAndLanguage;
    notifyListeners();
  }
}
