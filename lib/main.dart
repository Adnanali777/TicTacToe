import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tictactoe/provider/room_data_provider.dart';
import 'package:tictactoe/screens/create_room.dart';
import 'package:tictactoe/screens/game_screen.dart';
import 'package:tictactoe/screens/join_room.dart';
import 'package:tictactoe/screens/main_menu.dart';
import 'package:tictactoe/utilities/colors.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => RoomDataProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'TicTacToe',
        theme: ThemeData.dark().copyWith(
            scaffoldBackgroundColor: bgColor_2,
          ),
          routes: {
            MainMenuScreen.routeName: (context) => const MainMenuScreen(),
            JoinRoomScreen.routeName: (context) => const JoinRoomScreen(),
            CreateRoomScreen.routeName: (context) => const CreateRoomScreen(),
            GameScreen.routeName : (context) => const GameScreen()
            // GameScreen.routeName: (context) => const GameScreen(),
          },
          initialRoute: MainMenuScreen.routeName,
        
      ),
    );
  }
}

