import 'package:flutter/material.dart';
import 'package:mobile_app/homepage.dart';
import 'package:mobile_app/password.dart';
import 'package:mobile_app/signup.dart';
import 'package:flutter/src/material/colors.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:permission_handler/permission_handler.dart';

//the function that initially runs when the app is opened
//initializes Firebase connection and ensures permissions are granted
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  if (await Permission.location.serviceStatus.isEnabled) {
    var status = Permission.location.status;
    print(status);
    if (await status.isGranted) {
    } else if (await status.isDenied) {
      Map<Permission, PermissionStatus> state = await [
        Permission.location,
      ].request();
      print(state);
      if (await Permission.location.isPermanentlyDenied) {
        openAppSettings();
      }
    }
  } else {
    var status = Permission.location.status;
    print(status);
    if (await status.isGranted) {
    } else if (await status.isDenied) {
      Map<Permission, PermissionStatus> state = await [
        Permission.location,
      ].request();
      print(state);
      if (await Permission.location.isPermanentlyDenied) {
        openAppSettings();
      }
    }
  }
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  static const String _title = 'Math App';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.indigo,
        ),
      ),
      title: _title,
      home: Scaffold(
        appBar: AppBar(title: const Text(_title)),
        body: const MyStatefulWidget(),
        backgroundColor: Colors.lightGreen[100],
      ),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key}) : super(key: key);

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

final _auth = FirebaseAuth.instance;

//Displays the login page

//create your own google-services.json using firebase and replace it under android/app, an example is provided
//https://firebase.google.com/docs/android/setup

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
                        style: TextStyle(
                            fontSize: 30, color: Colors.indigo.shade300),
                        child: AnimatedTextKit(
                          animatedTexts: [
                            TypewriterAnimatedText('Welcome!'),
                          ],
                        ))),
                Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(10),
                    child: const Text(
                      'Sign in',
                      style: TextStyle(fontSize: 20),
                    )),
                Container(
                  padding: const EdgeInsets.all(10),
                  child: TextField(
                    controller: nameController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'User Name',
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Text('Don\'t have an account?'),
                    TextButton(
                      child: const Text(
                        'Sign up',
                        style: TextStyle(fontSize: 20),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Signup()),
                        );
                      },
                    )
                  ],
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const Password()),
                    );
                  },
                  child: const Text('Forgot Password',
                      style: TextStyle(fontSize: 20)),
                ),
                Container(
                  height: 50,
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: ElevatedButton(
                    child: const Text('Login'),
                    onPressed: () async {
                      try {
                        final user = await _auth.signInWithEmailAndPassword(
                          email: nameController.text.trim(),
                          password: passwordController.text.trim(),
                        );

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const HomePage()),
                        );
                      } catch (e) {
                        print(e);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              content:
                                  Text('An error occurred. Please try again.')),
                        );
                      }
                    },
                  ),
                ),
              ],
            )));
  }
}
