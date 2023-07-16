import 'package:flutter/material.dart';
import 'insights_item.dart';
import 'insights_card.dart';

//import 'package:universal_html/html.dart' as html;

class InsightItem {
  final String name;
  final String imagePath;
  final int headerID;
  final List<String> articleTexts;
  final List<String> gifPaths;
  // final List<InsightsCard> cardPages;
  // each box should have a list of gif paths and a txt.file
  //read txt.file and create a article text list
  // txt.file should

  InsightItem({
    required this.name,
    required this.imagePath,
    required this.headerID,
    required this.articleTexts,
    required this.gifPaths,
  });
}

class InsightItemsData {
  static List<InsightItem> items = [
    InsightItem(
      name: 'Case study in alabama',
      imagePath: 'assets/boxCover.jpg',
      headerID: 1,
      articleTexts: ['djslkfjdlfjlkjsklfjf', 'jdfhskjfhkjh'],
      gifPaths: ["download.gif", "assets/piku.gif"],
    ),
    InsightItem(
      name: 'Case study in mexico',
      imagePath: 'assets/boxCover2.jpeg',
      headerID: 2,
      articleTexts: ['djslkfjdlfjlkjsklfjf', 'jdfhskjfhkjh'],
      gifPaths: ["assets/rdownload.gif", "assets/piku.gif"],
    ),
    InsightItem(
      name: 'hmmm',
      imagePath: 'assets/boxCover3.jpeg',
      headerID: 3,
      articleTexts: ['djslkfjdlfjlkjsklfjf', 'jdfhskjfhkjh'],
      gifPaths: ["assets/download.gif", "assets/piku.gif"],
    ),
    InsightItem(
      name: 'bruh',
      imagePath: 'assets/boxCover3.jpeg',
      headerID: 3,
      articleTexts: ['djslkfjdlfjlkjsklfjf', 'jdfhskjfhkjh'],
      gifPaths: ["assets/download.gif", "assets/piku.gif"],
    )
  ];
  /*
  static void loadArticleText() {
    for (var item in items) {
      String filePath = 'txt_files/article.txt';

      html.HttpRequest.request(filePath).then((request) {
        var response = request.response;
        if (response is html.Blob) {
          final reader = html.FileReader();
          reader.readAsText(response);
          reader.onLoadEnd.listen((event) {
            item.articleText = reader.result.toString();
          });
        } else {
          print('Invalid response type');
        }
      }).catchError((error) {
        print('Error loading text: $error');
      });
    }
  }
  */
}
