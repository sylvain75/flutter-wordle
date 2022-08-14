import 'package:flurddle/components/letter_box.dart';
import 'package:flutter/material.dart';

import '../components/keyboard.dart';

class Wordle extends StatefulWidget {
  @override
  _WordleState createState() => _WordleState();
}

class _WordleState extends State<Wordle> {
  TextEditingController _controller = TextEditingController();
  bool _readOnly = true;
  static int numberOfLetters = 5;
  var listBoxes = List<int>.generate(numberOfLetters, (i) => i + 1);

  @override
  Widget build(BuildContext context) {
    List<Row> list = listBoxes
        .asMap()
        .entries
        .map((rowItem) => Row(
            children: listBoxes
                .asMap()
                .entries
                .map((columnItem) => LetterBox(
                    key: ObjectKey(
                        '${columnItem.key.toString()}:${rowItem.key.toString()}'),
                    // '${columnItem.key.toString()}:${rowItem.key.toString()}',
                    textValue:
                        '${columnItem.key.toString()}:${rowItem.key.toString()}',
                    handleOnTap: (text) => print(ObjectKey(
                            '${columnItem.key.toString()}:${rowItem.key.toString()}')
                        .value)))
                .toList(),
            mainAxisAlignment: MainAxisAlignment.center))
        .toList();

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          SizedBox(height: 50),
          // TextField(
          //   controller: _controller,
          //   decoration: InputDecoration(
          //     border: OutlineInputBorder(
          //       borderRadius: BorderRadius.circular(3),
          //     ),
          //   ),
          //   style: TextStyle(fontSize: 24),
          //   autofocus: true,
          //   showCursor: true,
          //   readOnly: _readOnly,
          // ),
          IconButton(
            icon: Icon(Icons.keyboard),
            onPressed: () {
              setState(() {
                _readOnly = !_readOnly;
              });
            },
          ),
          // Spacer(),
          Container(
              child: Column(children: list

                  /*
                      String key = values.keys.elementAt(index);
                        Coordinates will be row : column
                        - Track where the typing should be
                        - Guesses kept in the cookies on enter key after filling row
                          - Guesses should have an ID plus list of guesses
                          - Guesses ID is the the word ID of the day
                  */
                  )),
          Spacer(),
          CustomKeyboard(
            onTextInput: (x) {
              print(x);
              print(ObjectKey(list.elementAt(2).children.elementAt(1).key));
              // _insertText(x);
            },
            onBackspace: () {
              _backspace();
            },
          ),
        ],
      ),
    );
  }

  void _insertText(String myText) {
    final text = _controller.text;
    final textSelection = _controller.selection;
    final newText = text.replaceRange(
      textSelection.start,
      textSelection.end,
      myText,
    );
    final myTextLength = myText.length;
    _controller.text = newText;
    _controller.selection = textSelection.copyWith(
      baseOffset: textSelection.start + myTextLength,
      extentOffset: textSelection.start + myTextLength,
    );
  }

  void _backspace() {
    final text = _controller.text;
    final textSelection = _controller.selection;
    final selectionLength = textSelection.end - textSelection.start;

    // There is a selection.
    if (selectionLength > 0) {
      final newText = text.replaceRange(
        textSelection.start,
        textSelection.end,
        '',
      );
      _controller.text = newText;
      _controller.selection = textSelection.copyWith(
        baseOffset: textSelection.start,
        extentOffset: textSelection.start,
      );
      return;
    }

    // The cursor is at the beginning.
    if (textSelection.start == 0) {
      return;
    }

    // Delete the previous character
    final previousCodeUnit = text.codeUnitAt(textSelection.start - 1);
    final offset = _isUtf16Surrogate(previousCodeUnit) ? 2 : 1;
    final newStart = textSelection.start - offset;
    final newEnd = textSelection.start;
    final newText = text.replaceRange(
      newStart,
      newEnd,
      '',
    );
    _controller.text = newText;
    _controller.selection = textSelection.copyWith(
      baseOffset: newStart,
      extentOffset: newStart,
    );
  }

  bool _isUtf16Surrogate(int value) {
    return value & 0xF800 == 0xD800;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
