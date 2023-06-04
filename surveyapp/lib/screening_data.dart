import 'package:flutter/material.dart';

class ScreeningData {
  final IconData icon;
  final String name;
  final Color color;
  final List<String> notes;

  ScreeningData({
    required this.icon,
    required this.name,
    required this.color,
    required this.notes,
  });
}

class ScreeningItemsData {
  static final List<ScreeningData> futureItems = [
    ScreeningData(
        icon: Icons.local_hospital,
        name: 'Flu',
        color: Colors.green,
        notes: ['something 1', 'something 2', 'something 3']),
    ScreeningData(
      icon: Icons.favorite,
      name: 'Heart Checkup',
      color: Colors.red,
      notes: ['123131', '09458', '345', '345'],
    ),
    ScreeningData(
      icon: Icons.favorite,
      name: 'Eye Examination',
      color: Colors.orange,
      notes: ['damn', 'bruh', 'nonononono', 'so'],
    ),
  ];

  static final List<ScreeningData> completedItems = [
    ScreeningData(
        icon: Icons.thermostat_outlined,
        name: 'Temperature Check',
        color: Colors.yellow,
        notes: ['sdfa', 'slkdfj', 'sfdaf', 'wipowri']),
    ScreeningData(
        icon: Icons.reddit,
        name: 'Blood Pressure',
        color: Colors.red,
        notes: [
          'dlkdflkjsdfkldsdflkjkljsdffdslkj',
          'mvmbcnbmnbxczvmn',
          'dsjf'
        ]),
    ScreeningData(
        icon: Icons.flutter_dash,
        name: 'COVID-19 Test',
        color: Colors.purple,
        notes: [
          'dlkdflkjsdfkldsdflkjkljsdffdslkj',
          'mvmbcnbmnbxczvmn',
          'dsjf'
        ]),
  ];
}
