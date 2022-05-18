import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  return runApp(
    MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blueAccent,
          title: Text('Ask Me Anything'),
        ),
        body: MagicBall(),
      ),
    ),
  );
}

class MagicBall extends StatefulWidget {
  // const MagicBall({ Key? key }) : super(key: key);

  @override
  State<MagicBall> createState() => _MagicBallState();
}

class _MagicBallState extends State<MagicBall> {
  var magicNumber = 1;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        child: Center(
          child: TextButton(
            onPressed: () {
              setState(() {
                magicNumber = Random().nextInt(5) + 1;
              });
            },
            child: Image.asset('images/ball${magicNumber}.png'),
          ),
        ),
        color: Colors.lightBlueAccent,
      ),
    );
  }
}
