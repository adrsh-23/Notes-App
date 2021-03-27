import 'package:flutter/material.dart';
import 'package:notes_app/pages/addNotePage.dart';
import 'package:notes_app/pages/notesListPage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:notes_app/pages/viewNotePage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
    theme: ThemeData.dark(),
    routes: {
      'homePage': (context) => NotesList(),
      'addNotePage': (context) => AddNote(),
      'viewPage': (context) => ViewNote(),
    },
    initialRoute: 'homePage',
    debugShowCheckedModeBanner: false,
  ));
}
