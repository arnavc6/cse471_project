import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mobile_app/homepage.dart';
import 'package:mobile_app/old/help.dart';
import 'package:mobile_app/old/home.dart';
import 'package:mobile_app/main.dart';
import 'package:flutter/src/material/colors.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class Signup extends StatelessWidget {
  const Signup({Key? key}) : super(key: key);
  static const String _title = 'Mental Health App';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(_title)),
      body: const MyStatefulWidget(),
      backgroundColor: Colors.lightGreen[100],
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key}) : super(key: key);

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

final _auth = FirebaseAuth.instance;

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("lib/assets/beach.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
            padding: const EdgeInsets.all(10),
            child: ListView(
              children: <Widget>[
                Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(10),
                    child: DefaultTextStyle(
                        style: TextStyle(fontSize: 30, color: Colors.black),
                        child: AnimatedTextKit(
                          animatedTexts: [
                            TypewriterAnimatedText('Welcome'),
                            TypewriterAnimatedText('How are you doing?'),
                          ],
                        ))),
                Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(10),
                    child: const Text(
                      'Sign up',
                      style: TextStyle(fontSize: 20),
                    )),
                Container(
                  padding: const EdgeInsets.all(10),
                  child: TextField(
                    controller: nameController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Email',
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                  child: TextField(
                    obscureText: true,
                    controller: passwordController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Password',
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MyApp()),
                    );
                  },
                  child: const Text(
                    'Back',
                  ),
                ),
                Container(
                    height: 50,
                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: ElevatedButton(
                      child: const Text('Submit'),
                      onPressed: () async {
                        try {
                          await _auth.createUserWithEmailAndPassword(
                              email: nameController.text,
                              password: passwordController.text);
                          FirebaseFirestore.instance
                              .collection("users")
                              .doc(FirebaseAuth.instance.currentUser?.email)
                              .set({
                            'arithmetic': {
                              'addition': 0,
                              'subtraction': 0,
                              'multiplication': 0,
                              'division': 0,
                              'exponents': 0,
                              'pemdas': 0,
                            },
                            'algebra': {
                              'expressions': 0,
                              'linear': 0,
                              'quadratic': 0,
                            },
                            'geometry': {
                              'polygons': 0,
                              'polyhedra': 0,
                              'trigonometry': 0,
                            },
                            'calculus': {
                              'derivatives': 0,
                              'integrals': 0,
                            }
                          });
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const HomePage()),
                          );
                        } catch (e) {
                          Fluttertoast.showToast(
                            msg: e.toString(),
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity
                                .BOTTOM, // Also possible "TOP" and "CENTER"
                          );
                          print(e);
                        }
                      },
                    )),
              ],
            )));
  }
}
