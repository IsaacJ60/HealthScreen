import 'package:flutter/material.dart';

class InsightItem {
  final String name;
  final IconData iconData;
  final Color color;

  InsightItem({required this.name, required this.iconData, required this.color});
}

class InsightItemsData {
  static List<InsightItem> items = [
    InsightItem(
      name: 'Box 1',
      iconData: Icons.insert_chart,
      color: Colors.blue,
    ),
    InsightItem(
      name: 'Box 2',
      iconData: Icons.pie_chart,
      color: Colors.green,
    ),
    InsightItem(
      name: 'Box 3',
      iconData: Icons.bar_chart,
      color: Colors.orange,
    ),
    InsightItem(
      name: 'Box 4',
      iconData: Icons.show_chart,
      color: Colors.red,
    ),
  ];
}