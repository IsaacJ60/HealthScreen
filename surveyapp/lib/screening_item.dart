import 'package:flutter/material.dart';
import 'screening_data.dart';
import 'notes_page.dart';
import 'database.dart';

class ScreeningItem extends StatelessWidget {
  final ScreeningData item;
  final String username;

  const ScreeningItem({required this.item, required this.username});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => NotesPage(item: item, username: username),
          ),
        );
      },
      child: Container(
        width: 200,
        height: 200,
        decoration: BoxDecoration(
          color: item.color,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              item.icon,
              size: 64,
              color: Colors.white,
            ),
            SizedBox(height: 16),
            Text(
              item.name,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
