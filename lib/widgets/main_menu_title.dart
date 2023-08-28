import 'package:flutter/material.dart';
import 'package:tictactoe/utilities/colors.dart';

class TicTacToeTitle extends StatelessWidget {
  const TicTacToeTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Text(
          'NOUGHTS',
          style: TextStyle(
              fontWeight: FontWeight.w900,
              color: titleColor,
              fontSize: 65,
              shadows: [Shadow(blurRadius: 20, color: Colors.yellowAccent)]),
        ),
        // SizedBox(
        //   height: 2,
        // ),
        Text(
          'AND',
          style: TextStyle(
              fontWeight: FontWeight.w900,
              color: titleColor,
              fontSize: 65,
              shadows: [Shadow(blurRadius: 20, color: Colors.yellowAccent)]),
        ),
        // SizedBox(
        //   height: 2,
        // ),
        Text(
          'CROSSES',
          style: TextStyle(
              fontWeight: FontWeight.w900,
              color: titleColor,
              fontSize: 65,
              shadows: [Shadow(blurRadius: 20, color: Colors.yellowAccent)]),
        ),
      ],
    );
  }
}
