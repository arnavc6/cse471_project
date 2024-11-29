import 'package:flutter/material.dart';

Widget buildTutorial(
    BuildContext context, String tutorialTitle, String tutorialContent) {
  return AlertDialog(
    title: Text(tutorialTitle),
    content: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(tutorialContent,
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14))
      ],
    ),
    actions: <Widget>[
      ElevatedButton(
        onPressed: () {
          Navigator.of(context).pop(false);
        },
        style:
            ElevatedButton.styleFrom(backgroundColor: Colors.indigo.shade300),
        child: const Text('Close'),
      ),
    ],
  );
}
