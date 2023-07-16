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

  void addNote(String note) {
    notes.add(note);
  }
}

class ScreeningItemsData {
  static final Map<String, ScreeningData> data = {
    'Chlamydia Trachomatis (Every 1 year)': ScreeningData(
        icon: Icons.local_hospital,
        name: 'Chlamydia Trachomatis (Every 1 year)',
        color: Colors.green,
        notes: []),
    'Neisseria Gonorrhoeae (Every 1 year)': ScreeningData(
      icon: Icons.favorite,
      name: 'Neisseria Gonorrhoeae (Every 1 year)',
      color: Colors.red,
      notes: [],
    ),
    'Self breast exams (Every 1 month)': ScreeningData(
      icon: Icons.favorite,
      name: 'Self breast exams (Every 1 month)',
      color: Colors.orange,
      notes: [],
    ),
    'Papanicolaou test with cytology (Every 3 years)': ScreeningData(
        icon: Icons.thermostat_outlined,
        name: 'Papanicolaou test with cytology (Every 3 years)',
        color: Colors.yellow,
        notes: []),
    'Papanicolaou test high risk testing with cytology (Every 5 years)': ScreeningData(
        icon: Icons.reddit,
        name: 'Papanicolaou test high risk testing with cytology (Every 5 years)',
        color: Colors.red,
        notes: []),
    'Dexa scan (Every 2 years)': ScreeningData(
        icon: Icons.flutter_dash,
        name: 'Dexa scan (Every 2 years)',
        color: Colors.purple,
        notes: []),
    "Colonoscopy (Every 5 years)": ScreeningData(
        icon: Icons.flutter_dash,
        name: "Colonoscopy (Every 5 years)",
        color: Colors.purple,
        notes: []),
    "Colonoscopy (Every 10 years)": ScreeningData(
        icon: Icons.flutter_dash,
        name: "Colonoscopy (Every 10 years)",
        color: Colors.purple,
        notes: []),
    "FOBT (Every 1 years)": ScreeningData(
        icon: Icons.flutter_dash,
        name: "FOBT (Every 1 years)",
        color: Colors.purple,
        notes: []),
    "FIT-DNA (Every 3 years)": ScreeningData(
        icon: Icons.flutter_dash,
        name: "FIT-DNA (Every 3 years)",
        color: Colors.purple,
        notes: []),
    "Flexible sigmoidoscopy (Every 5 years)": ScreeningData(
        icon: Icons.flutter_dash,
        name: "Flexible sigmoidoscopy (Every 5 years)",
        color: Colors.purple,
        notes: [])
  };
  static List<ScreeningData?> futureItems = [];

  static List<ScreeningData?> completedItems = [];

  static void setFutureScreenings(List<ScreeningData> futureScreenings) {
    clearFutureItems();

    ScreeningItemsData.futureItems = List.from(futureScreenings);
  }

  static void setCompleteScreenings(List<ScreeningData> completeScreenings) {
    clearCompletedItems();

    ScreeningItemsData.completedItems = List.from(completeScreenings);
  }

  static void clearFutureItems() {
    ScreeningItemsData.futureItems = [];
  }

  static void clearCompletedItems() {
    ScreeningItemsData.completedItems = [];
  }

  static void printStuff() {
    int cnt = 1;
    for (dynamic s in completedItems) {
      // print(cnt);
      print(s.name);
      print(s.notes);
      cnt++;
    }
  }

  static int completedIndexFromValue(String name) {
    for (int i = 0; i < completedItems.length; i++) {
      if (completedItems[i]?.name == name) {
        return i;
      }
    }
    return -1;
  }

  static int futureIndexFromValue(String name) {
    for (int i = 0; i < futureItems.length; i++) {
      if (futureItems[i]?.name == name) {
        return i;
      }
    }
    return -1;
  }
}
