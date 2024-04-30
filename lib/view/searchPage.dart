// ignore_for_file: no_leading_underscores_for_local_identifiers, avoid_print, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:project/controller/controller.dart';
import 'package:project/controller/provider/searchProvider.dart';
import 'package:project/model/cityModel.dart';
import 'package:project/model/weatherDataModel.dart';
import 'package:project/view/homePage.dart';
import 'package:provider/provider.dart';

class SearchPage extends StatelessWidget {
  final TextEditingController _placeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final weatherProvider = Provider.of<WeatherDataProvider>(context);
final searchHistoryProvider = Provider.of<SearchHistoryProvider>(context);
    void _showDialog(String title, String content) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.black,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
              side: const BorderSide(color: Colors.white),
            ),
            title: Text(
              title,
              style: const TextStyle(color: Colors.white),
            ),
            content: Text(
              content,
              style: const TextStyle(color: Colors.white),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text(
                  'OK',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          );
        },
      );
    }

    void _searchWeather(String cityName) async {
      if (cityName.isNotEmpty) {
        await weatherProvider.fetchCityInfo(cityName);
        CityModel? cityInfo = weatherProvider.cityModel;
        if (cityInfo != null) {
          print(cityName);
          print(cityInfo.lat);
          print(cityInfo.lon);
          weatherProvider.fetchWeatherData(cityInfo.lat, cityInfo.lon);
          weatherProvider.fetchWeatherDataList(cityInfo.lat, cityInfo.lon);
           searchHistoryProvider.addSearchEntry(SearchEntry(cityName, cityInfo.lat, cityInfo.lon));
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const HomePage(),
            ),
          );
        } else {
          // Handle when city is not found
          _showDialog('City Not Found', 'Please enter a valid city name.');
        }
      } else {
        // Handle empty city name
        _showDialog('Empty City Name', 'Please enter a city name.');
      }
    }

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          onPressed: () {
            Navigator.pushNamed(context, '/');
          },
          icon: const Icon(
            Icons.arrow_back,
            size: 30,
            color: Colors.white,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const Text(
                'Manage Cities ',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 25),
              Center(
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(96, 158, 158, 158),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: TextField(
                    controller: _placeController,
                    cursorColor: Colors.white,
                    style: const TextStyle(color: Colors.white),
                    decoration: const InputDecoration(
                      hintText: 'Enter Location',
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(horizontal: 16),
                      hintStyle: TextStyle(color: Colors.grey),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 50),
              Center(
                child: SizedBox(
                  height: 60,
                  width: 200,
                  child: ElevatedButton(
                    onPressed: () {
                      _searchWeather(_placeController.text);
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white, backgroundColor: Colors.blue,
                    ),
                    child: const Text('Search'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
