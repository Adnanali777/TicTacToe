import 'package:flutter/material.dart';
import 'package:tictactoe/models/player.dart';

class RoomDataProvider extends ChangeNotifier {
  Map<String,dynamic> _roomData = {};
  Player _player1 = Player(nickname: '', playerType: '', socketID: '', points: 0);
  Player _player2 = Player(nickname: '', playerType: '', socketID: '', points: 0);
  List<String> _displayElements = ['', '', '', '','', '', '', '', ''];
  int filledBoxes = 0;

  Map<String, dynamic> get roomData => _roomData;
  Player get player1 => _player1;
  Player get player2 => _player2;
  List<String> get displayElements => _displayElements;

  void updateRoomData(Map<String, dynamic> room) {
    _roomData = room;
    notifyListeners();
  }

  void updatePlayer1(Map<String, dynamic> data){
    _player1 = Player.fromMap(data);
    notifyListeners();
  }

  void updatePlayer2(Map<String, dynamic> data){
    _player2 = Player.fromMap(data);
    notifyListeners();
  }

  void updatedisplayElements(int index, String choice) {
    _displayElements[index] = choice;
    filledBoxes+=1;
    notifyListeners();
  }

  void setFilledBoxesTo0() {
    filledBoxes = 0;
  }
}