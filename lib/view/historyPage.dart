import 'package:flutter/material.dart';
import 'package:project/controller/provider/searchProvider.dart';
import 'package:provider/provider.dart';

class SearchHistoryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final searchHistoryProvider = Provider.of<SearchHistoryProvider>(context);
    final searchHistory = searchHistoryProvider.searchHistory;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: const Text(
          'Search History',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      backgroundColor: Colors.black,
      body: ListView.builder(
        itemCount: searchHistory.length,
        itemBuilder: (context, index) {
          final entry = searchHistory[index];
          return ListTile(
            title: Text(
              entry.cityName,
              style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 25),
            ),
            subtitle: Text(
              'Latitude: ${entry.latitude}, Longitude: ${entry.longitude}',
              style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 15),
            ),
          );
        },
      ),
    );
  }
}
