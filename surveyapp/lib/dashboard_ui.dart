import 'package:flutter/material.dart';
import 'package:surveyapp/profile_page.dart';
import 'screening_data.dart';
import 'screening_item.dart';
import 'database.dart';
import 'insights_page.dart';

class DashboardUI extends StatefulWidget {
  static const routeName = "/dash";

  const DashboardUI({Key? key, required this.username}) : super(key: key);

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
    if (index == 1) {
      Navigator.push(context, MaterialPageRoute(builder: (context) {
      return InsightsPage();
    }));
    } else {
      setState(() {
        _currentIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(username),
        ),
        leading: IconButton(
          icon: Icon(Icons.account_circle_rounded),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return ProfilePage(username: username);
            }));
          },
        ),
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 16),
            const Text(
              'Recommended/Future Screening',
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
                    child: ScreeningItem(item: item!, username: username),
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
                  child: ScreeningItem(item: item!, username: username),
                );
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onTabSelected,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart),
            label: 'Insights',
          ),
        ],
      ),
    );
  }
}
