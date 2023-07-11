import 'package:flutter/material.dart';
import 'insights_item.dart';

class InsightsPage extends StatelessWidget {
  static const routeName = "/insights";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Insights"),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          _buildSection("Header 1"),
          _buildBoxesRow(),
          _buildSection("Header 2"),
          _buildBoxesRow(),
          _buildSection("Header 3"),
          _buildBoxesRow(),
        ],
      ),
    );
  }

  Widget _buildSection(String headerText) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Text(
        headerText,
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildBoxesRow() {
    return Container(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: InsightItemsData.items.length,
        itemBuilder: (context, index) {
          final item = InsightItemsData.items[index];
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                color: item.color,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    item.iconData,
                    size: 48,
                    color: Colors.white,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    item.name,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
