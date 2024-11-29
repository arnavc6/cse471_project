import 'package:flutter/material.dart';
import 'package:mobile_app/main.dart';
import 'package:flutter/src/material/colors.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:mobile_app/practice.dart';
import 'package:mobile_app/build_tutorial.dart';

final _auth = FirebaseAuth.instance;

class AlgebraTutorial extends StatelessWidget {
  const AlgebraTutorial({Key? key}) : super(key: key);
  static const String _title = 'Algebra Tutorials';

  static List<String> tutorialTitles = [
    "Evaluating Expressions",
    "Solving Linear Equations",
    "Solving Quadratic Equations",
  ];

  static List<String> tutorialText = [
    "In order to evaluate an expression, plug the value of the given variable into the expression and compute its result. For example, if evaluating the expression x + 2 given x = 3, plug in 3 for x, giving us 3 + 2 = 5",
    "In order to solve a linear equation, apply operations to both sides of the equation in reverse PEMDAS order until you have the answer. For example, if given 2 * (x + 3) = 4x, first divide both sides by 2 to get x + 3 = 2x. Then subtract x from both sides to get 3 = x, which by symmetric property means x = 3.",
    "In order to solve a quadratic equation of form ax^2 + bx + c = 0, use the formula x = (-b +/- √(b^2 - 4ac))/2a. For example, given x^2 - 2x + 1 = 0, plug a = 1, b = -2, and c = 1 into the equation to get (-(-2) +/- √(2^2 - 4 * 1 * 1))/(2 * 1) = (2 +/- 0)/2 = 2/2 = 1.",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text(_title)),
        body: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("lib/assets/mountain.jpg"),
                fit: BoxFit.cover,
              ),
            ),
            child: Center(
                child: Padding(
              padding: const EdgeInsets.only(top: 30.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  SizedBox(height: 10),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      for (int i = 0; i < tutorialTitles.length; i++)
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.indigo.shade300),
                          child: Text(tutorialTitles[i],
                              style: TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 12)),
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) =>
                                    buildTutorial(context, tutorialTitles[i],
                                        tutorialText[i]));
                          },
                        ),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.indigo.shade300),
                          child: Text("Go back",
                              style: TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 12)),
                          onPressed: () {
                            Navigator.of(context).pop();
                          }),
                      Container(
                        height: 50,
                        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                        child: ElevatedButton(
                          child: const Text('Log Out'),
                          onPressed: () async {
                            try {
                              await _auth.signOut();
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const MyApp()),
                              );
                            } catch (e) {
                              print(e);
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                    content: Text(
                                        'An error occurred. Please try again.')),
                              );
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ))));
  }
}
