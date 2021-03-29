import 'package:flutter/material.dart';
import 'package:notes_app/utils/variables.dart';

class AddNote extends StatefulWidget {
  @override
  _AddNoteState createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {
  TextEditingController title = TextEditingController();

  TextEditingController content = TextEditingController();
  final snackBar = SnackBar(
    content: Text('Please add a title'),
    action: SnackBarAction(
      label: 'Ok',
      onPressed: () {
        // Some code to undo the change.
      },
    ),
  );
  saveNote() async {
    print(title.text);
    if (title.text == "") {
      setState(() {
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      });
    } else {
      await noteCollection.add({
        'title': title.text,
        'content': content.text,
        'timeStamp': DateTime.now(),
      });
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add a note"),
        actions: [
          GestureDetector(
            child: Center(
              child: Icon(Icons.send_sharp),
            ),
            onTap: () => saveNote(),
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
