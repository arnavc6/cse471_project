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

class ArithmeticPractice extends StatelessWidget {
  const ArithmeticPractice({Key? key}) : super(key: key);

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
  static const String _title = 'Arithmetic Practice';

  static List<QuestionPair> additionQuestions = [
    QuestionPair("What's 1 + 1?", 2),
    QuestionPair("What's 2 + 3?", 5),
    QuestionPair("What's 4 + 2?", 6),
    QuestionPair("What's 5 + 3?", 8),
    QuestionPair("What's 7 + 2?", 9),
  ];

  static List<QuestionPair> subtractionQuestions = [
    QuestionPair("What's 2 - 1?", 1),
    QuestionPair("What's 3 - 2?", 1),
    QuestionPair("What's 6 - 2?", 4),
    QuestionPair("What's 8 - 3?", 5),
    QuestionPair("What's 9 - 2?", 7),
  ];

  static List<QuestionPair> multiplicationQuestions = [
    QuestionPair("What's 1 * 3?", 3),
    QuestionPair("What's 2 * 2?", 4),
    QuestionPair("What's 3 * 3?", 9),
    QuestionPair("What's 4 * 3?", 12),
    QuestionPair("What's 5 * 4?", 20),
  ];

  static List<QuestionPair> divisionQuestions = [
    QuestionPair("What's 6 / 2?", 3),
    QuestionPair("What's 8 / 2?", 4),
    QuestionPair("What's 15 / 3?", 5),
    QuestionPair("What's 20 / 4?", 5),
    QuestionPair("What's 18 / 3?", 6),
  ];

  static List<QuestionPair> exponentsQuestions = [
    QuestionPair("What's 2^1?", 2),
    QuestionPair("What's 2^2?", 4),
    QuestionPair("What's 3^2?", 9),
    QuestionPair("What's 2^4?", 16),
    QuestionPair("What's 3^3?", 27),
  ];

  static List<QuestionPair> pemdasQuestions = [
    QuestionPair("What's (10 - 2) / 2?", 4),
    QuestionPair("What's (2 + 3) * 1?", 5),
    QuestionPair("What's 2 * (3 + 1)?", 8),
    QuestionPair("What's 2^(2 + 3)?", 8),
    QuestionPair("What's 2 + (3 * 4)?", 14),
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
                          "Stats: \nAddition: $additionIndex of ${additionQuestions.length} \nSubtraction: $subtractionIndex of ${subtractionQuestions.length} \nMultiplication: $multiplicationIndex of ${multiplicationQuestions.length} \nDivision: $divisionIndex of ${divisionQuestions.length} \nExponents: $exponentsIndex of ${exponentsQuestions.length} \nPEMDAS: $pemdasIndex of ${pemdasQuestions.length}"),
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
                        child: Text('Addition',
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 12)),
                        onPressed: () {
                          if (additionIndex < additionQuestions.length) {
                            QuestionPair qp = additionQuestions[additionIndex];
                            showDialog(
                                context: context,
                                builder: (BuildContext context) =>
                                    buildPractice(
                                        context,
                                        "Addition",
                                        qp.question,
                                        qp.answer)).then((correct) {
                              if (correct) {
                                additionIndex++;
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
                                        buildComplete(context, "Addition"))
                                .then((reset) {
                              if (reset) {
                                additionIndex = 0;
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
                        child: Text('Subtraction',
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 12)),
                        onPressed: () {
                          if (subtractionIndex < subtractionQuestions.length) {
                            QuestionPair qp =
                                subtractionQuestions[subtractionIndex];
                            showDialog(
                                context: context,
                                builder: (BuildContext context) =>
                                    buildPractice(
                                        context,
                                        "Subtraction",
                                        qp.question,
                                        qp.answer)).then((correct) {
                              if (correct) {
                                subtractionIndex++;
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
                                        buildComplete(context, "Subtraction"))
                                .then((reset) {
                              if (reset) {
                                subtractionIndex = 0;
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
                        child: Text('Multiplication',
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 12)),
                        onPressed: () {
                          if (multiplicationIndex <
                              multiplicationQuestions.length) {
                            QuestionPair qp =
                                multiplicationQuestions[multiplicationIndex];
                            showDialog(
                                context: context,
                                builder: (BuildContext context) =>
                                    buildPractice(
                                        context,
                                        "Multiplication",
                                        qp.question,
                                        qp.answer)).then((correct) {
                              if (correct) {
                                multiplicationIndex++;
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
                                        buildComplete(
                                            context, "Multiplication"))
                                .then((reset) {
                              if (reset) {
                                multiplicationIndex = 0;
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
                        child: Text('Division',
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 12)),
                        onPressed: () {
                          if (divisionIndex < divisionQuestions.length) {
                            QuestionPair qp = divisionQuestions[divisionIndex];
                            showDialog(
                                context: context,
                                builder: (BuildContext context) =>
                                    buildPractice(
                                        context,
                                        "Division",
                                        qp.question,
                                        qp.answer)).then((correct) {
                              if (correct) {
                                divisionIndex++;
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
                                        buildComplete(context, "Division"))
                                .then((reset) {
                              if (reset) {
                                divisionIndex = 0;
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
                        child: Text('Exponents',
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 12)),
                        onPressed: () {
                          if (exponentsIndex < exponentsQuestions.length) {
                            QuestionPair qp =
                                exponentsQuestions[exponentsIndex];
                            showDialog(
                                context: context,
                                builder: (BuildContext context) =>
                                    buildPractice(
                                        context,
                                        "Exponents",
                                        qp.question,
                                        qp.answer)).then((correct) {
                              if (correct) {
                                exponentsIndex++;
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
                                        buildComplete(context, "Exponents"))
                                .then((reset) {
                              if (reset) {
                                exponentsIndex = 0;
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
                        child: Text('PEMDAS',
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 12)),
                        onPressed: () {
                          if (pemdasIndex < pemdasQuestions.length) {
                            QuestionPair qp = pemdasQuestions[pemdasIndex];
                            showDialog(
                                context: context,
                                builder: (BuildContext context) =>
                                    buildPractice(
                                        context,
                                        "PEMDAS",
                                        qp.question,
                                        qp.answer)).then((correct) {
                              if (correct) {
                                pemdasIndex++;
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
                                        buildComplete(context, "PEMDAS"))
                                .then((reset) {
                              if (reset) {
                                pemdasIndex = 0;
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
