import 'package:flutter/material.dart';
import 'package:tictactoe/resources/game_methods.dart';
import 'package:tictactoe/utilities/colors.dart';

void showSnackBar(BuildContext context, String content) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(content),
    ),
  );
}

showGameDialog(BuildContext context, String text) async{
  await showDialog(
      barrierDismissible: false,
      context: context,
      
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          backgroundColor: gridCellColor,
          title: Text(text,style: TextStyle(color: o_color),),
          actions: [
            TextButton(
              onPressed: () {
                GameMethods().clearBoard(context);
                Navigator.of(context).pop(true);
              },
              child: const Text(
                'Play Again',
              ),
            ),
          ],
        );
      });
}