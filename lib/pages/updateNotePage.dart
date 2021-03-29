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

  final snackBar = SnackBar(
    content: Text('Please add a title'),
    action: SnackBarAction(
      label: 'Ok',
      onPressed: () {
        // Some code to undo the change.
      },
    ),
  );
  updateNoteFile() async {
    if (title.text == "") {
      setState(() {
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      });
    } else {
      await widget.note.reference.update({
        'title': title.text,
        'content': content.text,
        'timeStamp': DateTime.now()
      });
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          GestureDetector(
            child: Center(
              child: Icon(Icons.send_sharp),
            ),
            onTap: () => updateNoteFile(),
          ),
          const SizedBox(
            width: 20,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  child: TextField(
                    maxLength: 50,
                    decoration: InputDecoration(
                      hintText: "Title",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(1)),
                    ),
                    controller: title,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Expanded(
                  child: TextField(
                    maxLength: null,
                    maxLines: 23,
                    decoration: InputDecoration(
                      hintText: "Body",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(1)),
                    ),
                    controller: content,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
