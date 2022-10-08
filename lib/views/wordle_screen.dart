import 'package:flurddle/components/letter_box.dart';
import 'package:flutter/material.dart';

import '../components/keyboard.dart';

class Wordle extends StatefulWidget {
  @override
  _WordleState createState() => _WordleState();
}

String findCursorPosition(Map<String, dynamic> gameState, int maxLength) {
  for (int key in gameState['guesses'].keys) {
    final item = gameState['guesses'][key];
    if (item['validation'] == null) {
      final wordLength = item['word'].length;

      return '$key:$wordLength';
    }
  }

  return 'end';
}

String mapLetterInState(Map<String, dynamic> gameState, String coords) {
  final List<int> coordsList = [int.parse(coords[2]), int.parse(coords[0])];
  if (gameState['guesses'][coordsList[0]]['word'].length >=
      (coordsList[1] + 1)) {
    return gameState['guesses'][coordsList[0]]['word'][coordsList[1]];
  } else {
    return '';
  }
}

final Map<String, dynamic> initialGameState = {
  'guesses': {
    0: {'word': 'maiso', 'validation': 'vvovxx'},
    1: {'word': 'batea', 'validation': 'vvovxx'},
    2: {'word': 'fra'},
    3: {'word': ''},
    4: {'word': ''},
  },
};

class _WordleState extends State<Wordle> {
  TextEditingController _controller = TextEditingController();
  bool _readOnly = true;
  static int numberOfLetters = 5;
  var listBoxes = List<int>.generate(numberOfLetters, (i) => i + 1);
  static Map<String, dynamic> gameState = initialGameState;

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
                    textValue: mapLetterInState(gameState,
                        '${columnItem.key.toString()}:${rowItem.key.toString()}'),
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
          IconButton(
            icon: Icon(Icons.reset_tv_rounded),
            onPressed: () {
              setState(() {
                _readOnly = !_readOnly;
                gameState = initialGameState;
              });
              print(gameState);
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
            onTextInput: (letter) {
              /*
               Should insert the letter in gameState via findCursorPosition
               Should disabled keyboard
               May have to create a class for Guess/State
              */
              final coordsString =
                  findCursorPosition(gameState, numberOfLetters);
              // eg: '1:2'
              // Assuming findCursorPosition works as intended
              final firstLevelIndex = int.parse(coordsString[0]);
              final secondLevelIndex = int.parse(coordsString[2]);
              print('$firstLevelIndex $secondLevelIndex');
              setState(() {
                gameState['guesses'][firstLevelIndex]['word'] += letter;
                if (gameState['guesses'][firstLevelIndex]['word']?.length ==
                    numberOfLetters) {
                  // Disable keyboard
                  // Api request for validation
                  // Update gameState validation for appropriate word
                  gameState['guesses'][firstLevelIndex]['validation'] =
                      'vvovxx';
                }
              });
              print(gameState);
              print(ObjectKey(list.elementAt(2).children.elementAt(1).key));
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
    // TODO implement backspace
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
