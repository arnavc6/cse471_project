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

class CalculusPractice extends StatelessWidget {
  const CalculusPractice({Key? key}) : super(key: key);

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
  static const String _title = 'Calculus Practice';

  static List<QuestionPair> derivativesQuestions = [
    QuestionPair("Given the equation y = 2, find the derivative at x = 3", 0),
    QuestionPair(
        "Given the equation y = x + 1, find the derivative at x = 2", 1),
    QuestionPair("Given the equation y = x^2, find the derivative at x = 1", 2),
    QuestionPair(
        "Given the equation y = x^2 - 2x + 1, find the derivative at x = 1", 0),
    QuestionPair(
        "Given the equation y = x^3 - x^2 - x - 1, find the derivative at x = 2",
        6),
  ];

  static List<QuestionPair> integralsQuestions = [
    QuestionPair(
        "Given the equation y = 0, find the integral from x = [0, 1]", 0),
    QuestionPair(
        "Given the equation y = 3, find the integral from x = [0, 1]", 3),
    QuestionPair(
        "Given the equation y = 2x, find the integral from x = [0, 1]", 1),
    QuestionPair(
        "Given the equation y = 4x + 2, find the integral from x = [1, 2]", 8),
    QuestionPair(
        "Given the equation y = 3x^2, find the integral from x = [2, 3]", 19),
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
                          "Stats: \nDerivatives: $derivativesIndex of ${derivativesQuestions.length} \nIntegrals: $integralsIndex of ${integralsQuestions.length}"),
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
                        child: Text('Derivatives',
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 12)),
                        onPressed: () {
                          if (derivativesIndex < derivativesQuestions.length) {
                            QuestionPair qp =
                                derivativesQuestions[derivativesIndex];
                            showDialog(
                                context: context,
                                builder: (BuildContext context) =>
                                    buildPractice(
                                        context,
                                        "Derivatives",
                                        qp.question,
                                        qp.answer)).then((correct) {
                              if (correct) {
                                derivativesIndex++;
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
                                        buildComplete(context, "Derivatives"))
                                .then((reset) {
                              if (reset) {
                                derivativesIndex = 0;
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
                        child: Text('Integrals',
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 12)),
                        onPressed: () {
                          if (integralsIndex < integralsQuestions.length) {
                            QuestionPair qp =
                                integralsQuestions[integralsIndex];
                            showDialog(
                                context: context,
                                builder: (BuildContext context) =>
                                    buildPractice(
                                        context,
                                        "Integrals",
                                        qp.question,
                                        qp.answer)).then((correct) {
                              if (correct) {
                                integralsIndex++;
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
                                        buildComplete(context, "Integrals"))
                                .then((reset) {
                              if (reset) {
                                integralsIndex = 0;
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
