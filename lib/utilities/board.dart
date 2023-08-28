import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tictactoe/provider/room_data_provider.dart';
import 'package:tictactoe/resources/game_methods.dart';
import 'package:tictactoe/resources/socket_methods.dart';
import 'package:tictactoe/utilities/colors.dart';

class TicTacToeBoard extends StatefulWidget {
  const TicTacToeBoard({Key? key}) : super(key: key);

  @override
  State<TicTacToeBoard> createState() => _TicTacToeBoardState();
}

class _TicTacToeBoardState extends State<TicTacToeBoard> {
  final SocketMethods _socketMethods = SocketMethods();

  void tapped(int index, String roomId, List<String> displayElements) {
    _socketMethods.gridTapped(index, roomId, displayElements);
    // GameMethods().checkWinner(context, SocketMethods().socketClient);
  }

  @override
  void initState() {
    super.initState();
    _socketMethods.tappedListener(context);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    RoomDataProvider roomDataProvider = Provider.of<RoomDataProvider>(context);

    return ConstrainedBox(
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
            return AbsorbPointer(
              absorbing: roomDataProvider.roomData['turn']['socketID'] !=
                  _socketMethods.socketClient.id,
              child: GestureDetector(
                onTap: () => tapped(index, roomDataProvider.roomData['_id'],
                    roomDataProvider.displayElements),
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
                        roomDataProvider.displayElements[index],
                        style: TextStyle(
                            color: roomDataProvider.displayElements[index] == 'X' ? x_color : o_color,
                            fontWeight: FontWeight.bold,
                            fontSize: 100,
                            shadows: roomDataProvider.displayElements[index] == 'X' ? [
                              Shadow(
                                blurRadius: 15,
                                color: Colors.redAccent,
                              ),
                            ] : [
                              Shadow(
                                blurRadius: 15,
                                color: Colors.yellowAccent,
                              ),
                            ]),
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
