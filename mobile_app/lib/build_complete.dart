import 'package:flutter/material.dart';

Widget buildComplete(BuildContext context, String section) {
  return AlertDialog(
    title:
        Text("You've completed all questions in the section $section. Reset?"),
    actions: <Widget>[
      ElevatedButton(
        onPressed: () {
          Navigator.of(context).pop(false);
        },
        style:
            ElevatedButton.styleFrom(backgroundColor: Colors.indigo.shade300),
        child: const Text('Close'),
      ),
      ElevatedButton(
        onPressed: () {
          Navigator.of(context).pop(true);
        },
        style:
            ElevatedButton.styleFrom(backgroundColor: Colors.indigo.shade300),
        child: const Text('Reset'),
      ),
    ],
  );
}
