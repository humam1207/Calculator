import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';
import 'dart:math';

void main() => runApp(Calculator());

class Calculator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Calculator',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: SimpleCalculator(),
    );
  }
}

class SimpleCalculator extends StatefulWidget {
  @override
  _SimpleCalculatorState createState() => _SimpleCalculatorState();
}

class _SimpleCalculatorState extends State<SimpleCalculator> {

  String equation = '0';
  String result = '0';
  String expression = '';
  double equationFontSize = 38;
  double resultFontSize = 48;

  buttonPressed(String buttonText){
    setState(() {
      if(buttonText == 'C'){
        equation = '0';
        result = '0';
        equationFontSize = 38;
        resultFontSize = 48;
      }
      else if (buttonText == '⏎'){
        equationFontSize = 48;
        resultFontSize = 38;
        equation= equation.substring(0, equation.length-1);
        if(equation == ''){
          equation = '0';
        }
      }
      else if (buttonText == '='){
        equationFontSize = 38;
        resultFontSize = 48;
        expression=equation;
        expression = expression.replaceAll('×', '*');
        expression = expression.replaceAll('÷', '/');

        try{
          Parser p = Parser();
          Expression exp = p.parse(expression);

          result = '${exp.evaluate(EvaluationType.REAL,ContextModel())}';
        }
        catch(e){
          result = 'Error';
        }
      }
      else{
        if(equation == '0'){
          equationFontSize = 48;
          resultFontSize = 38;
          equation = buttonText;


        }
        else{
          equation=equation+buttonText;
        }
      }
    });
  }


  Widget buildbutton (String buttonText, double buttonHeight, Color buttonColor){
    return Container(
      height: MediaQuery.of(context).size.height * 0.1 * buttonHeight,
      color: buttonColor,
      child: FlatButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0),
          side: BorderSide(
            style: BorderStyle.solid,
            color: Colors.white,
            width: 1,
          ),
        ),
        padding: EdgeInsets.all(16),
        onPressed: () => buttonPressed(buttonText),
        child: Text(
          buttonText,
          style: TextStyle(
            fontWeight: FontWeight.normal,
            color: Colors.white,
            fontSize: 30,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Simple Calculator'),
        centerTitle: true,
      ),
      body: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
            alignment: Alignment.centerRight,
            child: Text(
              equation,
              style: TextStyle(
                fontSize: equationFontSize,
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(10, 30, 10, 0),
            alignment: Alignment.centerRight,
            child: Text(
              result,
              style: TextStyle(
                fontSize: resultFontSize,
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
          Expanded(
            child: Divider(),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width * 0.75,
                child: Table(
                  children: [
                    TableRow(
                      children: [
                        buildbutton('C', 1, Colors.red),
                        buildbutton('⏎', 1, Colors.blue),
                        buildbutton('÷', 1, Colors.blue),
                      ],
                    ),
                    TableRow(
                      children: [
                        buildbutton('7', 1, Colors.black54),
                        buildbutton('8', 1, Colors.black54),
                        buildbutton('9', 1, Colors.black54),
                      ],
                    ),
                    TableRow(
                      children: [
                        buildbutton('4', 1, Colors.black54),
                        buildbutton('5', 1, Colors.black54),
                        buildbutton('6', 1, Colors.black54),
                      ],
                    ),
                    TableRow(
                      children: [
                        buildbutton('1', 1, Colors.black54),
                        buildbutton('2', 1, Colors.black54),
                        buildbutton('3', 1, Colors.black54),
                      ],
                    ),
                    TableRow(
                      children: [
                        buildbutton('.', 1, Colors.black54),
                        buildbutton('0', 1, Colors.black54),
                        buildbutton('00', 1, Colors.black54),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.25,
                child: Table(
                  children: [
                    TableRow(
                      children: [
                        buildbutton('×', 1, Colors.blue),
                      ]
                    ),
                    TableRow(
                        children: [
                          buildbutton('-', 1, Colors.blue),
                        ]
                    ),
                    TableRow(
                        children: [
                          buildbutton('+', 1, Colors.blue),
                        ]
                    ),
                    TableRow(
                        children: [
                          buildbutton('=', 2, Colors.blue),
                        ]
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}



