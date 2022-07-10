import 'package:flutter/material.dart';
import 'text_key.dart';
// import 'back_space_key.dart';

class CustomKeyboardClone extends StatelessWidget {
  // CustomKeyboardClone({
  //   Key? key,
  //   required this.onTextInput,
  //   // required this.onBackspace,
  // }) : super(key: key) {
  //   // TODO: implement
  //   // throw UnimplementedError();
  // }
  // final ValueSetter<String> onTextInput;
  // final void Function(String text) onTextInput;
  // final VoidCallback onTextInput;
  // final VoidCallback onBackspace;
  // void _textInputHandler(String text) => onTextInput.call(text);
  // void _backspaceHandler() => onBackspace?.call();
  final void Function(String) onTextInput;

  CustomKeyboardClone({required this.onTextInput});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 160,
      color: Colors.blue,
      child: Column(        // <-- Column
        children: [
          Container(child: Text('Future keyboard'))
          // buildRowOne(),    // <-- Row
          // buildRowTwo(),    // <-- Row
          // buildRowThree(),  // <-- Row
        ],
      ),
    );
  }
  // Expanded buildRowOne() {
  //   return Expanded(
  //     child: Row(
  //       children: [
  //         TextKey(
  //           text: '1',
  //           onTextInput: _textInputHandler,
  //         ),
  //         TextKey(
  //           text: '2',
  //           onTextInput: _textInputHandler,
  //         ),
  //       ],
  //     ),
  //   );
  // }
  // Expanded buildRowTwo() {
  //   ...
  // }
  // Expanded buildRowThree() {
  //   return Expanded(
  //     child: Row(
  //       children: [
  //         TextKey(
  //           text: ' ',
  //           flex: 4,
  //           onTextInput: _textInputHandler,
  //         ),
  //         BackspaceKey(
  //           onBackspace: _backspaceHandler, key: null,
  //         ),
  //       ],
  //     ),
  //   );
  // }
}