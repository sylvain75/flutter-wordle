import 'package:flutter/material.dart';

class Block extends StatelessWidget {
  final void Function(int) myCallback;

  Block({required this.myCallback});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10.0),
      color: Color(0xFF722662),
      child: Center(
        child: GestureDetector(
          onTap: ()=>myCallback(12),
          child: Text(
            'Button',
            style: TextStyle(
              color: Color(0xFFFFFFFF),
              fontSize: 22.0,
            ),
          ),
        ),
      ),
    );
  }
}