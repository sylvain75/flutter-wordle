import 'package:flutter/material.dart';

import '../components/custom_keyboard.dart';
import '../components/block.dart';
import '../components/custom_keyboard_clone.dart';
import './Playground.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController _controller = TextEditingController();
// declarations
  bool oTurn = true;

// 1st player is O
  List<String> displayElement = ['', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', ''];
  int oScore = 0;
  int xScore = 0;
  int filledBoxes = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo[900],
      body: Column(
        children: <Widget>[
          Expanded(

            // creating the ScoreBoard
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'Player X',
                          style: TextStyle(fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                        Text(
                          xScore.toString(),
                          style: TextStyle(fontSize: 20,color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text('Player O', style: TextStyle(fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white)
                        ),
                        Text(
                          oScore.toString(),
                          style: TextStyle(fontSize: 20,color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(

            // Creating the Board for Tic tac toe
            flex: 4,
            child: GridView.builder(
                itemCount: 25,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 5),
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      _tapped(index);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.greenAccent)),
                      child: Center(
                        child: Text(
                          displayElement[index],
                          style: TextStyle(color: Colors.white, fontSize: 35),
                        ),
                        // child: TextField(
                        //     maxLength: 1,
                        //     style: TextStyle(fontSize: 40,color: Colors.greenAccent),
                        //     textAlign: TextAlign.center,
                        //     decoration: const InputDecoration(
                        //       // labelText: 'Enter Name',
                        //       border: InputBorder.none,
                        //     ),
                        //   onChanged: _onChangedText(text),
                        // ),
                      ),
                    ),
                  );
                }),
          ),
          // Expanded(child: Playground())
          // Expanded(child: CustomKeyboardClone(onTextInput: _onTextInput('bob')))
          // Expanded(child: Block(myCallback: _onBlock(13)))
          // CustomKeyboard(onTextInput: _onTextInput('bob')),
            // Button for Clearing the Enter board
            // as well as Scoreboard to start allover again
            //   child: Container(
            //     child: Row(
            //       mainAxisAlignment: MainAxisAlignment.center,
            //       children: <Widget>[
            //         RaisedButton(
            //           color: Colors.indigo[50],
            //           textColor: Colors.red,
            //           onPressed: null,
            //           child: Text("Clear Score Board"),
            //         ),
            //       ],
            //     ),
            //   ))
        ],
      ),
    );
  }

  _onBlock(int num) {
    print("Hello  ${num}");
  }
  _onTextInput(String myText) {
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
    return {};
  }

  void _onBackspace() {
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


  // _onBackspace() {
  //   print('backspace');
  // }
  //
  // _onTextInput( String text) {
  //   print(text);
  // }
// filling the boxes when tapped with X
// or O respectively and then checking the winner function
  void _tapped(int index) {
    setState(() {
      if (oTurn && displayElement[index] == '') {
        displayElement[index] = 'O';
        filledBoxes++;
      } else if (!oTurn && displayElement[index] == '') {
        displayElement[index] = 'X';
        filledBoxes++;
      }

      oTurn = !oTurn;
      // _checkWinner();
    });
  }

}
