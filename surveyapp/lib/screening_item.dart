import 'package:flutter/material.dart';
import 'screening_data.dart';

class ScreeningItem extends StatelessWidget {
  final ScreeningData item;

  const ScreeningItem({required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
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
            size: 48,
            color: Colors.white,
          ),
          SizedBox(height: 8),
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
    );
  }
}
