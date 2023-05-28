import 'package:flutter/material.dart';
import 'screening_data.dart';
import 'screening_item.dart';

class DashboardUI extends StatefulWidget {
  static const routeName = "/dash"; 

  const DashboardUI(
    {
      super.key, 
      required this.username
    }
  );

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
        leading: Icon(Icons.account_circle_rounded),
        title: Center(
          child: Text(username),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 24),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Future Screenings',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(height: 24),
          Container(
            height: 200,
            child: ListView.separated(
              padding: EdgeInsets.symmetric(horizontal: 16),
              scrollDirection: Axis.horizontal,
              itemCount: ScreeningData.futureItems.length,
              separatorBuilder: (context, _) => SizedBox(width: 12),
              itemBuilder: (context, index) =>
                  ScreeningItem(item: ScreeningData.futureItems[index]),
            ),
          ),
          SizedBox(height: 24),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Completed Screenings',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(height: 12),
          Expanded(
  child: Container(
    padding: EdgeInsets.symmetric(horizontal: 16),
    child: SingleChildScrollView(
      child: Column(
        children: [
          ListView.separated(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: ScreeningData.completedItems.length,
            separatorBuilder: (context, _) => SizedBox(height: 12),
            itemBuilder: (context, index) =>
                ScreeningItem(item: ScreeningData.completedItems[index]),
          ),
        ],
      ),
    ),
  ),
),
        ],
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
            icon: Icon(Icons.insert_chart),
            label: 'Insights',
          ),
        ],
      ),
    );
  }
}
