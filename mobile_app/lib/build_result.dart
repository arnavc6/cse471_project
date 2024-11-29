import 'package:flutter/material.dart';

Widget buildResult(BuildContext context, String result, bool correct) {
  return AlertDialog(
    title: Text(result),
    actions: <Widget>[
      ElevatedButton(
        onPressed: () {
          Navigator.of(context).pop();
          if (correct) {
            Navigator.of(context).pop(true);
          }
        },
        style:
            ElevatedButton.styleFrom(backgroundColor: Colors.indigo.shade300),
        child: const Text('Close'),
      ),
    ],
  );
}
