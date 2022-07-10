import 'package:flutter/material.dart';

class BackspaceKey extends StatelessWidget {
  const BackspaceKey({
    required Key? key,
    required this.onBackspace,
    this.flex = 1,
  }) : super(key: key);
  final VoidCallback onBackspace;
  final int flex;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flex,
      child: Padding(
        padding: const EdgeInsets.all(1.0),
        child: Material(
          color: Colors.blue.shade300,
          child: InkWell(
            onTap: () {
              onBackspace.call();
            },
            child: Container(
              child: Center(
                child: Icon(Icons.backspace),
              ),
            ),
          ),
        ),
      ),
    );
  }
}