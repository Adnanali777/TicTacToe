import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:tictactoe/provider/room_data_provider.dart';
import 'package:tictactoe/resources/game_methods.dart';
import 'package:tictactoe/resources/socket_client.dart';
import 'package:tictactoe/screens/game_screen.dart';

class SocketMethods {
  final _socketclient = SocketClient.instance.socket!;

  Socket get socketClient => _socketclient;

  //emit
  void createRoom(String nickname) {
    if (nickname.isNotEmpty) {
      _socketclient.emit('createRoom', {
        'nickname': nickname,
      });
    }
  }

  void joinRoom(String nickname, String roomID) {
    if (nickname.isNotEmpty && roomID.isNotEmpty) {
      _socketclient.emit('joinRoom', {'nickname': nickname, 'roomId': roomID});
    }
  }

  void gridTapped(int index, String roomId, List<String> displayElements) {
    if (displayElements[index] == '') {
      _socketclient.emit('tap', {
        'index': index,
        'roomId': roomId,
      });
    }
  }

  //listeners
  void createRoomSuccessListener(BuildContext context) {
    _socketclient.on('createRoomSuccess', (room) {
      print(room);
      Provider.of<RoomDataProvider>(context, listen: false)
          .updateRoomData(room);
      Navigator.pushNamed(context, GameScreen.routeName);
    });
  }

  void joinRoomSuccessListener(BuildContext context) {
    _socketclient.on('joinRoomSuccess', (room) {
      print(room);
      Provider.of<RoomDataProvider>(context, listen: false)
          .updateRoomData(room);
      Navigator.pushNamed(context, GameScreen.routeName);
    });
  }

  void onErrorState(BuildContext context) {
    _socketclient.on('errorOccurred', (data) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(data)));
    });
  }

  void updatePlayersStateListener(BuildContext context) {
    _socketclient.on('updatePlayers', (playerData) {
      Provider.of<RoomDataProvider>(context, listen: false)
          .updatePlayer1(playerData[0]);
      Provider.of<RoomDataProvider>(context, listen: false)
          .updatePlayer2(playerData[1]);
    });
  }

  //for updating the created game screen when other user joins
  void updateRoomStateListener(BuildContext context) {
    _socketclient.on('updateRoom', (room) {
      print(room);
      Provider.of<RoomDataProvider>(context, listen: false)
          .updateRoomData(room);
    });
  }

  void tappedListener(BuildContext context) {
    _socketclient.on('tapped', (data) {
      Provider.of<RoomDataProvider>(context, listen: false)
          .updatedisplayElements(data['index'], data['choice']);
      Provider.of<RoomDataProvider>(context, listen: false)
          .updateRoomData(data['room']);

      //checking winner
      GameMethods().checkWinner(context:context, socketClent: _socketclient);
    });
  }

  void pointsIncreasedListener(BuildContext context) {
    _socketclient.on('pointsIncreased', (player) {
      var roomDataProvider = Provider.of<RoomDataProvider>(context, listen: false);
      print(player);
      print('winner player socketID = ${player['socketID']}');
      if(player['socketID'] == roomDataProvider.player1.socketID) {
        roomDataProvider.updatePlayer1(player);
      } else {
        roomDataProvider.updatePlayer2(player);
      }
    });
  }
}
