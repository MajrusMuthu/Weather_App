// import 'package:flutter/material.dart';
// import 'package:project/controller/controller.dart';
// import 'package:provider/provider.dart';

// class SearchHistoryPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     final weatherProvider = Provider.of<WeatherDataProvider>(context);
//     final searchHistory = weatherProvider.searchHistory;
    
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Search History'),
//       ),
//       body: ListView.builder(
//         itemCount: searchHistory.length,
//         itemBuilder: (context, index) {
//           final city = searchHistory[index];
//           return ListTile(
//             title: Text(city.name),
//             subtitle: Text('Temperature: ${city.weatherData?.main?.temp ?? 'N/A'}'),
//           );
//         },
//       ),
//     );
//   }
// }
