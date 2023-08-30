import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tictactoe/provider/room_data_provider.dart';
import 'package:tictactoe/resources/socket_methods.dart';
import 'package:tictactoe/utilities/board.dart';
import 'package:tictactoe/utilities/scoreboard.dart';
import 'package:tictactoe/utilities/waiting_lobby.dart';

class GameScreen extends StatefulWidget {
  static String routeName = '/gameScreen';
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  final SocketMethods _socketMethods = SocketMethods();

  @override
  void initState() {
    _socketMethods.updateRoomStateListener(context);
    _socketMethods.updatePlayersStateListener(context);
    _socketMethods.pointsIncreasedListener(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var roomInfo = Provider.of<RoomDataProvider>(context).roomData;
    return Scaffold(
        body: roomInfo['isJoin']
            ? const WaitingLobby()
            : SafeArea(
                child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 60,
                  ),
                  Scoreboard(isLocal: false,),
                  const TicTacToeBoard(),
                  Text('${roomInfo['turn']['nickname']}\'s turn')
                ],
              )));
  }
}
