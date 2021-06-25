import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'buttons.dart';
import 'package:math_expressions/math_expressions.dart';
import 'package:bitsdojo_window/bitsdojo_window.dart';

void main() {
  runApp(MyApp());

  doWhenWindowReady(() {
    const initialSize = Size(300, 530);
    appWindow.minSize = initialSize;
    appWindow.maxSize = initialSize;
    appWindow.size = initialSize;
    appWindow.alignment = Alignment.centerRight;
    appWindow.show();
  });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    ); // MaterialApp
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var userInput = '';
  var answer = '';

// Array of button
  final List<String> buttons = [
    'AC',
    '%',
    'DEL',
    '/',
    '7',
    '8',
    '9',
    'x',
    '4',
    '5',
    '6',
    '-',
    '1',
    '2',
    '3',
    '+',
    '0',
    '.',
    ' ',
    '=',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF1F1F1),
      body: WindowBorder(
        width: 10,
        color: Color(0xFF16C88D),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            WindowTitleBarBox(
              child: Row(
                children: [
                  WindowButtons(),
                  Expanded(
                    child: MoveWindow(),
                  )
                ],
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(
                child: Column(children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(20),
                    alignment: Alignment.centerRight,
                    child: Text(
                      answer,
                      style: TextStyle(
                          fontSize: 40,
                          color: Color(0xFF16C88D),
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Container(
                      padding: EdgeInsets.all(15),
                      alignment: Alignment.centerRight,
                      child: Text(
                        userInput,
                        style: TextStyle(
                          fontSize: 18,
                          color: Color(0xFFB1C3BB),
                        ),
                      ),
                    ),
                  ),
                ]),
              ),
            ),
            Expanded(
              flex: 6,
              child: Align(
                alignment: Alignment.bottomCenter,
                child: GridView.builder(
                    padding: EdgeInsets.all(2),
                    itemCount: buttons.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4),
                    itemBuilder: (BuildContext context, int index) {
                      // Clear Button
                      if (index == 0) {
                        return MyButton(
                          buttontapped: () {
                            setState(() {
                              userInput = '';
                              answer = '0';
                            });
                          },
                          buttonText: buttons[index],
                          color: Color(0xFFF1F1F1),
                          textColor: Color(0xFF16C88D),
                        );
                      }

                      // % button
                      else if (index == 1) {
                        return MyButton(
                          buttontapped: () {
                            setState(() {
                              userInput += buttons[index];
                            });
                          },
                          buttonText: buttons[index],
                          color: Color(0xFFF1F1F1),
                          textColor: Color(0xFF16C88D),
                        );
                      }
                      // delete Button
                      else if (index == 2) {
                        return MyButton(
                          buttontapped: () {
                            setState(() {
                              userInput =
                                  userInput.substring(0, userInput.length - 1);
                            });
                          },
                          buttonText: buttons[index],
                          color: Color(0xFFF1F1F1),
                          textColor: Color(0xFF16C88D),
                        );
                      }
                      // Equal_to Button
                      else if (index == 19) {
                        return MyButton(
                          buttontapped: () {
                            setState(() {
                              equalPressed();
                            });
                          },
                          buttonText: buttons[index],
                          color: Color(0xFF16C88D),
                          textColor: Color(0xFFF1F1F1),
                        );
                      }

                      // other buttons
                      else {
                        return MyButton(
                          buttontapped: () {
                            setState(() {
                              userInput += buttons[index];
                            });
                          },
                          buttonText: buttons[index],
                          color: Color(0xFFF1F1F1),
                          textColor: isOperator(buttons[index])
                              ? Color(0xFF16C88D)
                              : Color(0xFF5D6F49),
                        );
                      }
                    }),
              ),
            ),
          ],
        ),
      ),
    );
  }

  bool isOperator(String x) {
    if (x == '/' || x == 'x' || x == '-' || x == '+' || x == '=') {
      return true;
    }
    return false;
  }

// function to calculate the input operation
  void equalPressed() {
    String finaluserinput = userInput;
    finaluserinput = userInput.replaceAll('x', '*');

    Parser p = Parser();
    Expression exp = p.parse(finaluserinput);
    ContextModel cm = ContextModel();
    double eval = exp.evaluate(EvaluationType.REAL, cm);
    answer = eval.toString();
  }
}

final buttonColors = WindowButtonColors(
  iconNormal: Color(0xFF16C88D),
  iconMouseDown: Color(0xFFF1F1F1),
  iconMouseOver: Color(0xFFF1F1F1),
  mouseOver: Color(0xFF16C88D),
  mouseDown: Color(0xFF16C88D),
);

class WindowButtons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CloseWindowButton(
          colors: buttonColors,
        ),
        MinimizeWindowButton(
          colors: buttonColors,
        ),
      ],
    );
  }
}
