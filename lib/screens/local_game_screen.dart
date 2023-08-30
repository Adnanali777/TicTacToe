import 'package:flutter/material.dart';
import 'package:tictactoe/resources/game_methods.dart';
import 'package:tictactoe/utilities/colors.dart';
import 'package:tictactoe/utilities/scoreboard.dart';

class LocalGame extends StatefulWidget {
  static const routeName = '/localGameScreen';
  const LocalGame({super.key});

  @override
  State<LocalGame> createState() => _LocalGameState();
}

class _LocalGameState extends State<LocalGame> {
  int player1pts = 0;
  int player2pts = 0;
  List<String> _boardItems = ['', '', '', '', '', '', '', '', ''];
  bool isPlayer1Turn = true;
  int _filledBoxes = 0;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(
            height: 60,
          ),
          Scoreboard(
            isLocal: true,
            player1pts: player1pts,
            player2pts: player2pts,
          ),
          ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: size.height * 0.7,
              maxWidth: 500,
            ),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: GridView.builder(
                itemCount: 9,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3, mainAxisSpacing: 8, crossAxisSpacing: 8),
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () async{
                      if (isPlayer1Turn) {
                        setState(() {
                          _boardItems[index] = 'X';
                          isPlayer1Turn = !isPlayer1Turn;
                          _filledBoxes += 1;
                        });
                      } else {
                        setState(() {
                          _boardItems[index] = 'O';
                          isPlayer1Turn = !isPlayer1Turn;
                          _filledBoxes += 1;
                        });
                      }
                      // setState(() {
                      //   isPlayer1Turn = !isPlayer1Turn;
                      // });

                      var result = await GameMethods().checkWinner(
                          context: context,
                          boardItems: _boardItems,
                          boardFilledBoxes: _filledBoxes);
                      print(result);

                      if (result == 'X') {
                        setState(() {
                          _boardItems = ['', '', '', '', '', '', '', '', ''];
                          player1pts += 1;
                          _filledBoxes = 0;
                          isPlayer1Turn = true;
                        });
                      }

                      else if (result == 'O') {
                        setState(() {
                          _boardItems = ['', '', '', '', '', '', '', '', ''];
                          player2pts += 1;
                          _filledBoxes = 0;
                          isPlayer1Turn = true;
                        });
                      }

                      else if(result == 'end') {
                        setState(() {
                          _boardItems = ['', '', '', '', '', '', '', '', ''];
                          _filledBoxes = 0;
                          isPlayer1Turn = true;
                        });
                      } 
                    },
                    child: Container(
                      decoration: const BoxDecoration(
                          // border: Border.all(
                          //   color: Colors.white24,
                          // ),
                          color: gridCellColor),
                      child: Center(
                        child: AnimatedSize(
                          duration: Duration(milliseconds: 150),
                          child: Text(
                            _boardItems[index],
                            style: TextStyle(
                                color: _boardItems[index] == 'X'
                                    ? x_color
                                    : o_color,
                                fontWeight: FontWeight.bold,
                                fontSize: 100,
                                shadows: _boardItems[index] == 'X'
                                    ? [
                                        const Shadow(
                                          blurRadius: 15,
                                          color: Colors.redAccent,
                                        ),
                                      ]
                                    : [
                                        const Shadow(
                                          blurRadius: 15,
                                          color: Colors.yellowAccent,
                                        ),
                                      ]),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          const SizedBox(height: 20,),
          Text(isPlayer1Turn ? 'Player 1\'s turn' : 'Player 2\'s turn')
        ],
      ),
    );
  }
}
