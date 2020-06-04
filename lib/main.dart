import 'dart:math';

import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: Scaffold(body: View()));
  }
}

class View extends StatefulWidget {
  ViewState createState() => ViewState();
}

class ViewState extends State {
  Color backgroundColor = Colors.white;
  Color textColor = Colors.black;
  double fontSize = 40;
  bool selected = false;
  final Random random = Random();

  void changeFontSize() async {
    setState(() {
      fontSize += random.nextInt(42) - 25;
      if (fontSize < 25) {
        fontSize += 20;
      }
    });
  }

  void changeTextColor() async {
    Color tempTextColor = Color.fromARGB(
      255,
      random.nextInt(256),
      random.nextInt(256),
      random.nextInt(256),
    );
    setState(() {
      textColor = tempTextColor;
    });
  }

  void changeBackgroundColor() async {
    Color tempColor = Color.fromARGB(
      random.nextInt(256),
      random.nextInt(256),
      random.nextInt(256),
      random.nextInt(256),
    );
    setState(() {
      backgroundColor = tempColor;
    });
  }

  void showInfoDialog() => showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Info'),
          content: Text(
              "- Touch anywhere to randomly change background color.\n\n"
              "- Touch text to change color and font size.\n\n"
              "- Click Action button to change color of the text, background color and font size.\n\n"),
          actions: <Widget>[
            FlatButton(
              child: Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: const Text('Random Background Color'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.info_outline),
            onPressed: () {
              showInfoDialog();
            },
          )
        ],
      ),
      body: InkWell(
        onTap: () {
          changeBackgroundColor();
        },
        child: Center(
            child: GestureDetector(
          onTap: () {
            setState(() {
              selected = !selected;
            });
            changeFontSize();
            changeTextColor();
          },
          child: AnimatedDefaultTextStyle(
            style: selected
                ? TextStyle(
                    fontSize: fontSize,
                    color: textColor,
                    fontWeight: FontWeight.bold)
                : TextStyle(
                    fontSize: fontSize,
                    color: textColor,
                    fontWeight: FontWeight.normal),
            curve: Curves.bounceInOut,
            duration: const Duration(milliseconds: 200),
            child: Text(
              'Hey there;)',
            ),
          ),
        )),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          changeBackgroundColor();
          changeFontSize();
          changeTextColor();
          setState(() {
            selected = !selected;
          });
        },
        child: Icon(Icons.all_inclusive),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(16.0))),
        backgroundColor: Colors.blue,
      ),
    );
  }
}
