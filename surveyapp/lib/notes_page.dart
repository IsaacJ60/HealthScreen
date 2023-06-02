import 'package:flutter/material.dart';
import 'screening_data.dart';
import 'screening_item.dart';

class NotesPage extends StatefulWidget {
  final ScreeningData item;

  NotesPage({required this.item});

  @override
  _NotesPageState createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  List<String> notes = [];
  TextEditingController _textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    notes = widget.item.notes.toList();
  }

  void addNote() {
    if (_textEditingController.text.isNotEmpty) {
      setState(() {
        notes.add(_textEditingController.text);
        _textEditingController.clear();
      });
    }
  }

  void deleteNote(int index) {
    setState(() {
      notes.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.item.name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Notes',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: notes.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(notes[index]),
                    trailing: IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () => deleteNote(index),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _textEditingController,
              decoration: InputDecoration(
                hintText: 'Enter a note',
              ),
              onSubmitted: (text) => addNote(),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: addNote,
              child: Text('Add Note'),
            ),
          ],
        ),
      ),
    );
  }
}
