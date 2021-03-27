import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:notes_app/pages/viewNotePage.dart';
import 'package:notes_app/utils/variables.dart';
import 'package:timeago/timeago.dart' as tAgo;

class NotesList extends StatefulWidget {
  @override
  _NotesListState createState() => _NotesListState();
}

class _NotesListState extends State<NotesList> {
  @override
  void initState() {
    super.initState();
    noteCollection.orderBy("timeStamp", descending: false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Notes"),
        actions: [
          Icon(Icons.search),
        ],
      ),
      body: StreamBuilder(
        stream: noteCollection.snapshots(),
        builder: (_, snapshot) {
          return GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
            ),
            itemCount: snapshot.data.docs.length,
            itemBuilder: (_, index) {
              if (!snapshot.hasData) {
                return CircularProgressIndicator();
              }
              return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                ViewNote(getNote: snapshot.data.docs[index]))),
                    child: Container(
                      height: 10,
                      width: 10,
                      decoration: BoxDecoration(color: Colors.grey),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              snapshot.data.docs[index]['title'],
                              style: TextStyle(
                                  fontSize: 30, fontWeight: FontWeight.bold),
                            ),
                            Center(
                                child: Text(
                              snapshot.data.docs[index]['content'],
                            )),
                            Text(
                              tAgo
                                  .format(snapshot.data.docs[index]['timeStamp']
                                      .toDate())
                                  .toString(),
                              style: TextStyle(color: Colors.black),
                            ),
                          ]),
                    ),
                  ));
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => Navigator.pushNamed(context, "addNotePage"),
      ),
    );
  }
}
