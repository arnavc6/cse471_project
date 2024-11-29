import 'package:flutter/material.dart';
import 'package:mobile_app/main.dart';
import 'package:flutter/src/material/colors.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:mobile_app/practice.dart';
import 'package:mobile_app/build_tutorial.dart';

final _auth = FirebaseAuth.instance;

class CalculusTutorial extends StatelessWidget {
  const CalculusTutorial({Key? key}) : super(key: key);
  static const String _title = 'Calculus Tutorials';

  static List<String> tutorialTitles = [
    "Derivatives",
    "Integrals",
  ];

  static List<String> tutorialText = [
    "The derivative of a constant, for example 5, is 0. The derivative of ax^n is anx^(n-1). For example, the derivative of x^2 is 2x, and the derivative of 2x is 2. The derivative of an^x is a(ln n)n^x. For example, the derivative of 2^x is ln(2) * 2^x, and the derivative of e^x is ln(e) * e^x = e^x. The derivative of log base n of x is ln(n)/x. For example, the derivative of ln(x) is 1/x. In order to find the derivative for a given value of x, plug in the value of x to the derivative. For example, the derivative of x^2 at x = 2 is 2x = 2 * 2 = 4.",
    "The integral of a constant is that constant multiplied by x. For example, the integral of 2 is 2x. The integral of ax^n is (1/a)x^(n+1). For example, the integral of 2x ix x^2.  In order to find the integral over a given interval of x, plug the upper and lower bounds of the interval into the equation and subtract the lower bound from the upper bound. For example, the integral of 2x from 1 to 2 is 2^2 - 1^2 = 3."
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
