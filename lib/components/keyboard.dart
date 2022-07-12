import 'package:flutter/material.dart';
import 'package:flurddle/components/working_text_key.dart';

class CustomKeyboard extends StatelessWidget {
  CustomKeyboard({
    Key? key,
    required this.onTextInput,
    required this.onBackspace,
  }) : super(key: key);

  final ValueSetter<String> onTextInput;
  final VoidCallback onBackspace;

  void _textInputHandler(String text) => onTextInput.call(text);

  void _backspaceHandler() => onBackspace.call();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 160,
      color: Colors.blue,
      child: Column(
        children: [
          buildRowOne(),
          buildRowTwo(),
          buildRowThree(),
          buildRowFour(),
        ],
      ),
    );
  }

  Expanded buildRowOne() {
    var list = ['q', 'w', 'e', 'r', 't', 'y', 'u', 'i', 'o', 'p'];
    return Expanded(
      child: Row(
        children: [for(var item in list )  TextKey(text: item, onTextInput: _textInputHandler)],
      ),
    );  }

  Expanded buildRowTwo() {
    // final children = <Widget>[];
    // for (var i = 0; i < 10; i++) {
    //   children.add(new ListTile());
    // }
    var list = ['a', 's', 'd', 'f', 'g', 'h', 'j', 'k', 'k', 'k', 'l'];
    return Expanded(
      child: Row(
        children: [for(var item in list )  TextKey(text: item, onTextInput: _textInputHandler)],
      ),
    );
  }

  Expanded buildRowThree() {
    var list = ['z', 'x', 'c', 'v', 'b', 'b', 'n', 'm'];
    return Expanded(
      child: Row(
        children: [for(var item in list )  TextKey(text: item, onTextInput: _textInputHandler)],
      ),
    );
  }

  Expanded buildRowFour() {
    return Expanded(
      child: Row(
        children: [
          TextKey(
            text: ' ',
            flex: 4,
            onTextInput: _textInputHandler,
          ),
          BackspaceKey(
            onBackspace: _backspaceHandler,
          ),
        ],
      ),
    );
  }
}

class BackspaceKey extends StatelessWidget {
  const BackspaceKey({
    Key? key,
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