import 'package:flutter/material.dart';
import 'screening_data.dart';
import 'screening_item.dart';

class DashboardUI extends StatefulWidget {
  static const routeName = "/dash";

  const DashboardUI({super.key, required this.username});

  final String username;

  @override
  _DashboardUIState createState() => _DashboardUIState();
}

class _DashboardUIState extends State<DashboardUI> {
  late String username;
  int _currentIndex = 0;
  @override
  void initState() {
    super.initState();
    username = widget.username;
  }

  void _onTabSelected(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(username),
        ),
        leading: const Icon(Icons.account_circle_rounded),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 16),
            const Text(
              'Future Screening',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Container(
              height: 200,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: ScreeningItemsData.futureItems.length,
                itemBuilder: (context, index) {
                  final item = ScreeningItemsData.futureItems[index];
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ScreeningItem(item: item),
                  );
                },
              ),
            ),
            const SizedBox(height: 32),
            const Text(
              'Completed Screening',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: ScreeningItemsData.completedItems.length,
              itemBuilder: (context, index) {
                final item = ScreeningItemsData.completedItems[index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ScreeningItem(item: item),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
