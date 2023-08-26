import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class UpDate extends StatefulWidget {
  const UpDate({super.key});

  @override
  State<UpDate> createState() => _UpDateState();
}

class _UpDateState extends State<UpDate> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Update"),
      ),
    );
  }
}