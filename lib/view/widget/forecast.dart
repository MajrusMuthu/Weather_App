import 'package:flutter/material.dart';

Widget buildWeatherInfo(String imagePath, String day, String condition, String temperature) {
  return Column(
    children: [
      Row(
        children: [
          Image.asset(
            imagePath,
            height: 30,
            width: 30,
          ),
          const SizedBox(
            width: 10,
          ),
          Text(
            day,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            width: 20,
          ),
          Text(
            condition,
            style: const TextStyle(
              color: Color.fromARGB(255, 204, 202, 202),
              fontSize: 15,
            ),
          ),
         const Spacer(),
          Text(
            temperature,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
      const SizedBox(height: 10),
    ],
  );
}

Widget buildDivider() {
  return const Column(
    children: [
      Divider(
        thickness: 2,
        color: Colors.grey,
      ),
      SizedBox(
        height: 10,
      ),
    ],
  );
}



