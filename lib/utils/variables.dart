import 'package:cloud_firestore/cloud_firestore.dart';

CollectionReference noteCollection =
    FirebaseFirestore.instance.collection("notes");
