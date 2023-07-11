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
  
  void addNote(String note){
    notes.add(note);
  }


}

class ScreeningItemsData {
  static final Map <String, ScreeningData> data = {
    'Flu':  ScreeningData(
              icon: Icons.local_hospital,
              name: 'Flu',
              color: Colors.green,
              notes: []),

    'Heart Checkup': ScreeningData(
                      icon: Icons.favorite,
                      name: 'Heart Checkup',
                      color: Colors.red,
                      notes: [],
                    ),

    'Eye Examination': ScreeningData(
                        icon: Icons.favorite,
                        name: 'Eye Examination',
                        color: Colors.orange,
                        notes: [],
                      ),
    'Temperature Check': ScreeningData(
                          icon: Icons.thermostat_outlined,
                          name: 'Temperature Check',
                          color: Colors.yellow,
                          notes: []),
    'Blood Pressure': ScreeningData(
                        icon: Icons.reddit,
                        name: 'Blood Pressure',
                        color: Colors.red,
                        notes: []),
    'COVID-19 Test': ScreeningData(
                      icon: Icons.flutter_dash,
                      name: 'COVID-19 Test',
                      color: Colors.purple,
                      notes: []),
  };
  static List<ScreeningData?> futureItems = [];

  static List<ScreeningData?> completedItems = [];

  static void setFutureScreenings(List<ScreeningData> futureScreenings){
    clearFutureItems();

    ScreeningItemsData.futureItems = List.from(futureScreenings);
  }

  static void setCompleteScreenings(List<ScreeningData> completeScreenings){
    clearCompletedItems();

    ScreeningItemsData.completedItems = List.from(completeScreenings);
  }

  static void clearFutureItems(){
    ScreeningItemsData.futureItems = [];
  }

  static void clearCompletedItems(){
    ScreeningItemsData.completedItems = [];
  }

  static void printStuff(){
    int cnt = 1;
    for (dynamic s in completedItems){
      // print(cnt);
      print(s.name);
      print(s.notes);
      cnt++;
    }
  }

  static int completedIndexFromValue(String name){
    for (int i=0; i<completedItems.length; i++){
      if (completedItems[i]?.name == name){
        return i;
      }
    }
    return -1;
  }

  static int futureIndexFromValue(String name){
    for (int i=0; i<futureItems.length; i++){
      if (futureItems[i]?.name == name){
        return i;
      }
    }
    return -1;
  }
}
