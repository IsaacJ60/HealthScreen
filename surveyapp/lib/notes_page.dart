import 'package:flutter/material.dart';
import 'screening_data.dart';
import 'database.dart';

class NotesPage extends StatefulWidget {
  final ScreeningData item;

  NotesPage({required this.item, required this.username});

  final String username;

  @override
  _NotesPageState createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  List<String> notes = [];
  late ScreeningData item;
  late String username;

  TextEditingController _textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    item = widget.item;
    notes = widget.item.notes.toList();
    username = widget.username;
  }

  void addNote() {
    if (_textEditingController.text.isNotEmpty) {
      print(item.name);
      print(username + ' ' + item.name + ' ' + _textEditingController.text);
      Database.addNotes(username, item.name, _textEditingController.text);
      setState(() {
        notes.add(_textEditingController.text);
        _textEditingController.clear();
      });
    }
  }

  void deleteNote(int index) {
    print(item.name);
    print(notes[index]);

    Database.deleteNote(username, item.name, notes[index]);
    setState(() {
      notes.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.item.name),
        backgroundColor: widget.item.color,
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
