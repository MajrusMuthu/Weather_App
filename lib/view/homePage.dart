// ignore_for_file: use_super_parameters, avoid_print, prefer_const_constructors, invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member

import 'package:flutter/material.dart';
import 'package:project/controller/controller.dart';
import 'package:project/model/cityModel.dart';
import 'package:project/view/historyPage.dart';
import 'package:project/view/searchPage.dart';
import 'package:project/view/widget/forecast.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<CityModel> searchResults = [];
  @override
  Widget build(BuildContext context) {
    return Consumer<WeatherDataProvider>(
      builder: (context, weatherProvider, _) {
        String formattedDate = DateFormat.yMMMd().format(
          DateTime.now(),
        );
        return Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            elevation: 0,
            shadowColor: Colors.transparent,
            backgroundColor: Colors.transparent,
            leading: const Icon(
              Icons.location_on,
              color: Colors.white,
            ),
            title: Text(
              weatherProvider.cityModel?.name ?? '',
              style: const TextStyle(color: Colors.white),
            ),
            actions: [
              IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SearchPage(),
                    ),
                  );
                },
                icon: const Icon(Icons.search, color: Colors.white),
              ),
              PopupMenuButton(
                iconColor: Colors.white,
                onSelected: (value) {
                  if (value == 0) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            SearchHistoryPage(),
                      ),
                    );
                    print("History menu is selected.");
                  } else if (value == 1) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            SearchPage(),
                      ),
                    );
                    print("Search menu is selected.");
                  }
                },
                itemBuilder: (BuildContext context) => [
                  const PopupMenuItem(
                    value: 0,
                    child: Text(
                      "History",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  const PopupMenuItem(
                    value: 1,
                    child: Text(
                      "Search",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
                color: Colors.black,
              )
            ],
          ),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height * 0.25,
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(17),
                        ),
                        color: Color.fromARGB(255, 16, 83, 198),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Today $formattedDate',
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              '${weatherProvider.weatherData?.weather?[0].main}',
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500),
                            ),
                            const Spacer(),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Stack(
                                  alignment: Alignment.topRight,
                                  children: [
                                    Text(
                                      '${weatherProvider.weatherData?.main?.temp?.toInt()} ',
                                      style: const TextStyle(
                                        fontSize: 50,
                                        color: Colors.white,
                                      ),
                                    ),
                                    const Positioned(
                                      right: 0,
                                      child: Text(
                                        '°C',
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Text(
                                  '${weatherProvider.weatherData?.main?.tempMax?.toInt()}°/${weatherProvider.weatherData?.main?.tempMin?.toInt()}°',
                                  style: const TextStyle(
                                    fontSize: 18,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                CircleAvatar(
                                  backgroundColor:
                                      const Color.fromARGB(96, 158, 158, 158),
                                  child: IconButton(
                                    onPressed: () async {
                                      // Call the method to fetch weather data again
                                      await weatherProvider.fetchWeatherData(
                                        weatherProvider.cityModel?.lat ?? 0.0,
                                        weatherProvider.cityModel?.lon ?? 0.0,
                                      );

                                      // Call the method to fetch forecast data again
                                      await weatherProvider
                                          .fetchWeatherDataList(
                                        weatherProvider.cityModel?.lat ?? 0.0,
                                        weatherProvider.cityModel?.lon ?? 0.0,
                                      );

                                      // Notify listeners about state changes using Provider
                                      weatherProvider.notifyListeners();
                                    },
                                    icon: const Icon(Icons.refresh,
                                        color: Colors.white),
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.1,
                      decoration: const BoxDecoration(
                        color: Color.fromARGB(255, 82, 80, 80),
                        borderRadius: BorderRadius.all(
                          Radius.circular(15),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Feel like',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 18),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Row(
                                      children: [
                                        const Icon(
                                          Icons.thermostat,
                                          color: Colors.white,
                                        ),
                                        Text(
                                          '${weatherProvider.weatherData?.main?.feelsLike?.toInt()} °C',
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Humidity is making it',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 18),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(right: 40),
                                      child: Row(
                                        children: [
                                          // Replace Icons.ac_unit with the desired icon
                                          Text(
                                            "${weatherProvider.weatherData?.weather?[0].description}",
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 15),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.1,
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 82, 80, 80),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Wind Speed',
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.white),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.wind_power,
                                      color: Colors.white,
                                      size: 18,
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      '${weatherProvider.weatherData?.wind?.speed} km/h',
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.1,
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 82, 80, 80),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Humidity',
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.white),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.water_drop,
                                      color: Colors.white,
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      '${weatherProvider.weatherData?.main?.humidity} %',
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    // Forecast Data Container
                    Container(
                      decoration: const BoxDecoration(
                        color: Color.fromARGB(255, 82, 80, 80),
                        borderRadius: BorderRadius.all(
                          Radius.circular(15),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(left: 10),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.calendar_month,
                                    color: Colors.white,
                                    size: 18,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    '5 day Forecast',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                        color: Colors.white),
                                  )
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Consumer<WeatherDataProvider>(
                              builder: (context, weatherProvider, _) {
                                final weatherDataList =
                                    weatherProvider.weatherDataList;
                                if (weatherDataList != null &&
                                    weatherDataList.length >= 5) {
                                  // Sort the weather data list by date
                                  weatherDataList.sort(
                                      (a, b) => a.dtTxt.compareTo(b.dtTxt));
                                  return Column(
                                    children: [
                                      for (int i = 0; i < 5; i++)
                                        Column(
                                          children: [
                                            buildWeatherInfo(
                                              _getWeatherIcon(weatherDataList[i]
                                                  .weather[0]
                                                  .main), // Add null check here
                                              DateFormat('EEEE').format(
                                                DateTime.now()
                                                    .add(Duration(days: i + 1)),
                                              ),
                                              weatherDataList[i]
                                                  .weather[0]
                                                  .description,
                                              '${weatherDataList[i].main.tempMax.round()}°/${weatherDataList[i].main.tempMin.round()}°',
                                            ),
                                            if (i < 4)
                                              buildDivider(), // Add divider for all except last item
                                          ],
                                        ),
                                    ],
                                  );
                                } else {
                                  // If forecast list is null or doesn't have enough data, display a message
                                  return const Text(
                                      'Not enough forecast data available');
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  String _getWeatherIcon(String? main) {
    switch (main?.toLowerCase() ?? '') {
      case 'sunny':
        return 'assets/sunny_2d.png';
      case 'snow':
        return 'assets/snow_2d.png';
      case 'rain':
        return 'assets/rainy_2d.png';
      case 'thunderstorm':
        return 'assets/thunder_2d.png';
      default:
        return 'assets/default.png'; // Fallback to a generic weather icon
    }
  }
}
