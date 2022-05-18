import 'package:flutter/material.dart';
import 'dart:math';
import 'package:shake/shake.dart';
import 'package:audioplayers/audioplayers.dart';

void main() {
  return runApp(
    MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.red,
        appBar: AppBar(
          title: Text('Dicee'),
          backgroundColor: Colors.red,
        ),
        body: DicePage(),
      ),
    ),
  );
}

class DicePage extends StatefulWidget {
  @override
  State<DicePage> createState() => _DicePageState();
}

class _DicePageState extends State<DicePage> {
  int leftDiceNumeber = 1;
  int rightDiceNumber = 1;

  @override
  void initState() {
    super.initState();
    ShakeDetector detector = ShakeDetector.autoStart(onPhoneShake: () {
      // Do stuff on phone shake
      roll();
      print("Shaking");
    });
  }

  final player = AudioCache();

  void roll() {
    setState(() {
      leftDiceNumeber = Random().nextInt(6) + 1;
      rightDiceNumber = Random().nextInt(6) + 1;
      print('Rolling');
      player.play('rollingSound.mp3');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        children: [
          Expanded(
            child: TextButton(
              onPressed: () {
                roll();
              },
              child: Image.asset('images/dice$leftDiceNumeber.png'),
            ),
          ),
          Expanded(
            child: TextButton(
              onPressed: () {
                roll();
              },
              child: Image.asset('images/dice$rightDiceNumber.png'),
            ),
          ),
        ],
      ),
    );
  }
}
