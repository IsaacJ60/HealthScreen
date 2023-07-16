import 'package:flutter/material.dart';
import 'insights_item.dart';
import 'insights_card.dart';

class InsightsPage extends StatelessWidget {
  static const routeName = "/insights";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Insights"),
        backgroundColor: Colors.blue,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          _buildSection("Screenings are cool!"),
          _buildBoxesRow(1),
          _buildSection("Do your screenings"),
          _buildBoxesRow(1),
          _buildSection("Screenings"),
          _buildBoxesRow(2),
          _buildSection("Screen"),
          _buildBoxesRow(3),
        ],
      ),
    );
  }

  Widget _buildSection(String headerText) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        headerText,
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildBoxesRow(int id) {
    final filteredItems =
        InsightItemsData.items.where((item) => item.headerID == id).toList();

    return Container(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: filteredItems.length,
        itemBuilder: (context, index) {
          final item = filteredItems[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => InsightsCard(
                    title: item.name,
                    articleText: item.articleTexts,
                    gifPaths: item.gifPaths,
                  ),
                ),
              );
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: 200,
                height: 150,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image(
                      image: AssetImage(item.imagePath),
                      fit: BoxFit.fill,
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
            ),
          );
        },
      ),
    );
  }
}
