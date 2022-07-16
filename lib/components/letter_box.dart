import 'package:flutter/material.dart';

class LetterBox extends StatelessWidget {

  const LetterBox({
    Key? key,
    this.textValue = ' ',
    this.hasBorderRight = true,
    this.hasBorderLeft = true,
    this.hasBorderTop = true,
    this.hasBorderBottom = true,
  }) : super(key: key);

  final String textValue;
  static const bool isValid = false;
  static const bool hasWrongPosition = false;
  final bool hasBorderRight;
  final bool hasBorderLeft;
  final bool hasBorderTop;
  final bool hasBorderBottom;

  @override
  Widget build(BuildContext context) {
    const colorValue = isValid ? 0xFFB9F6CA : hasWrongPosition ? 0xFFFFFF00 : 0xffbbdefd;
    // const int colorValue = 0xffbbdefd;
    // const int colorValue = isValid ? 0xffbbdefd : 0xffbbdefd;
    return Container(
      height: 35.0,
      width: 35.0,
      decoration: BoxDecoration(
        color: const Color(colorValue),
        // image: const DecorationImage(
        //   image: NetworkImage('https://flutter.github.io/assets-for-api-docs/assets/widgets/owl-2.jpg'),
        //   fit: BoxFit.cover,
        // ),
        border: Border(
          right: BorderSide(width: hasBorderRight ? 1 : 0, color: Colors.black),
          left: BorderSide(width: 1, color: Colors.black),
          top: BorderSide(width: 1, color: Colors.black),
          bottom: BorderSide(width: 1, color: Colors.black),
        ),
        // borderRadius: BorderRadius.circular(12),
      ),
      child:
        // padding: EdgeInsets.all(8.0),
        Align(
          alignment: Alignment.topCenter,
          child:
          Text(this.textValue, style: TextStyle(
            color: Colors.black,
            fontSize: 22.0
          ),),
        )
    );
  }
}
