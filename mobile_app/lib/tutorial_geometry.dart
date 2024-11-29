import 'package:flutter/material.dart';
import 'package:mobile_app/main.dart';
import 'package:flutter/src/material/colors.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:mobile_app/practice.dart';
import 'package:mobile_app/build_tutorial.dart';

final _auth = FirebaseAuth.instance;

class GeometryTutorial extends StatelessWidget {
  const GeometryTutorial({Key? key}) : super(key: key);
  static const String _title = 'Geometry Tutorials';

  static List<String> tutorialTitles = [
    "Polygons",
    "Polyhedra",
    "Trigonometry"
  ];

  static List<String> tutorialText = [
    "The perimeter of any polygon is the sum of the lengths of its sides. For example, a polygon with side lengths 1, 2, 3, 4, and 5 has a perimeter of 1 + 2 + 3 + 4 + 5 = 15. The area of a triangle given base b and height h is bh/2. For example, a triangle with base 2 and height 1 has an area of 2 * 1 / 2 = 1. The area of a quadrilateral given base b and height h is bh. For example, the area of a quadrilateral with base 3 and height 4 is 3 * 4 = 12.",
    "The surface area of any polyhedron is the sum of the areas of its faces. For example, a cube with 6 faces and each face having an area of 1 will have a surface area of 6. The volume of a pyramid given base length l, base width w, and height h is lwh/3. For example, a pyramid with base length 1, base width 2, and height 3 is 1 * 2 * 3 / 3 = 2. The volume of a rectangular prism given base length l, base width w, and height h is lwh. For example, the volume of a rectangular prism with length 3, width 4, and height 5 is 3 * 4 * 5 = 60.",
    "The sine of an angle is the length of the side opposite it over the length of the hypotenuse. For example, a 30º angle has an opposite side length of 1 and a hypotenuse length of 2, so sin(30) = 0.5. The cosine of an angle is the length of the side adjacent to it over the length of the hypotenuse. For example, a 60º angle has an opposite side length of 1 and a hypotenuse length of 2, so cos(60) = 0.5. The tangent of an angle is the length of the side opposite it over the length of the side adjacent to it. For example, a 45º angle has an opposite side length of 1 and an adjacent side length of 1, so tan(45) = 1.",
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
