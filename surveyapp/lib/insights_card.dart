import 'package:flutter/material.dart';

class InsightsCard extends StatefulWidget {
  final String title;
  final List<String> articleText;
  final List<String> gifPaths;

  const InsightsCard({
    Key? key,
    required this.title,
    required this.articleText,
    required this.gifPaths,
  }) : super(key: key);

  @override
  _InsightsCardState createState() => _InsightsCardState();
}

class _InsightsCardState extends State<InsightsCard> {
  int currentIndex = 0;

  void _showNextArticle() {
    if (currentIndex < widget.articleText.length - 1) {
      setState(() {
        currentIndex++;
      });
    }
  }

  void _showPreviousArticle() {
    if (currentIndex > 0) {
      setState(() {
        currentIndex--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double progress = (currentIndex) / widget.articleText.length;

    return GestureDetector(
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          backgroundColor: Colors.blue,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(100.0),
              child: Text(
                widget.articleText[currentIndex],
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Center(
              child: Image.asset(
                widget.gifPaths[currentIndex],
                height: 200,
                width: 200,
                // fit: BoxFit.contain,
              ),
            ),
            SizedBox(height: 16.0),
            SizedBox(height: 16.0),
            LinearProgressIndicator(
              value: progress,
              minHeight: 10,
              backgroundColor: Colors.grey,
              valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
            ),
            SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: _showPreviousArticle,
                  child: Text('Previous'),
                ),
                SizedBox(width: 16.0),
                ElevatedButton(
                  onPressed: _showNextArticle,
                  child: Text('Next'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
