import 'package:flutter/material.dart';
import 'package:mobile_app/main.dart';
import 'package:flutter/src/material/colors.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:mobile_app/tutorials.dart';
import 'package:mobile_app/practice_arithmetic.dart';
import 'package:mobile_app/practice_algebra.dart';
import 'package:mobile_app/practice_geometry.dart';
import 'package:mobile_app/practice_calculus.dart';

final _auth = FirebaseAuth.instance;

class Practice extends StatelessWidget {
  const Practice({Key? key}) : super(key: key);
  static const String _title = 'Practice';

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
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.indigo.shade300),
                        child: Text('Arithmetic',
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 12)),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const ArithmeticPractice()),
                          );
                        },
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.indigo.shade300),
                        child: Text('Algebra',
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 12)),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const AlgebraPractice()),
                          );
                        },
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.indigo.shade300),
                        child: Text('Geometry',
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 12)),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const GeometryPractice()),
                          );
                        },
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.indigo.shade300),
                        child: Text('Calculus',
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 12)),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const CalculusPractice()),
                          );
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
