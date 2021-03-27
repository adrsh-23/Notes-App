import 'package:flutter/material.dart';
import 'package:notes_app/utils/variables.dart';

class AddNote extends StatefulWidget {
  @override
  _AddNoteState createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {
  TextEditingController title = TextEditingController();

  TextEditingController content = TextEditingController();
  saveNote() async {
    await noteCollection.add({
      'title': title.text,
      'content': content.text,
      'timeStamp': DateTime.now(),
    });
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add a note"),
        actions: [
          GestureDetector(
              onTap: () => saveNote(),
              child:
                  Padding(padding: EdgeInsets.all(5), child: Icon(Icons.save))),
        ],
      ),
      body: Container(
        child: Column(
          children: [
            Container(
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Title",
                ),
                controller: title,
              ),
            ),
            Expanded(
              child: TextField(
                maxLength: null,
                maxLines: null,
                decoration: InputDecoration(hintText: "Body"),
                controller: content,
              ),
            )
          ],
        ),
      ),
    );
  }
}
