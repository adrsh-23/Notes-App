import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:notes_app/functions/textFieldFunctions.dart';

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
      Navigator.popAndPushNamed(context, "homePage");
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
              buildTitle(title),
              buildContent(content),
            ],
          ),
        ),
      ),
    );
  }
}
