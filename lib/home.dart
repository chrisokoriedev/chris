import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State < Home > {
  String equation = "0";
  String result = "0";
  String expression = "";
  double equationFontSize = 38.0;
  double resultFontSize = 48.0;

  buttonPressed(String buttonText) {
    setState(() {
      if (buttonText == "C") {
        equation = "0";
        result = "0";
        equationFontSize = 38.0;
        resultFontSize = 48.0;
      } else if (buttonText == "⌫") {
        equation = equation.substring(0, equation.length - 1);
        if (equation == "") {
          equation = "0";
        }
      } else if (buttonText == "=") {
        equationFontSize = 38.0;
        resultFontSize = 48.0;

        expression = equation;
        expression = expression.replaceAll('-', '-');
        expression = expression.replaceAll('+', '+');
        expression = expression.replaceAll('x', '*');
        expression = expression.replaceAll('÷', '/');
        try {
          Parser p = Parser();
          Expression exp = p.parse(expression);
          ContextModel cm = ContextModel();
          result = '${exp.evaluate(EvaluationType.REAL, cm)}';
        } catch (e) {
          result = "Error";
        }
      } else {
        equationFontSize = 38.0;
        resultFontSize = 48.0;
        if (equation == "0") {
          equation = buttonText;
        } else {
          equation = equation + buttonText;
        }
      }
    });
  }

  Widget buildButton(
    String buttonText, double buttonHeight, ) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.1 * buttonHeight,
      child: FlatButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(90.0),
          side: BorderSide(
            color: Colors.white,
            width: 1,
            style: BorderStyle.solid,
          ),
        ),
        padding: EdgeInsets.all(16.0),
        onPressed: () => buttonPressed(buttonText),
        child: Text(
          buttonText,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.normal,
            fontSize: 30.0),
        )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculator'),
        centerTitle: true,
      ),
      body: Column(
        children: < Widget > [
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
            child: Text(
              equation,
              style:
              TextStyle(fontSize: equationFontSize, color: Colors.white),
            ),
          ),
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
            child: Text(
              result,
              style: TextStyle(fontSize: resultFontSize, color: Colors.white),
            ),
          ),
          Expanded(child: Divider(color: Colors.black54, )),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: < Widget > [
              Container(
                decoration: BoxDecoration(
                  color: Colors.black26
                ),
                width: MediaQuery.of(context).size.width * .80,
                child: Table(
                  children: [
                    TableRow(
                      children: [
                        buildButton('C', 1, ),
                        buildButton('⌫', 1, ),
                        buildButton('÷', 1, )
                      ],
                    ),
                    TableRow(
                      children: [
                        buildButton('7', 1, ),
                        buildButton('8', 1, ),
                        buildButton('9', 1, )
                      ],
                    ),
                    TableRow(
                      children: [
                        buildButton('6', 1, ),
                        buildButton('5', 1, ),
                        buildButton('4', 1, )
                      ],
                    ),
                    TableRow(
                      children: [
                        buildButton('3', 1, ),
                        buildButton('2', 1, ),
                        buildButton('1', 1, )
                      ],
                    ),
                    TableRow(
                      children: [
                        buildButton('.', 1, ),
                        buildButton('0', 1, ),
                        buildButton('00', 1, )
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.orange[600]
                ),
                width: MediaQuery.of(context).size.width * 0.20,
                child: Table(
                  children: [
                    TableRow(children: [
                      buildButton('x', 1, ),
                    ]),
                    TableRow(children: [
                      buildButton('-', 1, ),
                    ]),
                    TableRow(children: [
                      buildButton('+', 1, ),
                    ]),
                    TableRow(children: [
                      buildButton('=', 2, ),
                    ]),
                  ],
                ),
              )
            ],
          )
        ],
      ));
  }
}