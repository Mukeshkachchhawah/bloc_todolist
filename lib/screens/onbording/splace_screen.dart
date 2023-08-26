import 'dart:async';

import 'package:bloc_with_sqflite_example/screens/home.dart';
import 'package:flutter/material.dart';

class Splace_Screen extends StatefulWidget {
  const Splace_Screen({super.key});

  @override
  State<Splace_Screen> createState() => _Splace_ScreenState();
}

class _Splace_ScreenState extends State<Splace_Screen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(milliseconds: 2), () { 
      Navigator.push(context, MaterialPageRoute(builder: (context) => Home_Page(),));
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
                radius: 80,
                child: Padding(
                  padding: const EdgeInsets.all(30),
                  child: Center(
                      child: Image.asset(
                    "assets/icons/tod-icon.png",
                    fit: BoxFit.cover,
                  )),
                )),
                SizedBox(
                  height: 20
                ),
                Text("ToDo App", style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),)
          ],
        ),
      ),
    );
  }
}
