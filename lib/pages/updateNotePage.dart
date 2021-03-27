import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UpdateNote extends StatefulWidget {
  final DocumentSnapshot note;
  UpdateNote({this.note});
  @override
  _UpdateNoteState createState() => _UpdateNoteState();
}

class _UpdateNoteState extends State<UpdateNote> {
  TextEditingController title = TextEditingController();
  TextEditingController content = TextEditingController();
  @override
  void initState() {
    super.initState();
    title = TextEditingController(text: widget.note['title']);
    content = TextEditingController(text: widget.note['content']);
  }

  updateNoteFile() {
    widget.note.reference.update({
      'title': title.text,
      'content': content.text,
      'timeStamp': DateTime.now()
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          GestureDetector(
            child: Text("Save"),
            onTap: () => updateNoteFile(),
          )
        ],
      ),
      body: Container(
        child: Column(
          children: [
            TextField(
              controller: title,
            ),
            Expanded(
              child: TextField(
                controller: content,
              ),
            )
          ],
        ),
      ),
    );
  }
}
