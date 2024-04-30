import 'package:flutter/material.dart';
import 'package:project/model/weatherDataModel.dart';

class SearchHistoryProvider with ChangeNotifier {
  List<SearchEntry> _searchHistory = [];

  List<SearchEntry> get searchHistory => _searchHistory;

  void addSearchEntry(SearchEntry entry) {
    _searchHistory.add(entry);
    notifyListeners();
  }
}
