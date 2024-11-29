import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mobile_app/main.dart';
import 'package:flutter/src/material/colors.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:mobile_app/practice.dart';
import 'package:mobile_app/build_practice.dart';
import 'package:mobile_app/build_complete.dart';

final _auth = FirebaseAuth.instance;

class QuestionPair {
  String question;
  num answer;
  QuestionPair(this.question, this.answer);
}

class GeometryPractice extends StatelessWidget {
  const GeometryPractice({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const MyStatefulWidget(),
      backgroundColor: Colors.lightGreen[100],
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({super.key});

  @override
  State<MyStatefulWidget> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyStatefulWidget> {
  static const String _title = 'Geometry Practice';

  static List<QuestionPair> polygonsQuestions = [
    QuestionPair(
        "Find the perimeter of a polygon with side lengths 1, 2, and 3", 6),
    QuestionPair("Find the area of a triangle with base 5 and height 4", 10),
    QuestionPair(
        "Find the area of a quadrilateral with base 2 and height 3", 6),
    QuestionPair(
        "Find the perimeter of a triangle where all side lengths are 4", 12),
    QuestionPair(
        "Find the perimeter of a quadrilateral where all side lengths are 2",
        8),
  ];

  static List<QuestionPair> polyhedraQuestions = [
    QuestionPair("Find the surface area of a cube with side length 1", 6),
    QuestionPair(
        "Find the surface area of a rectangular prism of length 1, width 2, and height 3",
        22),
    QuestionPair("Find the volume of a cube given side length 2", 8),
    QuestionPair(
        "Find the volume of a triangular prism given length 3, width 2, and height 1",
        2),
    QuestionPair(
        "Find the volume of a rectangular prism given length 3, width 4, and height 5",
        60),
  ];

  static List<QuestionPair> trigonometryQuestions = [
    QuestionPair(
        "The side opposite a 30º angle is 1 and the hypotenuse is 2, calculate sin(30)",
        0.5),
    QuestionPair(
        "The side adjacent to a 60º angle is 1 and the hypotenuse is 2, calculate cos(60)",
        0.5),
    QuestionPair(
        "The sides opposite and adjacent to a 45º angle are both 1, calculate tan(45)",
        1),
    QuestionPair(
        "The opposite side and hypotenuse of a 90º angle are the same, calculate sin(90)",
        1),
    QuestionPair(
        "The adjacent side and hypotenuse of a 0º angle are the same, calculate cos(0)",
        1),
  ];

  int additionIndex = 0;
  int subtractionIndex = 0;
  int multiplicationIndex = 0;
  int divisionIndex = 0;
  int exponentsIndex = 0;
  int pemdasIndex = 0;
  int expressionsIndex = 0;
  int linearIndex = 0;
  int quadraticIndex = 0;
  int polygonsIndex = 0;
  int polyhedraIndex = 0;
  int trigonometryIndex = 0;
  int derivativesIndex = 0;
  int integralsIndex = 0;

  @override
  Widget build(BuildContext context) {
    load() async {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(_auth.currentUser!.email)
          .get()
          .then((snapshot) {
        Map<String, dynamic>? userStats = snapshot.data();
        Map<String, dynamic>? arithmeticStats = userStats?["arithmetic"];
        additionIndex = arithmeticStats?["addition"] as int;
        subtractionIndex = arithmeticStats?["subtraction"] as int;
        multiplicationIndex = arithmeticStats?["multiplication"] as int;
        divisionIndex = arithmeticStats?["division"] as int;
        exponentsIndex = arithmeticStats?["exponents"] as int;
        pemdasIndex = arithmeticStats?["pemdas"] as int;
        Map<String, dynamic>? algebraStats = userStats?["algebra"];
        expressionsIndex = algebraStats?["expressions"] as int;
        linearIndex = algebraStats?["linear"] as int;
        quadraticIndex = algebraStats?["quadratic"] as int;
        Map<String, dynamic>? geometryStats = userStats?["geometry"];
        polygonsIndex = geometryStats?["polygons"] as int;
        polyhedraIndex = geometryStats?["polyhedra"] as int;
        trigonometryIndex = geometryStats?["trigonometry"] as int;
        Map<String, dynamic>? calculusStats = userStats?["calculus"];
        derivativesIndex = calculusStats?["derivatives"] as int;
        integralsIndex = calculusStats?["integrals"] as int;
      });
    }

    load();

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
                      Text(
                          "Stats: \nPolygons: $polygonsIndex of ${polygonsQuestions.length} \nPolyhedra: $polyhedraIndex of ${polyhedraQuestions.length} \nTrigonometry: $trigonometryIndex of ${trigonometryQuestions.length}"),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.indigo.shade300),
                          child: Text('Load Progress',
                              style: TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 12)),
                          onPressed: () {
                            setState(() {});
                          }),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.indigo.shade300),
                        child: Text('Polygons',
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 12)),
                        onPressed: () {
                          if (polygonsIndex < polygonsQuestions.length) {
                            QuestionPair qp = polygonsQuestions[polygonsIndex];
                            showDialog(
                                context: context,
                                builder: (BuildContext context) =>
                                    buildPractice(
                                        context,
                                        "Polygons",
                                        qp.question,
                                        qp.answer)).then((correct) {
                              if (correct) {
                                polygonsIndex++;
                                FirebaseFirestore.instance
                                    .collection('users')
                                    .doc(_auth.currentUser!.email)
                                    .set({
                                  'arithmetic': {
                                    'addition': additionIndex,
                                    'subtraction': subtractionIndex,
                                    'multiplication': multiplicationIndex,
                                    'division': divisionIndex,
                                    'exponents': exponentsIndex,
                                    'pemdas': pemdasIndex,
                                  },
                                  'algebra': {
                                    'expressions': expressionsIndex,
                                    'linear': linearIndex,
                                    'quadratic': quadraticIndex,
                                  },
                                  'geometry': {
                                    'polygons': polygonsIndex,
                                    'polyhedra': polyhedraIndex,
                                    'trigonometry': trigonometryIndex,
                                  },
                                  'calculus': {
                                    'derivatives': derivativesIndex,
                                    'integrals': integralsIndex,
                                  }
                                });
                              }
                              setState(() {});
                            });
                          } else {
                            showDialog(
                                    context: context,
                                    builder: (BuildContext context) =>
                                        buildComplete(context, "Polygons"))
                                .then((reset) {
                              if (reset) {
                                polygonsIndex = 0;
                                FirebaseFirestore.instance
                                    .collection('users')
                                    .doc(_auth.currentUser!.email)
                                    .set({
                                  'arithmetic': {
                                    'addition': additionIndex,
                                    'subtraction': subtractionIndex,
                                    'multiplication': multiplicationIndex,
                                    'division': divisionIndex,
                                    'exponents': exponentsIndex,
                                    'pemdas': pemdasIndex,
                                  },
                                  'algebra': {
                                    'expressions': expressionsIndex,
                                    'linear': linearIndex,
                                    'quadratic': quadraticIndex,
                                  },
                                  'geometry': {
                                    'polygons': polygonsIndex,
                                    'polyhedra': polyhedraIndex,
                                    'trigonometry': trigonometryIndex,
                                  },
                                  'calculus': {
                                    'derivatives': derivativesIndex,
                                    'integrals': integralsIndex,
                                  }
                                });
                                setState(() {});
                              }
                            });
                          }
                        },
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.indigo.shade300),
                        child: Text('Polyhedra',
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 12)),
                        onPressed: () {
                          if (polyhedraIndex < polyhedraQuestions.length) {
                            QuestionPair qp =
                                polyhedraQuestions[polyhedraIndex];
                            showDialog(
                                context: context,
                                builder: (BuildContext context) =>
                                    buildPractice(
                                        context,
                                        "Polyhedra",
                                        qp.question,
                                        qp.answer)).then((correct) {
                              if (correct) {
                                polyhedraIndex++;
                                FirebaseFirestore.instance
                                    .collection('users')
                                    .doc(_auth.currentUser!.email)
                                    .set({
                                  'arithmetic': {
                                    'addition': additionIndex,
                                    'subtraction': subtractionIndex,
                                    'multiplication': multiplicationIndex,
                                    'division': divisionIndex,
                                    'exponents': exponentsIndex,
                                    'pemdas': pemdasIndex,
                                  },
                                  'algebra': {
                                    'expressions': expressionsIndex,
                                    'linear': linearIndex,
                                    'quadratic': quadraticIndex,
                                  },
                                  'geometry': {
                                    'polygons': polygonsIndex,
                                    'polyhedra': polyhedraIndex,
                                    'trigonometry': trigonometryIndex,
                                  },
                                  'calculus': {
                                    'derivatives': derivativesIndex,
                                    'integrals': integralsIndex,
                                  }
                                });
                              }
                              setState(() {});
                            });
                          } else {
                            showDialog(
                                    context: context,
                                    builder: (BuildContext context) =>
                                        buildComplete(context, "Polyhedra"))
                                .then((reset) {
                              if (reset) {
                                polyhedraIndex = 0;
                                FirebaseFirestore.instance
                                    .collection('users')
                                    .doc(_auth.currentUser!.email)
                                    .set({
                                  'arithmetic': {
                                    'addition': additionIndex,
                                    'subtraction': subtractionIndex,
                                    'multiplication': multiplicationIndex,
                                    'division': divisionIndex,
                                    'exponents': exponentsIndex,
                                    'pemdas': pemdasIndex,
                                  },
                                  'algebra': {
                                    'expressions': expressionsIndex,
                                    'linear': linearIndex,
                                    'quadratic': quadraticIndex,
                                  },
                                  'geometry': {
                                    'polygons': polygonsIndex,
                                    'polyhedra': polyhedraIndex,
                                    'trigonometry': trigonometryIndex,
                                  },
                                  'calculus': {
                                    'derivatives': derivativesIndex,
                                    'integrals': integralsIndex,
                                  }
                                });
                                setState(() {});
                              }
                            });
                          }
                        },
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.indigo.shade300),
                        child: Text('Trigonometry',
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 12)),
                        onPressed: () {
                          if (trigonometryIndex <
                              trigonometryQuestions.length) {
                            QuestionPair qp =
                                trigonometryQuestions[trigonometryIndex];
                            showDialog(
                                context: context,
                                builder: (BuildContext context) =>
                                    buildPractice(
                                        context,
                                        "Trigonometry",
                                        qp.question,
                                        qp.answer)).then((correct) {
                              if (correct) {
                                trigonometryIndex++;
                                FirebaseFirestore.instance
                                    .collection('users')
                                    .doc(_auth.currentUser!.email)
                                    .set({
                                  'arithmetic': {
                                    'addition': additionIndex,
                                    'subtraction': subtractionIndex,
                                    'multiplication': multiplicationIndex,
                                    'division': divisionIndex,
                                    'exponents': exponentsIndex,
                                    'pemdas': pemdasIndex,
                                  },
                                  'algebra': {
                                    'expressions': expressionsIndex,
                                    'linear': linearIndex,
                                    'quadratic': quadraticIndex,
                                  },
                                  'geometry': {
                                    'polygons': polygonsIndex,
                                    'polyhedra': polyhedraIndex,
                                    'trigonometry': trigonometryIndex,
                                  },
                                  'calculus': {
                                    'derivatives': derivativesIndex,
                                    'integrals': integralsIndex,
                                  }
                                });
                              }
                              setState(() {});
                            });
                          } else {
                            showDialog(
                                    context: context,
                                    builder: (BuildContext context) =>
                                        buildComplete(context, "Trigonometry"))
                                .then((reset) {
                              if (reset) {
                                trigonometryIndex = 0;
                                FirebaseFirestore.instance
                                    .collection('users')
                                    .doc(_auth.currentUser!.email)
                                    .set({
                                  'arithmetic': {
                                    'addition': additionIndex,
                                    'subtraction': subtractionIndex,
                                    'multiplication': multiplicationIndex,
                                    'division': divisionIndex,
                                    'exponents': exponentsIndex,
                                    'pemdas': pemdasIndex,
                                  },
                                  'algebra': {
                                    'expressions': expressionsIndex,
                                    'linear': linearIndex,
                                    'quadratic': quadraticIndex,
                                  },
                                  'geometry': {
                                    'polygons': polygonsIndex,
                                    'polyhedra': polyhedraIndex,
                                    'trigonometry': trigonometryIndex,
                                  },
                                  'calculus': {
                                    'derivatives': derivativesIndex,
                                    'integrals': integralsIndex,
                                  }
                                });
                                setState(() {});
                              }
                            });
                          }
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
