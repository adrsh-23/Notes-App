import 'package:flutter/material.dart';

InputDecoration buildInputDecoration(String input) {
  return InputDecoration(
      floatingLabelBehavior: FloatingLabelBehavior.never,
      hintText: input,
      enabledBorder:
          OutlineInputBorder(borderSide: BorderSide(style: BorderStyle.none)),
      focusedBorder:
          OutlineInputBorder(borderSide: BorderSide(style: BorderStyle.none)));
}

Padding buildTitle(TextEditingController title) {
  return Padding(
    padding: const EdgeInsets.all(5.0),
    child: Container(
      child: TextField(
        style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        decoration: buildInputDecoration("Title"),
        controller: title,
      ),
    ),
  );
}

Padding buildContent(TextEditingController content) {
  return Padding(
    padding: const EdgeInsets.all(5.0),
    child: Expanded(
      child: TextField(
        maxLength: null,
        maxLines: 23,
        style: TextStyle(fontSize: 20),
        decoration: buildInputDecoration("Body"),
        controller: content,
      ),
    ),
  );
}
