import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_first_app/button.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  // SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
  // SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: "Calculator App",
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePage();
}

class _MyHomePage extends State<MyHomePage> {
  var question = "";
  var ans = "";
  final textKey = [
    'C',
    "Del",
    "%",
    "/",
    "9",
    "8",
    "7",
    "x",
    "6",
    "5",
    "4",
    "-",
    "3",
    "2",
    "1",
    "+",
    "0",
    ".",
    "ANS",
    "="
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple.shade200,
      body: Column(
        children: [
          Expanded(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 50,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    question,
                    style: GoogleFonts.montserrat(
                      fontSize: 30,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  alignment: Alignment.centerRight,
                  child: Text(
                    ans,
                    style: GoogleFonts.montserrat(
                      fontSize: 30,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ],
          )),
          Expanded(
              flex: 2,
              child: GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: textKey.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                  ),
                  itemBuilder: (context, index) {
                    if (index == 0) {
                      return MyButton(
                        tapfun: () {
                          setState(() {
                            question = "";
                            ans = "";
                          });
                        },
                        text: textKey[index],
                        color: Colors.green.shade400,
                        textColor: Colors.white,
                      );
                    } else if (index == 1) {
                      return MyButton(
                        tapfun: () {
                          setState(() {
                            if (question.isNotEmpty) {
                              question =
                                  question.substring(0, question.length - 1);
                            }
                            if (ans.isNotEmpty) {
                              ans = "";
                            }
                          });
                        },
                        text: textKey[index],
                        color: Colors.red.shade400,
                        textColor: Colors.white,
                      );
                    } else if (index == textKey.length - 1) {
                      return MyButton(
                        tapfun: () {
                          setState(() {
                            evaluateAns();
                          });
                        },
                        text: textKey[index],
                        textColor: isOperator(textKey[index])
                            ? Colors.white
                            : Colors.deepPurple.shade700,
                        color: isOperator(textKey[index])
                            ? Colors.deepPurple.shade700
                            : Colors.white,
                      );
                    } else if (index == textKey.length - 2) {
                      return MyButton(
                        tapfun: () {
                          setState(() {
                            question = ans;
                            ans = "";
                          });
                        },
                        text: textKey[index],
                        textColor: isOperator(textKey[index])
                            ? Colors.white
                            : Colors.deepPurple.shade700,
                        color: isOperator(textKey[index])
                            ? Colors.deepPurple.shade700
                            : Colors.white,
                      );
                    } else {
                      return MyButton(
                        tapfun: () {
                          setState(() {
                            question += textKey[index];
                          });
                        },
                        text: textKey[index],
                        textColor: isOperator(textKey[index])
                            ? Colors.white
                            : Colors.deepPurple.shade700,
                        color: isOperator(textKey[index])
                            ? Colors.deepPurple.shade700
                            : Colors.white,
                      );
                    }
                  })),
        ],
      ),
    );
  }

  void evaluateAns() {
    String finalAns = question;
    finalAns = finalAns.replaceAll("x", "*");
    Parser p = Parser();
    Expression exp = p.parse(finalAns);
    ContextModel cm = ContextModel();
    double eval = exp.evaluate(EvaluationType.REAL, cm);
    ans = eval.toString();
  }
}

bool isOperator(String x) {
  if (x == "%" || x == "/" || x == "x" || x == "-" || x == "+" || x == "=") {
    return true;
  }
  return false;
}
