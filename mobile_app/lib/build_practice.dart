import 'package:flutter/material.dart';
import 'package:mobile_app/build_result.dart';

Widget buildPractice(BuildContext context, String practiceTitle,
    String practiceQuestion, num practiceAnswer) {
  TextEditingController answerController = TextEditingController();
  return AlertDialog(
    title: Text(practiceTitle),
    content: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(practiceQuestion,
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14))
      ],
    ),
    actions: <Widget>[
      TextField(
        controller: answerController,
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'Your Answer',
        ),
      ),
      ElevatedButton(
        onPressed: () {
          String answerText = answerController.text;
          if (answerText.isEmpty) {
            showDialog(
                context: context,
                builder: (BuildContext context) => buildResult(context,
                    "Please enter an answer prior to submission", false));
          }
          try {
            num answer = num.parse(answerText);
            if (answer == practiceAnswer) {
              showDialog(
                  context: context,
                  builder: (BuildContext context) =>
                      buildResult(context, "Correct! :)", true));
            } else {
              showDialog(
                  context: context,
                  builder: (BuildContext context) =>
                      buildResult(context, "Incorrect :(", false));
            }
          } catch (e) {
            showDialog(
                context: context,
                builder: (BuildContext context) => buildResult(
                    context, "Please enter a numerical value", false));
          }
        },
        style:
            ElevatedButton.styleFrom(backgroundColor: Colors.indigo.shade300),
        child: const Text('Submit Answer'),
      ),
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
