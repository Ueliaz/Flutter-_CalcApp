import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        title: 'Calculator App',
        debugShowCheckedModeBanner: false,
        home: CalcApp());
  }
}

class CalcApp extends StatefulWidget {
  const CalcApp({Key? key}) : super(key: key);

  @override
  _CalcAppState createState() => _CalcAppState();
}

class _CalcAppState extends State<CalcApp> {
   String equation = "0";
  String result = "0";
  String expression = "";
  double equationFontSize = 40;
  double resultFontSize = 35;
  void calcBackend(String buttonText) {
    setState(() {
      // if (buttonText == "C") {
      //   equation = "0";
      //   result = "0";
      // equationFontSize = 38;
      // resultFontSize = 48;
      // } else if (buttonText == "CE") {
      //   equationFontSize = 48;
      //   resultFontSize = 38;
      //   equation = equation.substring(0, equation.length - 1);
      //   if (equation == "") {
      //     equation = "0";
      //   }
      // } else if (buttonText == "=") {
      //   equationFontSize = 38;
      //   resultFontSize = 48;
      //   expression = equation;
      //   expression = expression.replaceAll("×", "*");
      //   expression = expression.replaceAll("÷", "/");
      //   try {
      //     Parser p = Parser();
      //     Expression exp = p.parse(expression);

      //     ContextModel cm = ContextModel();
      //     result = '${exp.evaluate(EvaluationType.REAL, cm)}';
      //   } catch (e) {
      //     result = "error";
      //   }
      // } else {
      //   equationFontSize = 48;
      //   resultFontSize = 38;
      //   if (equation == "0") {
      //     equation = buttonText;
      //   } else {
      //     equation = equation + buttonText;
      //   }
      // }
      if (buttonText == "C") {
        equation = "0";
        result = "0";
      } else if (buttonText == "CE") {
        equation = equation.substring(0, equation.length - 1);
        if (equation == "") {
          equation = "0";
        }
      } else if (buttonText == "1" ||
          buttonText == "2" ||
          buttonText == "3" ||
          buttonText == "4" ||
          buttonText == "5" ||
          buttonText == "6" ||
          buttonText == "7" ||
          buttonText == "8" ||
          buttonText == "9") {
        if (equation == "0") {
          equation = buttonText;
        } else {
          equation = equation + buttonText;
        }
        expression = equation;
        expression = expression.replaceAll("×", "*");
        expression = expression.replaceAll("÷", "/");

        try {
          Parser p = Parser();
          Expression exp = p.parse(expression);

          ContextModel cm = ContextModel();
          result = '${exp.evaluate(EvaluationType.REAL, cm)}';
        } catch (e) {
          result = "error";
        }
      } else if (buttonText == "=") {
        expression = equation;
        expression = expression.replaceAll("×", "*");
        expression = expression.replaceAll("÷", "/");
        try {
          Parser p = Parser();
          Expression exp = p.parse(expression);

          ContextModel cm = ContextModel();
          equation = '${exp.evaluate(EvaluationType.REAL, cm)}';
          result = "0";
        } catch (e) {
          result = "error";
        }
      } else if (equation == "0") {
        equation = buttonText;
      } else {
        equation = equation + buttonText;
      }
    });
  }

  Widget buildButton(String buttonText, Color textColor, double buttonHeight,
      Color buttonColor) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 55,
      child: Table(children: [
        TableRow(children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * buttonHeight,
            child: TextButton(
                style: TextButton.styleFrom(
                  primary: textColor,
                  backgroundColor: buttonColor,
                  maximumSize: const Size(100, 100),
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(100))),
                  shadowColor: Colors.red.withOpacity(1),
                  textStyle: const TextStyle(fontSize: 25),
                ),
                onPressed: () {
                  calcBackend(buttonText);
                },
                onLongPress: () {},
                child: Text(buttonText)),
          )
        ])
      ]),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade800,
      appBar: AppBar(
        backgroundColor: Colors.blueGrey.shade800,
        shadowColor: Colors.orange.withOpacity(1),
        toolbarHeight: 50,
        titleTextStyle: const TextStyle(
          color: Colors.amber,
        ),
        title: const Text(
          "Calculator App",
          style: TextStyle(fontSize: 20),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
            child: Text(
              equation,
              style: TextStyle(fontSize: equationFontSize, color: Colors.white),
            ),
          ),

          Container(
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.fromLTRB(10, 30, 10, 0),
            child: Text(
              result,
              style: TextStyle(fontSize: resultFontSize, color: Colors.white30),
            ),
          ),
            const Expanded(child: Divider()),
          // const SizedBox(height: 70),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * .75,
                child: Table(children: [
                  TableRow(children: [
                    buildButton(
                        'CE', Colors.blueGrey.shade700, 0.12, Colors.white70),
                    buildButton(
                        'C', Colors.blueGrey.shade700, 0.12, Colors.white70),
                    buildButton(
                        '÷', Colors.blueGrey.shade700, 0.12, Colors.white70),
                  ]),
                  TableRow(children: [
                    buildButton(
                        '9', Colors.white70, 0.12, Colors.blueGrey.shade700),
                    buildButton(
                        '8', Colors.white70, 0.12, Colors.blueGrey.shade700),
                    buildButton(
                        '7', Colors.white70, 0.12, Colors.blueGrey.shade700),
                  ]),
                  TableRow(children: [
                    buildButton(
                        '6', Colors.white70, 0.12, Colors.blueGrey.shade700),
                    buildButton(
                        '5', Colors.white70, 0.12, Colors.blueGrey.shade700),
                    buildButton(
                        '4', Colors.white70, 0.12, Colors.blueGrey.shade700),
                  ]),
                  TableRow(children: [
                    buildButton(
                        '3', Colors.white70, 0.12, Colors.blueGrey.shade700),
                    buildButton(
                        '2', Colors.white70, 0.12, Colors.blueGrey.shade700),
                    buildButton(
                        '1', Colors.white70, 0.12, Colors.blueGrey.shade700),
                  ]),
                  TableRow(children: [
                    buildButton(
                        '.', Colors.white70, 0.12, Colors.blueGrey.shade700),
                    buildButton(
                        '0', Colors.white70, 0.12, Colors.blueGrey.shade700),
                    buildButton(
                        '00', Colors.white70, 0.12, Colors.blueGrey.shade700),
                  ]),
                ]),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.25,
                child: Table(
                  children: [
                    TableRow(children: [
                      buildButton(
                          "+", Colors.blueGrey.shade700, 0.12, Colors.white60)
                    ]),
                    TableRow(children: [
                      buildButton(
                          "-", Colors.blueGrey.shade700, 0.12, Colors.white60)
                    ]),
                    TableRow(children: [
                      buildButton(
                          "×", Colors.blueGrey.shade700, 0.12, Colors.white60)
                    ]),
                    TableRow(children: [
                      buildButton("=", Colors.blueGrey.shade700, 0.24,
                          Colors.amber.shade100)
                    ])
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
