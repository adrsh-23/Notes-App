import 'dart:math';
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

  searchNote() {
    print(search.text);
    setState(() {
      isSearching = false;
    });
  }

  TextEditingController search = TextEditingController();
  bool isSearching = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: !isSearching
            ? Text("Notes")
            : TextField(
                textInputAction: TextInputAction.search,
                decoration: InputDecoration(hintText: "Search for a note"),
                controller: search,
                onSubmitted: (value) => {
                      searchNote(),
                    }),
        actions: [
          GestureDetector(
            child: Icon(!isSearching ? Icons.search : Icons.cancel),
            onTap: () {
              setState(() {
                isSearching = !isSearching;
                search.clear();
              });
            },
          ),
          const SizedBox(
            width: 20,
          ),
        ],
      ),
      body: StreamBuilder(
        stream: search.text != ""
            ? noteCollection
                .orderBy('timeStamp', descending: true)
                .where('title', isGreaterThanOrEqualTo: search.text)
                .snapshots()
            : noteCollection.orderBy('timeStamp', descending: true).snapshots(),
        builder: (_, snapshot) {
          return GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
            ),
            itemCount: snapshot.data.docs.length,
            itemBuilder: (context, index) {
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
                      decoration: BoxDecoration(
                        color: Colors.primaries[
                            Random().nextInt(Colors.primaries.length)],
                      ),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 10,
                            ),
                            Center(
                              child: Text(
                                snapshot.data.docs[index]['title'],
                                style: TextStyle(
                                    fontSize: 30, fontWeight: FontWeight.bold),
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                height: 85,
                                child: Text(
                                  snapshot.data.docs[index]['content'],
                                  maxLines: 6,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Text(
                                tAgo
                                    .format(snapshot
                                        .data.docs[index]['timeStamp']
                                        .toDate())
                                    .toString(),
                                style: TextStyle(color: Colors.black),
                              ),
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
