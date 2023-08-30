import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:tictactoe/provider/room_data_provider.dart';
import 'package:tictactoe/utilities/utils.dart';

class GameMethods {
  checkWinner(
      {required BuildContext context,
      Socket? socketClent,
      List<String>? boardItems,
      int? boardFilledBoxes}) async{
    RoomDataProvider roomDataProvider =
        Provider.of<RoomDataProvider>(context, listen: false);

    String winner = '';

    if (boardItems != null) {
      if (boardItems[0] ==
              boardItems[1] &&
          boardItems[0] ==
              boardItems[2] &&
          boardItems[0] != '') {
        winner = boardItems[0];
      }
      if (boardItems[3] ==
              boardItems[4] &&
          boardItems[3] ==
              boardItems[5] &&
          boardItems[3] != '') {
        winner = boardItems[3];
      }
      if (boardItems[6] ==
              boardItems[7] &&
          boardItems[6] ==
              boardItems[8] &&
          boardItems[6] != '') {
        winner = boardItems[6];
      }

      // Checking Column
      if (boardItems[0] ==
              boardItems[3] &&
          boardItems[0] ==
              boardItems[6] &&
          boardItems[0] != '') {
        winner = boardItems[0];
      }
      if (boardItems[1] == boardItems[4] && boardItems[1] == boardItems[7] && boardItems[1] != '') {
        winner = boardItems[1];
      }
      if (boardItems[2] ==
              boardItems[5] &&
          boardItems[2] ==
              boardItems[8] &&
          boardItems[2] != '') {
        winner = boardItems[2];
      }

      // Checking Diagonal
      if (boardItems[0] ==
              boardItems[4] &&
          boardItems[0] ==
              boardItems[8] &&
          boardItems[0] != '') {
        winner = boardItems[0];
      }
      if (boardItems[2] ==
              boardItems[4] &&
          boardItems[2] ==
              boardItems[6] &&
          boardItems[2] != '') {
        winner = boardItems[2];
      } else if (boardFilledBoxes == 9) {
        winner = '';
        await showGameDialog(context, 'Draw');
        return 'end';
      }

      if (winner != '') {
        if (winner == 'X') {
          await showGameDialog(context, 'Player 1 won!');
          // print(res);
          // if(res) {
            return 'X';
          //}
        } else {
          await showGameDialog(context, 'Player 2 won!');
          //if(res) {
            return 'O';
          //}
        }
      }
    } else {
      // Checking rows
      if (roomDataProvider.displayElements[0] ==
              roomDataProvider.displayElements[1] &&
          roomDataProvider.displayElements[0] ==
              roomDataProvider.displayElements[2] &&
          roomDataProvider.displayElements[0] != '') {
        winner = roomDataProvider.displayElements[0];
      }
      if (roomDataProvider.displayElements[3] ==
              roomDataProvider.displayElements[4] &&
          roomDataProvider.displayElements[3] ==
              roomDataProvider.displayElements[5] &&
          roomDataProvider.displayElements[3] != '') {
        winner = roomDataProvider.displayElements[3];
      }
      if (roomDataProvider.displayElements[6] ==
              roomDataProvider.displayElements[7] &&
          roomDataProvider.displayElements[6] ==
              roomDataProvider.displayElements[8] &&
          roomDataProvider.displayElements[6] != '') {
        winner = roomDataProvider.displayElements[6];
      }

      // Checking Column
      if (roomDataProvider.displayElements[0] ==
              roomDataProvider.displayElements[3] &&
          roomDataProvider.displayElements[0] ==
              roomDataProvider.displayElements[6] &&
          roomDataProvider.displayElements[0] != '') {
        winner = roomDataProvider.displayElements[0];
      }
      if (roomDataProvider.displayElements[1] ==
              roomDataProvider.displayElements[4] &&
          roomDataProvider.displayElements[1] ==
              roomDataProvider.displayElements[7] &&
          roomDataProvider.displayElements[1] != '') {
        winner = roomDataProvider.displayElements[1];
      }
      if (roomDataProvider.displayElements[2] ==
              roomDataProvider.displayElements[5] &&
          roomDataProvider.displayElements[2] ==
              roomDataProvider.displayElements[8] &&
          roomDataProvider.displayElements[2] != '') {
        winner = roomDataProvider.displayElements[2];
      }

      // Checking Diagonal
      if (roomDataProvider.displayElements[0] ==
              roomDataProvider.displayElements[4] &&
          roomDataProvider.displayElements[0] ==
              roomDataProvider.displayElements[8] &&
          roomDataProvider.displayElements[0] != '') {
        winner = roomDataProvider.displayElements[0];
      }
      if (roomDataProvider.displayElements[2] ==
              roomDataProvider.displayElements[4] &&
          roomDataProvider.displayElements[2] ==
              roomDataProvider.displayElements[6] &&
          roomDataProvider.displayElements[2] != '') {
        winner = roomDataProvider.displayElements[2];
      } else if (roomDataProvider.filledBoxes == 9) {
        winner = '';
        showGameDialog(context, 'Draw');
      }

      if (winner != '') {
        if (roomDataProvider.player1.playerType == winner) {
          showGameDialog(context, '${roomDataProvider.player1.nickname} won!');
          socketClent!.emit('winner', {
            'winnerSocketId': roomDataProvider.player1.socketID,
            'roomId': roomDataProvider.roomData['_id'],
          });
        } else {
          showGameDialog(context, '${roomDataProvider.player2.nickname} won!');
          socketClent!.emit('winner', {
            'winnerSocketId': roomDataProvider.player2.socketID,
            'roomId': roomDataProvider.roomData['_id'],
          });
        }
      }
    }
  }
    void clearBoard(BuildContext context) {
      RoomDataProvider roomDataProvider =
          Provider.of<RoomDataProvider>(context, listen: false);

      for (int i = 0; i < roomDataProvider.displayElements.length; i++) {
        roomDataProvider.updatedisplayElements(i, '');
      }
      roomDataProvider.setFilledBoxesTo0();
    }
}
