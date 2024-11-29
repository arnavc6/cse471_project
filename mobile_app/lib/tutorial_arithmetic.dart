import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mobile_app/main.dart';
import 'package:flutter/src/material/colors.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:mobile_app/practice.dart';
import 'package:mobile_app/build_tutorial.dart';

final _auth = FirebaseAuth.instance;

class ArithmeticTutorial extends StatelessWidget {
  const ArithmeticTutorial({Key? key}) : super(key: key);
  static const String _title = 'Arithmetic Tutorials';

  static List<String> tutorialTitles = [
    "Addition",
    "Subtraction",
    "Multiplication",
    "Division",
    "Exponents",
    "PEMDAS",
  ];

  static List<String> tutorialText = [
    "Addition calculates the total of two or more numbers. For example, if you have 2 apples and add 3 more apples, you'll have 5 apples in total. In order to add numbers, first choose the numbers you want to add, for instance 4 and 5. If the numbers are single-digit, add them by counting on your fingers or using a number line. Eventually you'll have these sums memorized. If the numbers are multi-digit, place one number above the other, aligning the digits by place value (like 10s, 100s, etc.). Start from the rightmost digit and move left. For example, if adding 23 and 46, first add the rightmost digits 3 and 6 to get 9, then add the leftmost digits 2 and 4 to get 6 for a final answer of 69. When adding multi-digit numbers, you may need to \"carry\" if the sum of a column is more than 9. For example, if adding 57 and 68, first add the rightmost digits. 7 + 8 = 15, so write down 5 and carry the 1. Then add the leftmost digits, adding the carried 1. 5 + 6 + 1 = 12, so the final answer is 125.",
    "Subtraction calculates how much is left when one number is taken away from another. For example, if you have 7 candies and give away 3, you'll have 4 apples left. In order to subtract numbers, first choose the numbers you want to subtract, for instance 9 and 5. If the numbers are single-digit, subtract them by counting down on your fingers or using a number line. Eventually you'll have these differences memorized. If the numbers are multi-digit, place one number above the other, aligning the digits by place value (like 10s, 100s, etc.). Start from the rightmost digit and move left. For example, if subtracting 23 from 46, first subtract 3 from 6 to get 3, then subtract 2 from 4 to get 2 for a final answer of 23. When the top digit in a column is smaller than the bottom digit, you'll need to \"borrow\" from the next column. For example, if subtracting 48 from 72, first subtract the rightmost digits. 8 is greater than 2, so borrow 1 from the tens place, making the 7 6. 12 - 8 = 4. Then subtract the next column. 6 - 4 = 2, so the final answer is 24.",
    "Multiplication is a shortcut for adding the same number multiple times. In order to multiply two numbers x and y, add x together y times. For example, 2 * 3 = 2 + 2 + 2 = 6. Eventually you'll have basic products memorized. For multi-digit multiplication, split each number into its places (like 10s, 100s, etc.). Then multiply each place in the first number by each place in the second. For example, 11 * 13 = (10 + 1) * (10 + 3) = 10 * 10 + 10 * 3 + 1 * 10 + 1 * 3 = 100 + 30 + 10 + 3 = 143.",
    "Division is the process of splitting a number into equal parts based on another number. In order to divide a number x by another number y, count how many times you have to subtract y from x until you get to 0. For example, 6 / 2 = 3, because you have to subtract 2 from 6 3 times to get 0. Eventually you'll have basic quotients memorized. For multi-digit division, divide each digit in the dividend by the divisor, carrying over the remainder to the next digit. For example, for 728 / 4, first divide 7 by 4. The quotient is 1 and the remainder is 3, which carries over to 2 to make 32. 32 / 4 = 8 with no remainder, so nothing carries over and the final division is 8 / 4 = 2. Therefore, 728 / 4 = 182.",
    "Exponentiation is a shortcut for multiplying the same number multiple times. In order to raise a number x to the power y, multiply x together y times. For example, 2^3 = 2 * 2 * 2 = 8.",
    "If given a multi-operation expression to evaluate, always go left to right and do operations inside parentheses first. Do exponents first, then multiplication and division, then addition and subtraction. For example, given the expression (5 + 4) * 2 ^ 2 / 4 - 1, first 5 + 4 would be evaluated giving us 9, then 2 ^ 2 giving us 4, then 9 * 4 which gives us 36, then 36 / 4 which gives us 9, then 9 - 3 which gives us 6.",
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
