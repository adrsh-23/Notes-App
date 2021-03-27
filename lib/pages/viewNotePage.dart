import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:notes_app/pages/updateNotePage.dart';

class ViewNote extends StatefulWidget {
  ViewNote({this.getNote});
  final DocumentSnapshot getNote;
  @override
  _ViewNoteState createState() => _ViewNoteState();
}

class _ViewNoteState extends State<ViewNote> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("YOLO"),
        actions: [
          GestureDetector(
            child: Icon(Icons.update),
            onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => UpdateNote(
                          note: widget.getNote,
                        ))),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.getNote['title'],
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                widget.getNote['content'],
                style: TextStyle(
                  fontSize: 30,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
