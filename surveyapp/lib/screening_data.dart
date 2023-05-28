import 'package:flutter/material.dart';

class ScreeningItemData {
  final IconData icon;
  final String name;
  final Color color;

  ScreeningItemData({
    required this.icon,
    required this.name,
    required this.color,
  });
}

class ScreeningData {
  static final List<ScreeningItemData> futureItems = [
    ScreeningItemData(
      icon: Icons.local_hospital,
      name: 'Flu',
      color: Colors.green,
    ),
    ScreeningItemData(
      icon: Icons.favorite,
      name: 'Heart Checkup',
      color: Colors.blue,
    ),
    ScreeningItemData(
      icon: Icons.visibility,
      name: 'Eye Examination',
      color: Colors.orange,
    ),
  ];

  static final List<ScreeningItemData> completedItems = [
    ScreeningItemData(
      icon: Icons.thermostat_outlined,
      name: 'Temperature Check',
      color: Colors.yellow,
    ),
    ScreeningItemData(
      icon: Icons.reddit,
      name: 'Blood Pressure',
      color: Colors.red,
    ),
    ScreeningItemData(
      icon: Icons.flutter_dash,
      name: 'COVID-19 Test',
      color: Colors.purple,
    ),
  ];
}
