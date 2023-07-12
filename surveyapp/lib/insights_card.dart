import 'package:flutter/material.dart';
import 'insights_item.dart';

class InsightsCard extends StatelessWidget {
  final InsightItem insightItem;

  const InsightsCard({
    Key? key,
    required this.insightItem,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(insightItem.name),
        backgroundColor: Colors.blue,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(100.0),
            child: Text(
              insightItem.articleText,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Center(
            child: Image.asset(
              insightItem.gifPaths[0],
              height: 200,
              width: 200,
              // fit: BoxFit.contain,
            ),
          ),
          SizedBox(height: 16.0),
        ],
      ),
    );
  }
}
